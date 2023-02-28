class DataListStudentShort < Data_List_
  attr_reader :column_names
  attr_accessor :data

  def column_count
    # pin
    @data[0].instance_variables.count
  end

  def row_count
    # pin
    @data.count
  end

  def names
    %w[id surname initials git contact]
  end

  def select(number)
    @selected << @data[number].id
  end

end
