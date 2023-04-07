# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../Source/Model/StudentInfo/student_display_list'
require_relative '../Source/Model/StudentInfo/student'
require_relative '../Source/Model/StudentInfo/student_display'

class TestStudentDisplayList < Minitest::Test
	def test_get_data
		def create_student(id)
			Student.new(
				id: id,
				surname: 'Harvey',
				name: 'Steve',
				middle_name: 'Biden',
				contact_info: { phone: '+1234567890', email: 'Steve@email.ru' },
				git: 'https://github.com/Steve'
			)
		end
		list = StudentDisplayList.new(
			[
				StudentDisplay.new(create_student(0)),
				StudentDisplay.new(create_student(1)),
				StudentDisplay.new(create_student(2))
			]
		)
		expected = [
			[0, "Harvey S.B.", "https://github.com/Steve", "+1234567890"],
			[1, "Harvey S.B.", "https://github.com/Steve", "+1234567890"],
			[2, "Harvey S.B.", "https://github.com/Steve", "+1234567890"]
		]

		assert_equal expected, list.get_data.data
	end
end
