# frozen_string_literal: true

require 'pg'
require_relative '../../Model/StudentInfo/student_display'
require_relative '../../Model/StudentInfo/student'
require_relative '../data_manager'

class StudentRepository

	include DataManager

	def self.name
		'students'
	end

	def initialize(manager)
		@manager = manager
		# Create students table
		@manager.create_table(StudentRepository.name, sql_values)
	end

	def create(student)
		@manager.insert(StudentRepository.name, student.to_data)
	end

	def read(id)
		result = @manager.select_record(StudentRepository.name, id: id)
		Student.from_record result.first if result.any?
	end

	def update(student)
		@manager.update(StudentRepository.name, student.id, student.to_data)
	end

	def delete(id)
		@manager.delete(StudentRepository.name, id)
	end

	def read_all
		data = @manager.select_all StudentRepository.name
		data.map { |elem| Student.from_record elem }
	end

	def get_display_list(record_count, page)
		data = @manager.get_list(StudentRepository.name, record_count, page)
		data.map { |elem| Student.from_record elem }
	end

	def count
		@manager.count StudentRepository.name
	end

	private
	def sql_values
		"id SERIAL PRIMARY KEY,
		name VARCHAR(255),
		middle_name VARCHAR(255),
		surname VARCHAR(255),
		git VARCHAR(255),
		telegram VARCHAR(255),
		email VARCHAR(255),
		phone VARCHAR(255)"
	end
end
