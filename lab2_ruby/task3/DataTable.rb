
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