# frozen_string_literal: true

require_relative 'file_strategy'

class TXTFileStrategy
  include FileStrategy

  def load_data(file_path)
    File.readlines(file_path).map { |line| StudentDisplay.new Student.from_string(line) }
  rescue => e
    raise "Exception: #{e.message}"
  end

  def save_data(file_path, data)
    File.write(file_path, data.map { |student| student.to_s }.join("\n"))
  rescue => e
    raise "Exception: #{e.message}"
  end
end