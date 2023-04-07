# frozen_string_literal: true

class DataTable

	attr_reader :data

	def initialize(data)
		@data = data
	end

	def [](row, col)
		@data[row][col]
	end

	def row_count
		@data.size
	end

	def column_count
		@data[0].size
	end

	def to_s
		data.map { |elem| elem.to_s }
	end
end
