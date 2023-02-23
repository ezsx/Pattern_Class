require 'faker'

# generate 10 random students
def generate_students
  10.times.map do
      student.new(surname: faker::name.last_name, first_name: faker::name.first_name,
        patronymic: faker::name.middle_name, phone: faker::phonenumber.phone_number,
        telegram: faker::internet.username, mail: faker::internet.email,
        git: faker::internet.url
      )
    end
end

# insert each student into the database
def insert_students_database
  students.each do |student|
    conn.exec_params(
      'insert into students (surname, first_name, patronymic, phone, telegram, mail, git) values ($1, $2, $3, $4, $5, $6, $7)',
      [student.surname, student.first_name, student.patronymic, student.phone, student.telegram, student.mail, student.git]
    )
  end
end