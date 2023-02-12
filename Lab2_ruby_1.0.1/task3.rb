class DataTable
  def initialize(data)
    @data = data
  end

  def data
    @data
  end

  def row_count
    @data.size
  end

  def column_count
    @data[0].size
  end

  private
  attr_reader :data
end
