# frozen_string_literal: true

require_relative '../ruby_APP/Student_info/student'
require_relative '../ruby_APP/Student_info/student_display'
require 'pg'

class StudentRepository

  def self.name
    'students'
  end

  def initialize(adapter)
    @manager = adapter
    # Create students table
    adapter.create_table(StudentRepository.name, sql_values)
  end

  def create(student)
    @manager.insert(name, student.to_data)
  end

  def read(id)
    result = @manager.select_record(name, id: id)
    Student.from_record result.first if result.any?
  end

  def update(student)
    @manager.update(name, student.id, student.to_data)
  end

  def delete(id)
    @manager.delete(name, id)
  end

  def get_display_list(record_count, page)
    data = @manager.get_list(StudentRepository.name, record_count, page)
    students = []
    data.map do |elem|
      students.append Student.from_record elem
    end
    students
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