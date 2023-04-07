# frozen_string_literal: true

require_relative '../data_list'
require_relative 'student'
require_relative 'student_display'
require_relative '../Services/student_file_manager'

class StudentList < DataList

  attr_reader :file_manager

  def initialize(data = [])
    super
    @file_manager = StudentFileManager.new
  end

  def get_names
    %w[Id Initials Git Contact]
  end

  def get_data
    @data.map.with_index do |element, index|
      [index, *%w[initials git contact].map { |attr| element.instance_variable_get("@#{attr}").to_s }]
    end.then { |passing_data| DataTable.new(passing_data) }
  end

  def select(number)
    @selected << @data[number].id
  end

  def sort_by_surname
    @data = @data.sort { |student1, student2| student1.initials <=> student2.initials }
  end

  def get_k_n_student_list(k, n, data_list = nil)
    return data_list.get_k_n_student_list(k, n) if data_list != nil
    part = size / k
    @data[part * (n - 1)...part * n]
  end


  def load_data(file_path)
    set_data @file_manager.load_data(file_path)
  end

  def save_data(file_path)
    @file_manager.save_data(file_path, @data)
  end
end