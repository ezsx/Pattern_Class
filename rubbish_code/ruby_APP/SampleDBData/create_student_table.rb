# frozen_string_literal: true

require 'pg'
require_relative '../api_manager'
require_relative '../student_repository'

api_manager = APIManager.new

# Creating Students table if it doesnt exist yet
StudentRepository.new api_manager