class Student
  attr_accessor :id, :surname, :first_name, :patronymic, :phone, :telegram, :mail, :git, :initials, :contact

  # TODO: its hashed but we cant see parameters while init it
  # @param [Hash{Symbol->String}] options

  def initialize(options = {})
    @id = options[:id]
    @surname = options[:surname] || ''
    @first_name = options[:first_name] || ''
    @patronymic = options[:patronymic] || ''
    @phone = options[:phone]
    @telegram = options[:telegram]
    @mail = options[:mail]
    @git = options[:git]
    @initials = initials_get
    @contact = communication
    validate_fields
  end

  def self.initialize2(id, surname, first_name, patronymic, phone, telegram, mail, git)
    @id = id
    @surname = surname
    @first_name = first_name
    @patronymic = patronymic
    @phone = phone
    @telegram = telegram
    @mail = mail
    @git = git
    @initials = initials_get
    @contact = communication
    validate_fields
  end


  def student_short
    "#{@id} #{@surname} #{@initials} #{@contact}"
  end

  def set_contacts(params = { phone: '', telegram: '', mail: '', git: '' })
    @phone = params[:phone] if self.class.valid_phone?(params[:phone])
    @telegram = params[:telegram] if self.class.valid_telegram?(params[:telegram])
    @mail = params[:mail] if self.class.valid_mail?(params[:mail])
    @git = params[:git] if self.class.valid_git?(params[:git])
  end

  def validate_fields
    validate_contact
  end

  def info
    info = "#{surname} #{initials}."
    info += " Git: #{git}" if git
    info += communication
    info
  end

  def communication
    info = ''
    if @phone
      info += "Phone: #{@phone}"
    elsif @telegram
      info += "Telegram: #{@telegram}"
    elsif @mail
      info += "Mail: #{@mail}"
    end
    info
  end

  def names
    names = ''
    names += "#{@surname} " if @surname
    names += "#{@first_name} " if @first_name
    names += "#{@patronymic}" if @patronymic
    names
  end

  # @return [String]
  def initials_get
    "#{@first_name[0]}.#{@patronymic[0]}." if @first_name and @patronymic
  end

  def to_s
    "ID: #{id}, Surname: #{surname}, First name: #{first_name}, Patronymic: #{patronymic}, Phone: #{phone}, Telegram: #{telegram}, Mail: #{mail}, Git: #{git}"
  end

  def self.display(students)
    students.each do |student_|
      puts student_.to_s
    end
  end

  def self.from_string(string)
    id, surname, first_name, patronymic, phone, telegram, mail, git = string.split(',')
    params = { id: id, surname: surname, first_name: first_name, patronymic: patronymic, phone: phone, telegram:
      telegram, mail: mail, git: git }
    new(params)
  end

  def validate_contact
    raise ArgumentError, 'A contact for communication is required' unless (git || phone || telegram || mail)
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
          params_to = { id: id, surname: surname, first_name: first_name, patronymic: patronymic, phone: phone,
                        telegram: telegram, mail: mail, git: git }
          students.push(Student.new(params_to))
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
