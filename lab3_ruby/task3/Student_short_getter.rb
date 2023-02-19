class Students_short_getter
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def get_k_n_student_short_list(n, k)
    short_list = @data[k...k + n].map { |student| Student_short.new(id: student.id, surname: student.surname, initials: student.initials, git: student.git, contact: student.contact) }
    Data_list.new(short_list)
  end

  def get_student_short_count
    @data.size
  end
end

# frozen_string_literal: true

