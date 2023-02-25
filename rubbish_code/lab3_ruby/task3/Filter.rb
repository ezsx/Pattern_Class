class Filter
  def initialize(data)
    @data = data
    @result_counts = {}
  end

  def filter_by_k_n(k, n)
    filtered_data = @data.select do |student|
      (student.initials.include?(@filter) || student.surname.include?(@filter))
    end

    filtered_data.take(n).take(k)
  end


  def filter_by_initials_surname(s)
    filtered_data = @data.select do |student|
      (student.initials.include?(s) || student.surname.include?(s))
    end

    Filter.new(filtered_data)
  end


  def filter_by_git(g)
    filtered_data = @data.select { |student| student.git == g }
    Filter.new(filtered_data)
  end


  def filter_by_telegram(t)
    filtered_data = @data.select { |student| student.telegram == t }
    Filter.new(filtered_data)
  end


  def filter_by_mail(m)
    filtered_data = @data.select { |student| student.mail == m }
    Filter.new(filtered_data)
  end

  def filter_by_phone(p)
    filtered_data = @data.select { |student| student.phone == p }
    Filter.new(filtered_data)
  end

  def result_counts
    @result_counts
  end

  def result
    @data
  end

end
