require_relative 'task1_2'


class Data_table
  attr_accessor :data

  def initialize(params ={data: []})
    # Initialize the two-dimensional array with elements of any type
    @data = params[:data]
  end
  # hash = {a: 1, b: 2, c: 3}
  def to_h
    headers = data.first
    rows = data[1..-1]
    rows.map { |row| headers.zip(row).to_h }
  end

  def [](row, col)
    data[row][col]
  end

  def column_count
    len = -1
    len = data.first.length if data.length > 0 && data.first != nil
    len
  end

  def row_count
    data.length - 1
  end
end

class Data_list
  def initialize(data)
    # Initialize an ordered array of elements of any class
    @data = data
  end

  def select(number)
    # Select an element by number
    @data[number]
  end

  def get_selected
    # Get an array of id of selected elements
    selected = []
    @data.each_with_index do |element, index|
      selected << index if element.selected?
    end
    selected
  end

  def get_names
    # Get an array of attribute names, except ID (0 columns - No. in order)
    raise NotImplementedError, "This method should be implemented in the inheritors."
  end

  def get_data(selected = nil)
    # Get an object of the Data_table class, where the null column is the generated number in order
    # and the first column is the ID of the selected element


    raise NotImplementedError, "This method should be implemented in the inheritors."
  end
end

class Data_list_student_short < Data_list
  def get_names
    # Override the get_names method to get an array of attribute names for the class Student_short
    [:id, :surname, :initials, :git, :contact]
  end

  def get_data
    # Override the get_data method to get an object of the Data_table class for the class Student_short
    data = Data_table.new(create_data_table, create_names)
    data
  end
end

# Example usage
students = read_from_txt('students_short.txt')
student_list = Data_list_student_short.new(students)

# Get an array of id of selected elements
selected = student_list.get_selected
puts selected

# Get an object of the Data_table class
data_table = student_list.get_data
puts data_table.num_rows
puts data_table.num_columns
puts data_table.get_element(0, 1)
