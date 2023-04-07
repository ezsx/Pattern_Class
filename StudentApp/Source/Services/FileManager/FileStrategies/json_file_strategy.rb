# frozen_string_literal: true

require_relative 'file_strategy'
require 'json'

class JSONFileStrategy

	include FileStrategy

	def load_data
		return [] unless File.exist?(@file_path)
		file = File.read(@file_path)
		JSON.parse(file, symbolize_names: true)
	end

	def save_data(data)
		return unless File.exist?(@file_path)
		File.open(@file_path, 'w') { |file| file.write(JSON.pretty_generate(data)) }
	end
end
