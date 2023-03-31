# frozen_string_literal: true

require_relative 'student'

class StudentDisplay
  attr_reader :id, :initials, :git, :contact

  def initialize(student)
    @id = student.id
    @initials = student.name_initials
    @git = student.git
    @contact = student.contact_info
  end

  def to_s
    "id: #{@id}, initials: #{@initials}, git: #{@git}, #{@contact.to_s}"
  end

  def to_json
    {
      id: @id,
      initials: @initials,
      git: @git.to_json,
      contact: @contact.to_json
    }
  end

end