# frozen_string_literal: true

require 'pg'
require_relative '../api_manager'
require_relative '../student_repository'

api_manager = APIManager.new

student_repository = StudentRepository.new api_manager

puts student_repository.get_display_list(2, 2)