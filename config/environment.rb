require 'sqlite3'
require 'pry'
require_relative '../lib/student'

DB = {:conn => SQLite3::Database.new("db/students.db")}
# this is a constant that is a key/value pair