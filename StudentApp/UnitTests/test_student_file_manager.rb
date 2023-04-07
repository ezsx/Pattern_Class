# frozen_string_literal: true

require 'minitest/autorun'
require 'json'
require_relative '../Source/Model/StudentInfo/student'
require_relative '../Source/Services/FileManager/student_file_manager'

class TestStudentFileManager < Minitest::Test

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

	def test_files_crud

		def test_crud(file_path)
			file_manager = StudentFileManager.new file_path

			student0 = create_student 0
			student1 = create_student 1

			file_manager.create student0
			file_manager.create student1

			assert_equal(2, file_manager.count)
			assert_equal(student0.to_json, file_manager.read(0).to_json)

			file_manager.delete(1)
			assert_equal(1, file_manager.count)

			student_for_update = file_manager.read 0
			student_for_update.name = 'Changed Name'
			file_manager.update(0, student_for_update)

			assert_equal(student_for_update.name, file_manager.read(0).name)
		end

		file_path = 'D:\Ruby_proj\rub_start\StudentApp\UnitTests\TestFiles\Mock.'
		json_file_path = file_path + 'json'
		yaml_file_path = file_path + 'yaml'
		txt_file_path = file_path + 'txt'
		# clear data form files
		File.open(txt_file_path, 'w') { |file| file.write('') }
		[json_file_path, yaml_file_path].map do |path|
			File.open(path, 'w') { |file| file.write('[]') }
		end
		test_crud(json_file_path)
		test_crud(yaml_file_path)
		test_crud(txt_file_path)
	end
end
