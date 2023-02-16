
require 'pg'

class Database
  def self.conn
    @conn ||= PG.connect(dbname: 'postgres',
                          user: 'postgres',
                          password: 'ezsx',
                          host: 'localhost',
                          port: 5432)
  end
end
