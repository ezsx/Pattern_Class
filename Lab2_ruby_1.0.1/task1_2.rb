class Student
  attr_accessor :id, :surname, :first_name, :patronymic, :phone, :telegram, :mail, :git

  def initialize(options = { surname: '', first_name: '', patronymic: '' })
    @id = options[:id]
    @surname = options[:surname]
    @first_name = options[:first_name]
    @patronymic = options[:patronymic]
    @phone = options[:phone]
    @telegram = options[:telegram]
    @mail = options[:mail]
    @git = options[:git]
    validate_fields
  end

  def set_contacts(params)
    @phone = params[:phone] if self.class.valid_phone?(params[:phone])
    @telegram = params[:telegram] if self.class.valid_telegram?(params[:telegram])
    @mail = params[:mail] if self.class.valid_mail?(params[:mail])
    @git = params[:git] if self.class.valid_git?(params[:git])
  end

  def validate_fields
    validate_surname
    validate_first_name
    validate_patronymic
    validate_guide
    validate_contact
  end

  def get_info
    info = "#{surname} #{first_name[0]}.#{patronymic[0]}."
    info += " Git: #{git}" if git
    if phone
      info += " Phone: #{phone}"
    elsif telegram
      info += " Telegram: #{telegram}"
    elsif mail
      info += " Mail: #{mail}"
    end
    info
  end

  def get_id
    @id
  end

  def get_surname
    @surname
  end

  def get_names
    names = "no name"
    names += "#{@surname} " if @surname
    names += "#{@first_name} " if @first_name
    names += "#{@patronymic}" if @patronymic
    names
  end

  def get_initials
    "#{@first_name[0]}.#{@patronymic[0]}."
  end

  def get_git
    @git
  end

  def get_communication
    info = ""
    if @phone
      info += "Phone: #{@phone}"
    elsif @telegram
      info += "Telegram: #{@telegram}"
    elsif @mail
      info += "Mail: #{@mail}"
    end
    info
  end

  def to_s
    "ID: #{id}, Surname: #{surname}, First name: #{first_name}, Patronymic: #{patronymic}, Phone: #{phone}, Telegram: #{telegram}, Mail: #{mail}, Git: #{git}"
  end

  def self.from_string(string)
    id, surname, first_name, patronymic, phone, telegram, mail, git = string.split(',')
    params = { id: id, surname: surname, first_name: first_name, patronymic: patronymic, phone: phone, telegram: telegram, mail: mail, git: git }
    new(params)
  end

  def validate_surname
    raise ArgumentError, 'Surname is required' unless self.class.valid_surname?(surname)
  end

  def validate_first_name
    raise ArgumentError, 'First name is required' unless self.class.valid_first_name?(first_name)
  end

  def validate_patronymic
    raise ArgumentError, 'Patronymic is required' unless self.class.valid_patronymic?(patronymic)
  end

  def validate_guide
    raise ArgumentError, 'A guide is required' unless (git || telegram || mail)
  end

  def validate_contact
    raise ArgumentError, 'A contact for communication is required' unless (phone || telegram || mail)
  end

  def self.valid_surname?(surname)
    surname.is_a?(String) && surname.match(/\A[a-zA-Z]+\z/)
  end

  def self.valid_first_name?(first_name)
    first_name.is_a?(String) && first_name.match(/\A[a-zA-Z]+\z/)
  end

  def self.valid_patronymic?(patronymic)
    patronymic.is_a?(String) && patronymic.match(/\A[a-zA-Z]+\z/)
  end

  def self.valid_phone?(phone)
    phone.is_a?(String) && phone.match(/\A[0-9]+\z/)
  end

  def self.valid_telegram?(telegram)
    telegram.is_a?(String) && telegram.match(/\A[a-zA-Z0-9]+\z/)
  end

  def self.valid_mail?(mail)
    mail.is_a?(String) && mail.match(/\A[a-zA-Z0-9]+@[a-z]+.[a-z]+\z/)
  end

  def self.valid_git?(git)
    git.is_a?(String) && git.match(/\Ahttps?:\/\/github\.com\/[a-zA-Z0-9]+\/[a-zA-Z0-9]+\z/)
  end

  def self.read_from_txt(file_path)
    students = []
    begin
      File.open(file_path, 'r') do |file|
        file.each_line do |line|
          id, surname, first_name, patronymic, phone, telegram, mail, git = line.split(',')
          params = { id: id, surname: surname, first_name: first_name, patronymic: patronymic, phone: phone, telegram: telegram, mail: mail, git: git }
          students << Student.new(params = params)

        end
      end
      students
    rescue => exception
      raise "File not found at the given address #{file_path}. Exception: #{exception.message}"
    end
  end
  def self.write_to_txt(file_path, students)
    begin
      File.open(file_path, 'w') do |file|
        students.each do |student|
          file.puts "#{student.id},#{student.surname},#{student.first_name},#{student.patronymic},#{student.phone},#{student.telegram},#{student.mail},#{student.git}"
        end
      end
    rescue => exception
      raise "File could not be written at the given address #{file_path}. Exception: #{exception.message}"
    end
  end

end

class Student_short < Student
  attr_reader :id, :surname, :initials, :git, :contact

  def initialize(id: nil, string: nil, student: Student)

    if student
      @id = student.id
      @surname = student.get_surname
      @initials = student.get_initials
      @git = student.get_git
      @contact = student.get_communication
      # hash data


    elsif string
      info = get_info(string)
      @id = id
      @surname = info[:surname]
      @initials = info[:initials]
      @git = info[:git]
      @contact = info[:contact]
    end
  end

  private

  def to_h
    {
      id: @id,
      surname: @surname,
      initials: @initials,
      git: @git,
      contact: @contact
    }
  end

  public def get_names
    name = "no name"
    name = "#{@surname} #{@initials}" if @surname && @initials
    name
  end

  def get_info(string)
    match = string.match(/\A(?<surname>\w+)\s+(?<initials>\w+\.\w+)\s+(?<git>\w+)\s+(?<contact>\w+@\w+\.\w+)\z/)
    {
      surname: match[:surname],
      initials: match[:initials],
      git: match[:git],
      contact: match[:contact]
    }
  end
  def to_s
    "ID: #{@id}, Surname: #{@surname}, Initials: #{@initials}, Git: #{@git}, Contact: #{@contact}"
  end
end


