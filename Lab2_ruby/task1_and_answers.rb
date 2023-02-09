class Student
  attr_accessor :id, :surname, :first_name, :patronymic, :phone, :telegram, :mail, :git

  VALID_PHONE_REGEX = /\A\d{10,11}\z/
  VALID_TELEGRAM_REGEX = /\A\@\w+\z/
  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  VALID_GIT_REGEX = /\Ahttps:\/\/github\.com\/\w+\z/

  def initialize(params = {})
    @id = params[:id]
    @surname = params[:surname]
    @first_name = params[:first_name]
    @patronymic = params[:patronymic]
    @phone = params[:phone]
    @telegram = params[:telegram]
    @mail = params[:mail]
    @git = params[:git]
  end

  def full_name
    "#{surname} #{first_name} #{patronymic}"
  end

  def validate
    validate_git_presence && validate_contacts_presence
  end

  def validate_git_presence
    return true if git
    puts "Git field is required"
    false
  end

  def validate_contacts_presence
    return true if phone || telegram || mail
    puts "At least one contact (phone, telegram, mail) is required"
    false
  end

  def set_contacts(contacts = {})
    @phone = contacts[:phone]
    @telegram = contacts[:telegram]
    @mail = contacts[:mail]
  end

  def self.valid_phone?(phone)
    phone =~ VALID_PHONE_REGEX
  end

  def self.valid_telegram?(telegram)
    telegram =~ VALID_TELEGRAM_REGEX
  end

  def self.valid_mail?(mail)
    mail =~ VALID_MAIL_REGEX
  end

  def self.valid_git?(git)
    git =~ VALID_GIT_REGEX
  end
end

# require_relative 'student'

student1 = Student.new(surname: 'Smith', first_name: 'John', git: 'https://github.com/johndoe')
student2 = Student.new(surname: 'Doe', first_name: 'Jane', phone: '1234567890', mail: 'jane.doe@example.com')
student3 = Student.new(surname: 'Doe', first_name: 'Jane', phone: '1234567890', mail: 'some.do@mail.com', git: 'https://github.com/johndoe')

# create some students with all data


students = [student1, student2, student3]

students.each do |student|
  if student.validate
    puts "Full name: #{student.full_name}"
    puts "Phone: #{student.phone}" if student.phone
    puts "Telegram: #{student.telegram}" if student.telegram
    puts "Mail: #{student.mail}" if student.mail
    puts "Git: #{student.git}" if student.git
    puts ""
  end
end


# Обратите внимание, что эта реализация проверяет наличие поля `git`
# и по крайней мере одного контакта для связи (телефон, телеграмма, почта).
# Если эти проверки завершаются неудачей, объект не отображается.
# Класс также включает методы для проверки того, является ли данная строка допустимым номером телефона,
# телеграмма, почты или git, и метод `set_contacts`, который задает значения полей контактов.

# Примерное построение диаграммы классов, описавыющих данный класс.
#
# +--------------+
# |   Student    |
#   +--------------+
# | - id         |
# | - surname    |
# | - first_name |
# | - patronymic |
# | - phone      |
# | - telegram   |
# | - mail       |
# | - git        |
#   +--------------+
# | + full_name  |
# | + validate   |
#   +--------------+
# | - validate_git_presence  |
# | - validate_contacts_presence |
# | + set_contacts            |
# | + valid_phone?           |
# | + valid_telegram?        |
# | + valid_mail?            |
# | + valid_git?             |
#   +--------------+

# Класс Studentимеет следующие атрибуты:
#
#                                id
# surname
# first_name
# patronymic
# phone
# telegram
# mail
# git
# Он также имеет следующие методы:
#
# full_name: возвращает полное имя студента
# validate: проверяет наличие git поля и хотя бы одного контакта для связи (телефон, телеграм, почта)
# validate_git_presence: проверяет наличие git поля
# validate_contacts_presence: проверяет наличие хотя бы одного контакта для связи (телефон, телеграм, почта)
# set_contacts: устанавливает значения контактных полей
# valid_phone?: проверяет, является ли данная строка допустимым номером телефона
# valid_telegram?: проверяет, является ли данная строка допустимым именем пользователя телеграммы
# valid_mail?: проверяет, является ли данная строка действительным адресом электронной почты
# valid_git?: проверяет, является ли данная строка допустимым URL-адресом git
# Обратите внимание, что эта диаграмма классов является упрощенным представлением класса и не включает все детали.
#
# Вопросы:
#
#     a.
#   Что такое класс, что такое объект, как создать объект класса?
#     b.
#   В чем заключается принцип инкапсуляции? Как получить
#   доступ к полям объекта из внешнего класса?
#     c.
#   Как используются символы для решения задач инкапсуляции
#   и уменьшения количества кода при описании класса?
#     d.
#   Что такое конструктор, зачем он нужен, как описывается
#   конструктор в произвольном классе?
#     e.
#   Опишите механизм создания объекта.
#     f.
#   Что такое метод класса, в чем его отличие от метода объекта?
#     g.
#   Приведите два практических примера, когда введение метода класса вы
#   считаете необходимым согласно концепциям ООП.
#
# Ответы на вопросы:
#
#   а. Класс — это план или шаблон для создания объектов. Объект является экземпляром
#   класса и представляет конкретный экземпляр класса. Чтобы создать объект класса,
#   вы сначала определяете класс, а затем используете newметод для создания объекта этого класса.
#
#   б. Принцип инкапсуляции означает, что внутренние детали объекта должны быть скрыты от
#   внешнего мира и доступны только через общедоступный интерфейс. Чтобы получить доступ
#   к полям объекта из внешнего класса, вы можете использовать методы получения и установки,
#   которые позволяют вам извлекать или изменять значения полей.
#
#   в. Символы используются для решения проблем инкапсуляции и уменьшения объема кода при
#   описании класса, выступая в качестве сокращения для именования переменных и методов.
#   Они неизменяемы и могут использоваться в качестве ключей в хэшах, что делает их более
#   эффективным и удобочитаемым способом определения атрибутов и методов в классе.
#
#   д. Конструктор — это специальный метод, который автоматически вызывается при создании объекта.
#   Он используется для инициализации объекта и установки его начального состояния.
#   Конструктор описывается в классе путем определения метода с тем же именем, что и у класса.
#   Конструктор может принимать аргументы для инициализации полей объекта.
#
#   е. Механизм создания объекта заключается в использовании new метода класса.
#   Метод new создает новый экземпляр класса и возвращает ссылку на объект.
#   Вы можете передать аргументы new методу для инициализации полей объекта.
#
#   ф. Метод класса — это метод, который определен на уровне класса и может вызываться в самом классе,
#   а не в экземпляре класса. Метод класса отличается от метода объекта, который определен на уровне объекта
#   и может быть вызван для экземпляра класса.
#
#   г. Два практических примера использования метода класса:
#
#   Когда вам нужно выполнить операцию, не зависящую от состояния какого-либо отдельного объекта,
#   например вспомогательную функцию, которую можно использовать во всем коде.
#
#   Когда вам нужно создать объект из метода класса, а не вне класса, например,
#   когда вы хотите создать одноэлементный класс, который гарантирует существование
#   только одного экземпляра класса.