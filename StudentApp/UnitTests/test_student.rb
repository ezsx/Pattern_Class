# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../Source/Model/StudentInfo/student'

class TestStudent < MiniTest::Test
	def test_wrong_creation
		assert_raises(RuntimeError) do
			Student.new(
				surname: 'Harvey',
				middle_name: 'Biden',
				contact_info: { phone: '+1234567890', email: 'Steve@email.ru' },
				git: 'https://github.com/Steve'
			)
		end

		assert_raises(RuntimeError) do
			Student.new(
				name: 'Steve',
				middle_name: 'Biden',
				contact_info: { phone: '+1234567890', email: 'Steve@email.ru' },
				git: 'https://github.com/Steve'
			)
		end

		assert_raises(RuntimeError) do
			Student.new(
				surname: 'Harvey',
				name: 'Steve',
				contact_info: { phone: '+1234567890', email: 'Steve@email.ru' },
				git: 'https://github.com/Steve'
			)
		end

		assert_raises(RuntimeError) do
			Student.new(
				surname: 'Harvey',
				name: 'Steve',
				middle_name: 'Biden',
				git: 'https://github.com/Steve'
			)
		end
	end

	def test_to_json
		student = Student.new(
			surname: 'Harvey',
			name: 'Steve',
			middle_name: 'Biden',
			contact_info: { phone: '+1234567890', email: 'Steve@email.ru' },
			git: 'https://github.com/Steve'
		)

		expected = {
			id: nil,
			name: 'Steve',
			middle_name: 'Biden',
			surname: 'Harvey',
			git: "https://github.com/Steve",
			contact_info: { phone: '+1234567890', email: 'Steve@email.ru', telegram: '' }
		}

		assert_equal expected, student.to_json
	end

	def test_to_data
		student = Student.new(
			id: 0,
			surname: 'Harvey',
			name: 'Steve',
			middle_name: 'Biden',
			contact_info: { phone: '+1234567890', email: 'Steve@email.ru' },
			git: 'https://github.com/Steve'
		)
		expected = {
			name: 'Steve',
			middle_name: 'Biden',
			surname: 'Harvey',
			git: 'https://github.com/Steve',
			phone: '+1234567890',
			telegram: '',
			email: 'Steve@email.ru'
		}

		assert_equal expected, student.to_data
	end
end
