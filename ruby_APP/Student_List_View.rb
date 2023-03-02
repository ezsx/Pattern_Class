require 'fox16'
include Fox

require_relative '../ruby_APP/Student'
require_relative '../ruby_APP/Student_List'
require_relative '../ruby_APP/Student_Filter_Search'

class Student_List_View < FXMainWindow

  def initialize(app, student_l)
    super(app, "Student List", width: 1200, height: 600)

    # Create main horizontal layout
    main_hlayout = FXHorizontalFrame.new(self,
                                         opts: LAYOUT_SIDE_TOP | LAYOUT_FILL_X | LAYOUT_FILL_Y,
                                         padLeft: 10, padRight: 10, padTop: 10, padBottom: 10)

    # Create vertical layout for student list with a width of 200
    student_list_vlayout = FXVerticalFrame.new(main_hlayout,
                                               opts: LAYOUT_SIDE_LEFT | LAYOUT_FIX_WIDTH | LAYOUT_FIX_HEIGHT,
                                               width: 930, height: 400,
                                               padLeft: 10, padRight: 10, padTop: 10, padBottom: 10)
    # Create FXMatrix layout manager for student list
    student_list_matrix = FXMatrix.new(student_list_vlayout,
                                       2, # number of columns
                                       opts: MATRIX_BY_COLUMNS | LAYOUT_FIX_WIDTH | LAYOUT_FIX_HEIGHT,
                                       width: 930, height: 400,
                                       hSpacing: 0, vSpacing: 0, padLeft: 0, padTop: 0)

    # Add student list to FXMatrix
    @student_list = FXList.new(student_list_matrix,
                               opts: LIST_BROWSESELECT | LAYOUT_FIX_WIDTH | LAYOUT_FIX_HEIGHT,
                               width: 920, height: 390)# adjust the height
    student_l.each { |el| @student_list.appendItem(el.to_s) }

    # Create vertical layout for filters
    filter_vlayout = FXVerticalFrame.new(main_hlayout,
                                         opts: LAYOUT_SIDE_LEFT | LAYOUT_FILL_Y,
                                         padLeft: 10, padRight: 10, padTop: 10, padBottom: 10)

    # Add checkboxes for filter options
    @surname_filter = FXCheckButton.new(filter_vlayout, "Surname")
    @initials_filter = FXCheckButton.new(filter_vlayout, "Initials")
    @mail_filter = FXCheckButton.new(filter_vlayout, "Email")
    @phone_filter = FXCheckButton.new(filter_vlayout, "Phone")
    @telegram_filter = FXCheckButton.new(filter_vlayout, "Telegram")
    @git_filter = FXCheckButton.new(filter_vlayout, "GitHub")

    # Create vertical layout for application control buttons
    button_vlayout = FXVerticalFrame.new(main_hlayout,
                                         opts: LAYOUT_SIDE_LEFT | LAYOUT_FILL_Y,
                                         padLeft: 10, padRight: 10, padTop: 10, padBottom: 10)

    # Add buttons for application control
    add_button = FXButton.new(button_vlayout, "Add Student")
    update_button = FXButton.new(button_vlayout, "Update Student List")
    edit_button = FXButton.new(button_vlayout, "Edit Student")
    delete_button = FXButton.new(button_vlayout, "Delete Student")
    refresh_button = FXButton.new(button_vlayout, "Refresh List")

    # Disable edit and delete buttons until a row is selected
    edit_button.disable
    delete_button.disable

    # Recalculate layout

  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

students_l = [
  Student.new(id: '1', surname: 'Aurn', first_name: 'Firstn', patronymic: 'Sufu', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '2', surname: 'Burn2', first_name: 'Firstn2', patronymic: 'Sufu2', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '3', surname: 'Curn3', first_name: 'Airstn3', patronymic: 'Sufu3', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '4', surname: 'Durn4', first_name: 'Firstn4', patronymic: 'Sufu4', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '5', surname: 'Eurn5', first_name: 'Airstn5', patronymic: 'Sufu5', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx')
]
app = FXApp.new

# Create an instance of Student_List_View and pass in the app and student_l
view = Student_List_View.new(app, students_l)

# Create and show the main window
app.create
view.show(PLACEMENT_SCREEN)

# Start the application's event loop
app.run