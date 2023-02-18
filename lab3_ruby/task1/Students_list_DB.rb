require 'pg'
require_relative '../lab2_ruby/task4/DataList'
require_relative '../../lab2_ruby/task1_2/Student_and_Student_short'

class Students_list_DB
  def initialize(dbname, user, password, host)
    @conn = PG.connect(dbname: dbname, user: user, password: password, host: host)
  end

  def get_student_by_id(id)
    result = @conn.exec_params('SELECT * FROM students WHERE id=$1', [id])
    return nil if result.ntuples == 0
    row = result[0]
    Student.new(id: id, surname: result['surname'], first_name: result['first_name'],
                patronymic: result['patronymic'], phone: result['phone'], telegram: result['telegram'],
                mail: result['mail'], git: result['git'], initials: result['initials'], contact: result['contact'])
  end

  def get_k_n_student_short_list(k, n)
    result = @conn.exec_params("SELECT * FROM students LIMIT $1 OFFSET $2", [k, n])
    data_list = DataList.new
    result.each do |row|
      data_list.add(Student_short.new(id: row['id'], surname: row['name'], initials: row['initials'], git: row['git'], contact: row['contact']))
    end
    data_list
  end

  def add_student(student)
    id = generate_new_id
    @conn.exec_params('INSERT INTO students (id, surname, first_name, patronymic, phone, telegram, mail, git, initials, contact) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)',
                      [id, student.surname, student.first_name, student.patronymic, student.phone, student.telegram,
                       student.mail, student.git, student.initials, student.contact])
  end

  def replace_student_by_id(id, student)
    @conn.exec_params('UPDATE students SET surname=$1, first_name=$2, patronymic=$3, phone=$4, telegram=$5, mail=$6, git=$7, initials=$8, contact=$9 WHERE id=$10',
                      [student.surname, student.first_name, student.patronymic, student.phone, student.telegram,
                       student.mail, student.git, student.initials, student.contact, id])
  end

  def delete_student_by_id(id)
    @conn.exec_params('DELETE FROM students WHERE id=$1', [id])
  end

  def get_number_of_elements
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