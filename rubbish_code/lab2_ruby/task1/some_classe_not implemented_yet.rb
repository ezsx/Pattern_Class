
# class Student_short < Student
#   attr_reader :id, :surname, :initials, :git, :contact
#
#   def initialize(id: nil, string: nil, student: Student)
#
#     if student
#       @id = student.get_id
#       @surname = student.get_surname
#       @initials = student.get_initials
#       @git = student.get_git
#       @contact = student.get_communication
#       # hash data
#
#
#     elsif string
#       info = get_info(string)
#       @id = id[:id]
#       @surname = info[:surname]
#       @initials = info[:initials]
#       @git = info[:git]
#       @contact = info[:contact]
#     end
#   end
#
#   private
#
#   def to_h
#     {
#       id: @id,
#       surname: @surname,
#       initials: @initials,
#       git: @git,
#       contact: @contact
#     }
#   end
#
#   public def get_names
#     name = "no name"
#     name = "#{@surname} #{@initials}" if @surname && @initials
#     name
#   end
#
#   def get_info(string)
#     # match = string.match(/\A(?<surname>\w+)\s+(?<initials>\w+\.\w+)\s+(?<git>\w+)\s+(?<contact>\w+@\w+\.\w+)\z/)
#     # add id to match
#     match = string.match(/\A(?<id>\d+)\s+(?<surname>\w+)\s+(?<initials>\w+\.\w+)\s+(?<git>\w+)\s+(?<contact>\w+@\w+\.\w+)\z/)
#     {
#       id: match[:id],
#       surname: match[:surname],
#       initials: match[:initials],
#       git: match[:git],
#       contact: match[:contact]
#     }
#   end
#   def to_s
#     "ID: #{@id}, Surname: #{@surname}, Initials: #{@initials}, Git: #{@git}, Contact: #{@contact}"
#   end
# end
# #