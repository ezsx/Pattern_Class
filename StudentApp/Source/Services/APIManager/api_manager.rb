# frozen_string_literal: true

require 'pg'
require 'singleton'

class APIManager

	include Singleton

	private_class_method :new
	def initialize
		@conn ||= PG.connect(
			host: 'localhost',
			port: '5432',
			dbname: 'postgres',
			user: 'postgres',
			password: 'snowlukin'
		)
	end

	def execute(query)
		@conn.exec(query)
	end

	def insert(table, data)
		columns = data.keys.map { |key| "#{key}" }.join(', ')
		values = data.values.map { |value| "'#{value}'" }.join(', ')
		execute("INSERT INTO #{table} (#{columns}) VALUES (#{values})")
	end

	def select_record(table, conditions = {})
		where_clause = conditions.map { |key, value| "#{key} = '#{value}'" }.join(' AND ')
		where_clause = "WHERE #{where_clause}" unless where_clause.empty?
		execute("SELECT * FROM #{table} #{where_clause}")
	end

	def update(table, id, data)
		set_clause = data.map { |key, value| "#{key} = '#{value}'" }.join(', ')
		execute("UPDATE #{table} SET #{set_clause} WHERE id = '#{id}'")
	end

	def delete(table, id)
		execute("DELETE FROM #{table} WHERE id = #{id}")
	end

	def select_all(table)
		execute("SELECT * FROM #{table}")
	end

	def count(table)
		result = execute("SELECT COUNT(*) FROM #{table}")
		result[0]['count'].to_i
	end

	def create_table(name, values)
		execute("CREATE TABLE IF NOT EXISTS #{name} (#{values});")
	end

	def get_list(table, records_count, page)
		execute "select * from #{table} limit #{records_count} offset #{page}"
	end
end
