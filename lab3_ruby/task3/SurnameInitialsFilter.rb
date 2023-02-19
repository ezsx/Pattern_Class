class SurnameInitialsFilter < Students_short_getter
  attr_reader :substring

  def initialize(data_getter, substring)
    super(data_getter)
    @substring = substring
  end

  def get_k_n_student_short(k, n)
    filtered_students = @data_getter.get_student_short_list.select do |student|
      student.surname.include?(@substring) || student.initials.include?(@substring)
    end

    k = 0 if k.negative?
    n = filtered_students.size if n > filtered_students.size
    filtered_students.slice(k, n)
  end
end
