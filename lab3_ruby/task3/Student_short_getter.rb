class Students_short_getter
  attr_accessor :data_getter

  def initialize(data_getter)
    @data_getter = data_getter
  end

  def get_k_n_student_short_list(n, k, filters = {})
    filtered_data = apply_filters(filters, @data_getter)
    filtered_data.take(n * k)
                 .each_slice(k)
                 .map { |group| Student_list.new(group) }
  end

  def get_student_short_count(filters = {})
    filtered_data = apply_filters(filters, @data_getter)
    filtered_data.size
  end

  private

  def apply_filters(filters, data)
    return data unless filters

    filters.reduce(data) do |filtered_data, (field, value)|
      case field
      when :surname
        filtered_data.select { |student| student.surname.downcase.include?(value.downcase) }
      when :initials
        filtered_data.select { |student| student.initials.downcase.include?(value.downcase) }
      when :mail
        filtered_data.select { |student| student.mail.downcase.include?(value.downcase) }
      when :phone
        filtered_data.select { |student| student.phone.downcase.include?(value.downcase) }
      when :telegram
        filtered_data.select { |student| student.telegram.downcase.include?(value.downcase) }
      when :git
        filtered_data.select { |student| student.git.downcase.include?(value.downcase) }
      when :has_mail
        filtered_data.select { |student| !student.mail.nil? }
      when :has_phone
        filtered_data.select { |student| !student.phone.nil? }
      when :has_telegram
        filtered_data.select { |student| !student.telegram.nil? }
      when :has_git
        filtered_data.select { |student| !student.git.nil? }
      when :no_mail
        filtered_data.select { |student| student.mail.nil? }
      when :no_phone
        filtered_data.select { |student| student.phone.nil? }
      when :no_telegram
        filtered_data.select { |student| student.telegram.nil? }
      when :no_git
        filtered_data.select { |student| student.git.nil? }
      end
    end
  end
end

# frozen_string_literal: true

class StudentsShortGetterWrapper
  def initialize(strategy)
    @strategy = strategy
  end

  def search_by_surname(surname)
    @strategy.search { |student| student.surname.include?(surname) }
  end

  def search_by_initials(initials)
    @strategy.search { |student| student.initials.include?(initials) }
  end

  def search_by_mail
    @strategy.search { |student| student.mail.present? }
  end

  def search_by_phone
    @strategy.search { |student| student.phone.present? }
  end

  def search_by_telegram
    @strategy.search { |student| student.telegram.present? }
  end

  def search_by_git
    @strategy.search { |student| student.git.present? }
  end

  def search_by_mail_absent
    @strategy.search { |student| student.mail.blank? }
  end

  def search_by_phone_absent
    @strategy.search { |student| student.phone.blank? }
  end

  def search_by_telegram_absent
    @strategy.search { |student| student.telegram.blank? }
  end

  def search_by_git_absent
    @strategy.search { |student| student.git.blank? }
  end
end

# example of usage
#
# # Create a StudentsShortGetter instance and wrap it with the wrapper
# getter = StudentsShortGetter.new(students.students)
# wrapper = StudentsShortGetterWrapper.new(getter)
#
# # Search for students with the surname "Doe"
# results = wrapper.search_by_surname("Doe")
#
# # Print the results
# results.each do |student|
#   puts "#{student.initials} #{student.surname}"
# end
#
# # Output:
# # JD Doe
# # JD Doe