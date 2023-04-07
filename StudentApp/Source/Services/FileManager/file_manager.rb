
require_relative '../data_manager'
require_relative '../../Model/data_list'

module FileManager

	include DataManager

	attr_reader :file_path

	def initialize(file_path)
		@file_path = file_path
	end

	def get_display_list(record_count, page, data_list = nil)
	end

	def create(obj)
	end

	def read(id)
	end

	def update(index, obj)
	end

	def delete(index)
	end

	def count
	end

	def read_all
	end

	# def sort(symbol) # :surname for student
	# 	@data.sort_by! { |obj| obj[symbol] }
	# end
end

