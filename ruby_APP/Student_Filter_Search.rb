require_relative '../ruby_APP/Student_List'

class Student_Filtered
  attr_accessor :data_getter

  def initialize(data_getter)
    @data_getter = data_getter
  end

  def get_k_n_student_list(n, k, filters = {})
    filtered_data = apply_filters(filters, @data_getter)
    filtered_data.take(n * k)
                 .each_slice(k)
                 .map { |group| Student_List.new(group) }
  end

  def get_student_count(filters = {})
    filtered_data = apply_filters(filters, @data_getter)
    filtered_data.size
  end

  def search(&block)
    @data_getter.select(&block)
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
      else
        raise "filter is nill"
      end
    end
  end
end

# frozen_string_literal: true
class Student_Search
  def initialize(student_getter)
    @student_getter = student_getter
    @filters = {}
  end

  def with_surname(surname)
    @filters[:surname] = surname
    self
  end

  def with_initials(initials)
    @filters[:initials] = initials
    self
  end

  def with_mail(mail)
    @filters[:mail] = mail
    self
  end

  def with_phone(phone)
    @filters[:phone] = phone
    self
  end

  def with_telegram(telegram)
    @filters[:telegram] = telegram
    self
  end

  def with_git(git)
    @filters[:git] = git
    self
  end

  def with_mail_present
    @filters[:has_mail] = true
    self
  end

  def with_phone_present
    @filters[:has_phone] = true
    self
  end

  def with_telegram_present
    @filters[:has_telegram] = true
    self
  end

  def with_git_present
    @filters[:has_git] = true
    self
  end

  def with_mail_missing
    @filters[:no_mail] = true
    self
  end

  def with_phone_missing
    @filters[:no_phone] = true
    self
  end

  def with_telegram_missing
    @filters[:no_telegram] = true
    self
  end

  def with_git_missing
    @filters[:no_git] = true
    self
  end

  def reset_filters
    @filters = {}
    self
  end

  def results(n, k)
    @student_getter.get_k_n_student_list(n, k, @filters)
  end

  def count
    @student_getter.get_student_count(@filters)
  end
end
