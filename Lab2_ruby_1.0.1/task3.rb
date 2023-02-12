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
  def initialize(data)
    @data = data
  end

  def [](index)
    @data[index]
  end

  def size
    @data.size
  end

  def each
    @data.each { |element| yield element }
  end

  private
  attr_reader :data
end
