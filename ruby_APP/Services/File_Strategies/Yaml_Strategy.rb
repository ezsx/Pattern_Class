# frozen_string_literal: true

require_relative 'file_strategy'
require_relative '../../Student_info/student_display'
require 'yaml'

class YAMLFileStrategy
  include FileStrategy

  def load_data(file_path)
    students = YAML.load_file(file_path)
    students.map { |student| StudentDisplay.new student }
  rescue => e
    raise "Exception: #{e.message}"
  end

  def save_data(file_path, data)
    File.open(file_path, 'w') { |file| file.write(data.to_yaml) }
  rescue => e
    raise "Exception: #{e.message}"
  end
end