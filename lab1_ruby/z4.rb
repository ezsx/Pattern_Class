# Task 1 methods
def index_min(array)
  array.index(array.min)
end

def count_in_range(array, range)
  array.count { |x| range.include? x }
end

def count_between_min(array)
  sort_array = array.sort
  min1 = sort_array[0]
  min2 = sort_array[1]
  count_in_range(array, min1..min2) - 2
end

def count_in_interval(array, range)
  array.count { |x| range.include? x }
end

def diff(a, b)
  a | b - a & b
end

# Main function
def main(method_index, file_address)
  # Read array from file
  array = File.readlines(file_address).map(&:to_i)

  # Call appropriate method based on method index
  case method_index
  when 1
    puts "Index of minimum element: #{index_min(array)}"
  when 2
    puts "Number of elements in range: #{count_in_range(array, 2..4)}"
  when 3
    puts "Number of elements between first and last minimum: #{count_between_min(array)}"
  when 4
    puts "Number of elements in interval: #{count_in_interval(array, 2..3)}"
  when 5
    puts "Elements present in only one of the two lists: #{diff(array, [1, 2, 3, 4, 5])}"
  else
    puts "Invalid method index provided."
  end
end

# Usage example
main(1, "path/to/file.txt")
