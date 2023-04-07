# frozen_string_literal: true

require_relative 'data_table'

class DataList

	attr_reader :selected

	def initialize(data = [])
		@data = data
		@selected = []
	end

	def set_data(new_data)
		@data = new_data
	end

	def [](index)
		@data[index]
	end

	def size
		@data.size
	end

	def each
		@data.each { |element| yield element }
	end

	def select_obj(number)
		@selected << number
	end

	def get_selected
		@selected
	end

	def reset_selected
		@selected = []
	end

	def get_data
		@data.map.with_index do |element, index|
			[index, *get_names[1..].map { |attr| element.instance_variable_get("@#{attr}") }]
		end.then { |passing_data| DataTable.new(passing_data) }
	end

	def get_names
		@data[0].instance_variables.map { |var| var.to_s.sub('@', '') }
	end
end
