
class Student_short
  attr_accessor :id, :surname, :initials, :git, :contact

  def initialize(id: nil, surname: nil, initials: nil, git: nil, contact: nil)
    @id = id
    @surname = surname
    @initials = initials
    @git = git
    @contact = contact
  end

  def to_s
    "#{@id} #{@surname} #{@initials} #{@git} #{@contact}"
  end

end
