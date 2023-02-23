# TODO: in Student class variable contacts contain git, so we need to remove git from student short
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
