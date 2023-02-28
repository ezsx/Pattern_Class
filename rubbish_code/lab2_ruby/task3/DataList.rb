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

  def names
    raise NotImplementedError, "get_names must be implemented in inheriting class"
  end

  def data
    raise NotImplementedError, "get_data must be implemented in inheriting class"
  end


  private

  attr_reader :data
end

class Data_list_
  attr_reader :data

  def initialize(data)
    @data = data
    @selected = []
  end

  def select(number)
    @selected << @data[number]
  end

  def get_selected
    @selected.map(&:id)
  end

  def each
    @data.each { |element| yield element }
  end

  def get_names
    # This method will not work for the specified class
    # since it does not have information about objects inside
    # it needs to be implemented in the inheritors
    raise NotImplementedError, "Subclasses must implement this method"
  end

  def get_data
    # This method will not work for the specified class
    # since it does not have information about objects inside
    # it needs to be implemented in the inheritors
    raise NotImplementedError, "Subclasses must implement this method"
  end
end
