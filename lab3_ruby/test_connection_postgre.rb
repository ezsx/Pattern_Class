require 'pg'

# Connect to the PostgreSQL database
conn = PG.connect(dbname: 'postgres', user: 'postgres', password: 'ezsx', host: 'localhost', port: 5432)

# Create a table named "users" with two columns: "id" and "name"
conn.exec("CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR)")

# Insert some data into the "users" table
conn.exec("INSERT INTO users (name) VALUES ('Alice')")
conn.exec("INSERT INTO users (name) VALUES ('Bob')")
conn.exec("INSERT INTO users (name) VALUES ('Charlie')")

# Retrieve the data from the "users" table and print it to the console
result = conn.exec("SELECT * FROM users")
result.each do |row|
  puts "ID: #{row['id']}, Name: #{row['name']}"
end

# Close the connection to the PostgreSQL database
conn.close

# output
#
# ID: 1, Name: Alice
# ID: 2, Name: Bob
# ID: 3, Name: Charlie