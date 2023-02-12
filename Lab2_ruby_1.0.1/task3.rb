class DataTable
  def initialize(data)
    @data = data
  end

  def [](row, col)
    @data[row][col]
  end

  def row_count
    @data.size
  end

  def column_count
    @data[0].size
  end
end
class DataList
  attr_reader :selected

  def initialize(data)
    @data = data
    @selected = []
  end

  def [](index)
    @data[index]
  end

  def size
    @data.size
  end

  def select(number)
    @selected << number
  end

  def get_selected
    @selected
  end

  def get_names
    raise NotImplementedError, "get_names must be implemented in inheriting class"
  end

  def get_data
    raise NotImplementedError, "get_data must be implemented in inheriting class"
  end

  def each
    @data.each { |element| yield element }
  end

  private
  attr_reader :data
end

# class DataListStudentShort < DataList
#   # realisation of get_names withot using each method cant be done
#   # because of the realization of DataTabel class
#
#   def get_data
#     data = []
#     each do |student|
#       data << [student.id, student.surname, student.initials, student.git, student.contact]
#     end
#     DataTable.new(data)
#   end
#
#   def get_names
#     ['ID', 'Surname', 'Initials', 'Git', 'Contact']
#   end
# end
class DataListStudentShort < DataList
  attr_reader :data_table

  private

  def parse_student_short(student_short)
    [student_short.id, student_short.surname, student_short.initials, student_short.git, student_short.contact]
  end

  public

  def get_data
    DataTable.new(
          elements: elements.map { |student_short| parse_student_short(student_short) }
        )
  end

  def get_names
    %w[id surname initials git contact]
  end
end

# the simple patern template example
#
# def parse_pattern(input)
#   case input
#   when "hello"
#     puts "You said hello!"
#   when "goodbye"
#     puts "You said goodbye!"
#   when /\A\d+\z/
#     puts "You entered a number."
#   else
#     puts "I don't understand what you said."
#   end
# end
#
# parse_pattern("hello") # outputs: You said hello!
# parse_pattern("goodbye") # outputs: You said goodbye!
# parse_pattern("123") # outputs: You entered a number.
# parse_pattern("abc") # outputs: I don't understand what you said.
