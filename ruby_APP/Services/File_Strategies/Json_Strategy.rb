# frozen_string_literal: true

require_relative 'file_strategy'
require_relative '../../Student_info/student_display'
require 'json'

class JSONFileStrategy
	include FileStrategy

	def load_data(file_path)
		json_data = File.read(file_path)
		parsed_data = JSON.parse(json_data, symbolize_names: true)
		parsed_data.map { |student_data| StudentDisplay.new Student.new student_data }
	rescue => e
		raise "Exception: #{e.message}"
	end

	def save_data(file_path, data)
		File.write(file_path, data.map {|student| student.to_json}.to_json)
	rescue => e
		raise "Exception: #{e.message}"
	end
end