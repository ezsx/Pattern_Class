# frozen_string_literal: true

require_relative 'file_strategy'
require 'yaml'

class YAMLFileStrategy
	include FileStrategy

	def load_data
		return [] unless File.exist?(@file_path)
		YAML.load_file(@file_path)
	end

	def save_data(data)
		return unless File.exist?(@file_path)
		File.open(@file_path, 'w') { |file| file.write(YAML.dump(data)) }
	end
end
