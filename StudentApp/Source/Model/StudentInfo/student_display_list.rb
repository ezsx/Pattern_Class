# frozen_string_literal: true

require_relative '../data_table'
require_relative '../data_list'

class StudentDisplayList < DataList

	def get_names
		%w[Id Initials Git Contact]
	end

	def get_data
		@data.map.with_index do |element, index|
			[index, element.initials, element.git.to_s, element.single_contact]
			# [index, *%w[initials git single_contact].map { |attr| element.instance_variable_get("@#{attr}").to_s }]
		end.then { |passing_data| DataTable.new(passing_data) }
	end

	def select_obj(number)
		@selected << @data[number].id unless @data.count > number
	end

	# def sort_by_initials # TODO: should be implemented in data manager
	# 	@data = @data.sort { |student1, student2| student1.initials <=> student2.initials }
	# end
end