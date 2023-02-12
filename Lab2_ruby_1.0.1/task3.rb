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
