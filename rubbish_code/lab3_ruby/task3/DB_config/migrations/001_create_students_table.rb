require 'pg'
require_relative '../../ruby_APP/DB_config/db_config'

conn = Database.conn

conn.exec("CREATE TABLE IF NOT EXISTS students (
  id SERIAL PRIMARY KEY,
  surname VARCHAR(255),
  first_name VARCHAR(255),
  patronymic VARCHAR(255),
  phone VARCHAR(255),
  telegram VARCHAR(255),
  mail VARCHAR(255),
  git VARCHAR(255)
);")





