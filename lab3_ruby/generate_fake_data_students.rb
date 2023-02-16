require 'faker'

# generate 10 random students
students = 10.times.map do
  Student.new(
    surname: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    patronymic: Faker::Name.middle_name,
    phone: Faker::PhoneNumber.phone_number,
    telegram: Faker::Internet.username,
    mail: Faker::Internet.email,
    git: Faker::Internet.url
  )
end

# insert each student into the database
students.each do |student|
  conn.exec_params(
    'INSERT INTO students (surname, first_name, patronymic, phone, telegram, mail, git) VALUES ($1, $2, $3, $4, $5, $6, $7)',
    [student.surname, student.first_name, student.patronymic, student.phone, student.telegram, student.mail, student.git]
  )
end
