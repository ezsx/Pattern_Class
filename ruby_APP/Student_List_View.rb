require 'fox16'
require 'tk'
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
                               width: 920, height: 390) # adjust the height
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
    add_button.connect(SEL_COMMAND) do
      AddStudentWindow.new
    end

    update_button = FXButton.new(button_vlayout, "Update Student List")
    edit_button = FXButton.new(button_vlayout, "Edit Student")


    delete_button = FXButton.new(button_vlayout, "Delete Student")
    delete_button.connect(SEL_COMMAND) do
      student_l.delete_at(@student_list.currentItem)
      refresh_list(student_l)
    end


    refresh_button = FXButton.new(button_vlayout, "Refresh List")
    refresh_button.connect(SEL_COMMAND) do
      refresh_list(student_l)
    end

    # Check if an item is selected in the list
    if @student_list.currentItem >= 0
      # Enable edit and delete buttons
      edit_button.enable
      delete_button.enable
    else
      # Disable edit and delete buttons
      edit_button.disable
      delete_button.disable
    end
    # Recalculate layout

  end

  def refresh_list(student_l)
    # Update the student list with the latest data
    @student_list.clearItems
    student_l.each { |el| @student_list.appendItem(el.to_s) }

    # Clear any filters that may have been applied
    clear_filters
  end

  def clear_filters
    @surname_filter.check = false
    @initials_filter.check = false
    @mail_filter.check = false
    @phone_filter.check = false
    @telegram_filter.check = false
    @git_filter.check = false
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

require 'tk'

class AddStudentWindow
  def initialize
    @root = TkRoot.new { title "Add Student" }
    @frame = TkFrame.new(@root) { padx 10; pady 10; pack }
    @label = TkLabel.new(@frame) { text "Enter student name:"; pack }
    @entry = TkEntry.new(@frame) { pack }
    @button = TkButton.new(@frame) { text "Add"; command { add_student }; pack }
    @result_label = TkLabel.new(@frame) { text ""; pack }
    @entry.bind("Return", proc { add_student })
    @entry.focus
    Tk.mainloop
  end

  def add_student
    name = @entry.get.strip
    if name.empty?
      @result_label.configure(text: "Please enter a name.")
    else
      puts "New student added: #{name}"
      @result_label.configure(text: "New student added: #{name}")
      @entry.delete(0, :end)
      @entry.focus
    end
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