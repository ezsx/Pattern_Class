require 'sequel'

DB = Sequel.connect(dbname: 'postgres',
                    user: 'postgres',
                    password: 'ezsx',
                    host: 'localhost',
                    port: 5432)

# Run all migration files in the migrations directory
Sequel.extension :migration
Sequel::Migrator.run(DB, 'migrations')

# Load all seed files in the seeds directory
Dir[File.join(File.dirname(__FILE__), 'seeds', '*.rb')].each do |file|
  require file
end

