# Loading bundler and  gems
require 'bundler'
Bundler.require #loads all things in the gem file

# Loading my objects
$LOAD_PATH << '.'
require 'models/student'