require 'pg'
require_relative '../ruby_APP/DB_config/db_config'
require_relative '../ruby_APP/Student_info/student'
require_relative '../ruby_APP/Student_info/student_list'

class StudentsListDB
  def initialize(db_config)
    @conn = PG.connect(dbname: db_config.dbname, user: db_config.user, password: db_config.password, host: db_config.host)
  end

  def create_table
    @conn.exec("CREATE TABLE IF NOT EXISTS students (
      id SERIAL PRIMARY KEY,
      surname VARCHAR(255),
      name VARCHAR(255),
      middle_name VARCHAR(255),
      phone VARCHAR(255),
      telegram VARCHAR(255),
      email VARCHAR(255),
      git VARCHAR(255)
    );")
  end

  def get_student_by_id(id)
    result = @conn.exec_params('SELECT * FROM students WHERE id=$1', [id])
    row = result[0]
    Student.new(
      id: id,
      name: row['name'],
      surname: row['surname'],
      middle_name: row['middle_name'],
      contact_info: { phone: row['phone'], email: row['email'], telegram: row['telegram'] },
      git: row['git']
    )
  end

  def get_k_n_student_list(k, n)
    result = @conn.exec_params("SELECT * FROM students LIMIT $1 OFFSET $2", [k, n])
    data_list = StudentList.new
    result.each do |row|
      data_list.add_student(
        Student.new(
          id: row['id'].to_i,
          name: row['name'],
          surname: row['surname'],
          middle_name: row['middle_name'],
          contact_info: { phone: row['phone'], email: row['email'], telegram: row['telegram'] },
          git: row['git']
        )
      )
    end
    data_list
  end

  def add_student(student)
    @conn.exec_params('INSERT INTO students (surname, name, middle_name, phone, telegram, email, git) VALUES ($1, $2, $3, $4, $5, $6, $7)',
                      [student.surname, student.name, student.middle_name, student.contact_info.phone, student.contact_info.telegram,
                       student.contact_info.email, student.git])
  end

  def update_student_by_id(id, student)
    @conn.exec_params('UPDATE students SET surname=$1, name=$2, middle_name=$3, phone=$4, telegram=$5, email=$6, git=$7 WHERE id=$8',
                      [student.surname, student.name, student.middle_name, student.contact_info.phone, student.contact_info.telegram,
                       student.contact_info.email, student.git, id])
  end

  def delete_student_by_id(id)
    @conn.exec_params('DELETE FROM students WHERE id=$1', [id])
  end

  def number_of_elements
    result = @conn.exec('SELECT COUNT(*) FROM students')
    result[0]['count'].to_i
  end
end
