# frozen_string_literal: true

require_relative '../rubbish_code/lab2_ruby/task1/Student'

class StudentDisplay
  attr_reader :id, :initials, :git, :contact

  def initialize(student)
    @id = student.id
    @initials = student.initials
    @git = student.git
    @contact = student.contact
  end

  def to_s
    "id: #{@id}, initials: #{@initials}, git: #{@git}, #{@contact}"
  end

  def to_json
    {
      id: @id,
      initials: @initials,
      git: @git,
      contact: @contact
    }
  end

end