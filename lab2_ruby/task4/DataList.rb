
class DataList
  attr_accessor :data

  # @param [Array] data
  def initialize(data = [])
    @data = data
  end

  def add_data(new_data)
    @data << new_data
  end

  def get_data_by_id(id)
    @data.find { |item| item.id == id }
  end

  def replace_data_by_id(id, new_data)
    @data.each_with_index do |item, index|
      if item.id == id
        @data[index] = new_data
        break
      end
    end
  end

  def delete_data_by_id(id)
    @data.delete_if { |item| item.id == id }
  end

  def sort_by_surname_and_initials
    @data.sort_by! { |item| [item.surname, item.initials] }
  end

  def get_k_n_short_data_list(k, n, short_data_class)
    short_data = @data.map { |item| short_data_class.new(item) }
    DataList.new(short_data[k - 1, n])
  end

  def data_count
    @data.count
  end
end
