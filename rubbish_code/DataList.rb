class Data_list
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

  def selected
    @selected
  end

  def names
    raise NotImplementedError, "get_names must be implemented in inheriting class"
  end

  def data
    raise NotImplementedError, "get_data must be implemented in inheriting class"
  end

  def each
    @data.each { |element| yield element }
  end

  private

  attr_reader :data
end
