class Student_Alt
  attr_accessor :id, :surname, :first_name, :patronymic, :contacts

  def initialize(id:, surname:, first_name:, patronymic:, contacts: {})
    @id = id
    @surname = surname || ''
    @first_name = first_name || ''
    @patronymic = patronymic || ''
    @contacts = contacts
    validate_fields
  end

  def self.from_string(string)
    id, surname, first_name, patronymic, phone, telegram, mail, git = string.split(',')
    contacts = { phone: phone, telegram: telegram, mail: mail, git: git }
    new(id: id, surname: surname, first_name: first_name, patronymic: patronymic, contacts: contacts)
  end

  def full_name
    "#{@surname} #{@first_name} #{@patronymic}"
  end

  def initials
    "#{@first_name[0]}.#{@patronymic[0]}." if @first_name && @patronymic
  end

  def communication
    return unless contacts.any?

    contact_strings = contacts.map { |key, value| "#{key.capitalize}: #{value}" if value }.compact
    contact_strings.join(', ')
  end

  def info
    "#{full_name} (#{initials})#{' ' + communication if communication}"
  end

  def to_s
    "ID: #{@id}, Surname: #{@surname}, First name: #{@first_name}, Patronymic: #{@patronymic}, #{communication}"
  end

  def self.display(students)
    students.each { |student| puts student.to_s }
  end

  def self.read_from_txt(file_path)
    students = []
    begin
      File.foreach(file_path) do |line|
        students << from_string(line.strip)
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
          file.puts student.to_s
        end
      end
    rescue => exception
      raise "Error writing to file at the given address #{file_path}. Exception: #{exception.message}"
    end
  end

  private

  def validate_fields
    raise ArgumentError, 'A contact for communication is required' unless contacts.any?
    raise ArgumentError, 'Invalid phone number' unless valid_phone?
    raise ArgumentError, 'Invalid Telegram username' unless valid_telegram?
    raise ArgumentError, 'Invalid email address' unless valid_email?
    raise ArgumentError, 'Invalid GitHub URL' unless valid_github?
  end

  def valid_phone?
    contacts[:phone].to_s.match?(/\A[0-9]+\z/)
  end

  def valid_telegram?
    contacts[:telegram].to_s.match?(/\A[a-zA-Z0-9]+\z/)
  end

  def valid_email?
    contacts[:mail].to_s.match?(/\A[a-zA-Z0-9]+@[a-z]+.[a-z]+\z/)
  end

  def valid_github?
    contacts[:git].to_s.match?(/\Ahttps?:\/\/github\.com\/[a-zA-Z0-9]+\/[a-zA-Z0-9]+\z/)
  end
end
