require 'pg'
require_relative '../ruby_APP/Student'
require_relative '../ruby_APP/Student_List'

class Students_list_DB
  # @param [Object] dbname
  # @param [Object] user
  # @param [Object] password
  # @param [Object] host
  def initialize(dbname, user, password, host)
    @conn = PG.connect(dbname: dbname, user: user, password: password, host: host)
  end

  def get_student_by_id(id)
    result = @conn.exec_params('SELECT * FROM students WHERE id=$1', [id])
    row = result[0]
    Student.new(id: id, surname: row['surname'], first_name: row['first_name'],
                patronymic: row['patronymic'], phone: row['phone'], telegram: row['telegram'],
                mail: row['mail'], git: row['git'], initials: row['initials'], contact: row['contact'])
  end

  def get_k_n_student_list(k, n)
    result = @conn.exec_params("SELECT * FROM students LIMIT $1 OFFSET $2", [k, n])
    data_list = Student_List.new
    result.each do |row|
      data_list.add_student(Student.new(id: id, surname: row['surname'], first_name: row['first_name'],
                                patronymic: row['patronymic'], phone: row['phone'], telegram: row['telegram'],
                                mail: row['mail'], git: row['git'], initials: row['initials'], contact: row['contact']))
    end
    data_list
  end

  def add_student(student)
    id = generate_new_id
    @conn.exec_params('INSERT INTO students (id, surname, first_name, patronymic, phone, telegram, mail, git, initials,
                       contact) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)',
                      [id, student.surname, student.first_name, student.patronymic, student.phone, student.telegram,
                       student.mail, student.git, student.initials, student.contact])
  end

  def replace_student_by_id(id, student)
    # TODO: method logic is not correct
    @conn.exec_params('UPDATE students SET surname=$1, first_name=$2, patronymic=$3, phone=$4, telegram=$5, mail=$6,
                       git=$7, initials=$8, contact=$9 WHERE id=$10',
                      [student.surname, student.first_name, student.patronymic, student.phone, student.telegram,
                       student.mail, student.git, student.initials, student.contact, id])
  end

  def delete_student_by_id(id)
    @conn.exec_params('DELETE FROM students WHERE id=$1', [id])
  end

  def number_of_elements
    result = @conn.exec('SELECT COUNT(*) FROM students')
    result[0]['count'].to_i
  end

  private

  def generate_new_id
    result = @conn.exec('SELECT MAX(id) FROM students')
    if result[0]['max'].nil?
      1
    else
      result[0]['max'].to_i + 1
    end
  end
end