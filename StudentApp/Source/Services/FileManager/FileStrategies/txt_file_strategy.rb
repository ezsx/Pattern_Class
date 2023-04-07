# frozen_string_literal: true

require_relative 'file_strategy'

class TXTFileStrategy
	include FileStrategy

	def load_data
		return [] unless File.exist?(@file_path)

		data = []
		File.foreach(@file_path) do |line|
			attributes = line.chomp.split(', ')
			obj_hash = {}
			attributes.each do |attr|
				key, value = attr.split(': ')
				obj_hash[key.to_sym] = value
			end
			data << obj_hash
		end
		data
	end

	def save_data(data)
		return unless File.exist?(@file_path)

		File.open(@file_path, 'w') do |file|
			data.each do |obj|
				file.puts obj.map { |k, v| "#{k}: #{v}" }.join(', ')
			end
		end
	end
end
