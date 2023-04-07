# frozen_string_literal: true

require_relative 'file_manager'
require_relative '../../Model/StudentInfo/student'
require_relative '../../Model/StudentInfo/student_display'
require_relative 'FileStrategies/txt_file_strategy'
require_relative 'FileStrategies/json_file_strategy'
require_relative 'FileStrategies/yaml_file_strategy'

class StudentFileManager

	include FileManager

	def initialize(file_path)
		super
		set_strategy
	end

	def get_display_list(record_count, page, data_list = nil)
		start_index = record_count * (page - 1)
		end_index = start_index + record_count
		display_data = @data[start_index..end_index]
		DataList.new display_data unless data_list
		data_list.set_data display_data if data_list
	end

	def create(obj)
		obj.id = 0
		obj.id = @data.map { |s| s[:id] }.max + 1 if @data != []
		@data << obj.to_json
		@strategy.save_data(@data)
	end

	def read(id)
		data = @data.find { |element| element[:id] == id }
		Student.new data
	end

	def update(id, obj)
		updated_student = obj.to_json
		updated_student[:id] = id
		index = @data.find_index { |element| element[:id] = id }
		@data[index] = updated_student
		@strategy.save_data(@data)
	end

	def delete(id)
		@data.delete_at(id)
		@strategy.save_data(@data)
	end

	def count
		@data.count
	end

	def read_all
		@data.map { |student_data| Student.new student_data }
	end

	def file_path=(value)
		@file_path = value
		set_strategy
	end

	private
	def set_strategy
		case File.extname(@file_path)
		when '.txt'
			@strategy = TXTFileStrategy.new @file_path
		when '.json'
			@strategy = JSONFileStrategy.new @file_path
		when '.yaml'
			@strategy = YAMLFileStrategy.new @file_path
		else
			@data = []
			return
		end
		@data = @strategy.load_data
	end
end
