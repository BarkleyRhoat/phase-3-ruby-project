# frozen_string_literal: true

require_relative "config/environment"
require "active_record"

# Load Active Record migration tasks
load "active_record/railties/databases.rake"

# Point AR tasks at our database config
ActiveRecord::Tasks::DatabaseTasks.db_dir = "db"
ActiveRecord::Tasks::DatabaseTasks.migrations_paths = ["db/migrate"]
ActiveRecord::Tasks::DatabaseTasks.database_configuration =
  YAML.load_file("config/database.yml")
ActiveRecord::Tasks::DatabaseTasks.env = ENV.fetch("RACK_ENV", "development")
ActiveRecord::Tasks::DatabaseTasks.root = Pathname.new(Dir.pwd)

desc "Start the console"
task :console do
  ActiveRecord::Base.logger = Logger.new($stdout)
  Pry.start
end

desc "Seed the database"
task :seed do
  load "db/seeds.rb"
end
