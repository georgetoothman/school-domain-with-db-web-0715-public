class Student
  attr_accessor :id, :name, :tagline, :github, 
                :twitter, :blog_url, :image_url, :biography

  def self.create_table
    sql = "CREATE TABLE students (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      tagline TEXT,
      github TEXT,
      twitter TEXT,
      blog_url TEXT,
      image_url TEXT,
      biography TEXT
      )"
    DB[:conn].execute(sql)
  end
  ## this is most similiar to migrations in active record

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def insert
    sql = "INSERT INTO students 
    (name, tagline, github, twitter, blog_url, image_url, biography) 
    VALUES (?,?,?,?,?,?,?)"
    DB[:conn].execute(sql, self.name, self.tagline, self.github, self.twitter, self.blog_url, self.image_url, self.biography)
    sql = "SELECT last_insert_rowid() FROM students"
    self.id = DB[:conn].execute(sql).join('').to_i
    # last_id = "SELECT last_insert_rowid() FROM students LIMIT 1"
    # id_array = DB[:conn].execute(last_id)
    # self.id = id_array.flatten.first
  end

  def self.new_from_db(row)
    student = Student.new
    student.id = row[0]
    student.name = row[1]
    student.tagline = row[2]
    student.github = row[3]
    student.twitter = row[4]
    student.blog_url = row[5]
    student.image_url = row[6]
    student.biography = row[7]
    student
    # keys = [:id, :name, :tagline, :github, :twitter, :blog_url, :image_url, :biography]
    # keys.each.with_object do |column, a|
    #   binding.pry   
    # end   
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    nested_row = DB[:conn].execute(sql, name)
    !nested_row.empty? ? self.new_from_db(nested_row.flatten) : nil
  end

  def update
    sql = "UPDATE students SET name = ?, tagline = ?, github = ?, twitter = ?, blog_url = ?, image_url = ?, biography = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.tagline, self.github, self.twitter, self.blog_url, self.image_url, self.biography, self.id)
  end

  def save
    self.id ? update : insert
  end
end