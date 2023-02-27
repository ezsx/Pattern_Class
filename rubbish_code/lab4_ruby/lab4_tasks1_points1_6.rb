require 'fox16'
include Fox


# chatGPT create a good template, but needed refactoring

class StudentAppWindow < FXMainWindow
  def initialize(app, student_data)
    super(app, "Student List", :width => 800, :height => 600)

    @student_data = student_data

    # Create main horizontal layout
    main_hlayout = FXHorizontalFrame.new(self,
                                         LAYOUT_SIDE_TOP|LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # Create vertical layout for student list
    student_list_vlayout = FXVerticalFrame.new(main_hlayout,
                                               LAYOUT_SIDE_LEFT|LAYOUT_FILL_Y)

    # Create student list and populate it with data
    @student_list = FXList.new(student_list_vlayout, :opts => LIST_BROWSESELECT|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    update_student_list()

    # Create vertical layout for filters
    filter_vlayout = FXVerticalFrame.new(main_hlayout,
                                         LAYOUT_SIDE_LEFT|LAYOUT_FILL_Y)
    filter_vlayout.width = 200

    # Add checkboxes for filter options
    @surname_filter = FXCheckButton.new(filter_vlayout, "Surname")
    @initials_filter = FXCheckButton.new(filter_vlayout, "Initials")
    @mail_filter = FXCheckButton.new(filter_vlayout, "Email")
    @phone_filter = FXCheckButton.new(filter_vlayout, "Phone")
    @telegram_filter = FXCheckButton.new(filter_vlayout, "Telegram")
    @git_filter = FXCheckButton.new(filter_vlayout, "GitHub")

    # Create vertical layout for application control buttons
    button_vlayout = FXVerticalFrame.new(main_hlayout,
                                         LAYOUT_SIDE_LEFT|LAYOUT_FILL_Y)

    # Add buttons for application control
    add_button = FXButton.new(button_vlayout, "Add Student")
    update_button = FXButton.new(button_vlayout, "Update Student List")
    edit_button = FXButton.new(button_vlayout, "Edit Student")
    delete_button = FXButton.new(button_vlayout, "Delete Student")
    refresh_button = FXButton.new(button_vlayout, "Refresh List")

    # Disable edit and delete buttons until a row is selected
    edit_button.disable()
    delete_button.disable()

    # Connect signals to slots for button functionality
    add_button.connect(SEL_COMMAND) do
      # Open add student dialog
      add_dialog = StudentAddDialog.new(self)
      if add_dialog.execute() == 1
        # Add new student to list and update display
        new_student = add_dialog.get_student()
        @student_data.add_student(new_student)
        update_student_list()
      end
    end

    update_button.connect(SEL_COMMAND) do
      # Update student data from source and update display
      @student_data.update_from_source()
      update_student_list()
    end

    edit_button.connect(SEL_COMMAND) do
      # Get index of selected student and open edit student dialog
      index = @student_list.currentItem()
      student = @student_data.get_student(index)
      edit_dialog = StudentEditDialog.new(self, student)
      if edit_dialog.execute() == 1
        # Update student in list and update display
        updated_student = edit_dialog.get_student()
        @student_data.update_student(index, updated_student)
        update_student_list()
      end
    end

    delete_button.connect(SEL_COMMAND) do
      # Get index of selected student and delete from list
      index = @student_list.currentItem()
      @student_data.delete_student(index)
      update_student_list()
    end

    refresh_button.connect(SEL_COMMAND) do
      # Apply filters and update student list display
      filters =[filter_checkbox1, filter_checkbox2, filter_checkbox3]
      filtered_students = students.select do |student|
        filters.all? { |filter| filter.checked? ? student.send(filter.text) : true }
      end

      # Update student list display with filtered students
      student_list.clear_items
      filtered_students.each { |student| student_list.appendItem("#{student.name} - #{student.age} - #{student.gpa}") }
    end

    # Set up button for adding a new student
    add_button = FXButton.new(control_panel, "Add Student")

    add_button.connect(SEL_COMMAND) do
      # Open dialog to input new student data
      input_dialog = FXInputDialog.new(main_window, "Add Student", "Enter student information")

      # Set up fields for input dialog
      name_field = FXTextField.new(input_dialog, 30)
      age_field = FXTextField.new(input_dialog, 30)
      gpa_field = FXTextField.new(input_dialog, 30)

      # Add fields to input dialog
      input_dialog.addTextField("Name:", name_field)
      input_dialog.addTextField("Age:", age_field)
      input_dialog.addTextField("GPA:", gpa_field)

      # Show input dialog and wait for user to input data
      if input_dialog.execute != 0
        # Create new student with input data
        new_student = Student.new(name_field.text, age_field.text.to_i, gpa_field.text.to_f)

        # Add new student to list of students
        students << new_student

        # Update student list display
        student_list.appendItem("#{new_student.name} - #{new_student.age} - #{new_student.gpa}")
      end
    end

    # Set up button for updating student list
    update_button = FXButton.new(control_panel, "Update List")

    update_button.connect(SEL_COMMAND) do
      # Update student list display with current list of students
      student_list.clear_items
      students.each { |student| student_list.appendItem("#{student.name} - #{student.age} - #{student.gpa}") }
    end

    # Set up button for editing a selected student
    edit_button = FXButton.new(control_panel, "Edit Student")
    edit_button.disable

    edit_button.connect(SEL_COMMAND) do
      # Get index of selected student in student list
      selected_index = student_list.currentItem

      # Open dialog to edit student data
      input_dialog = FXInputDialog.new(main_window, "Edit Student", "Edit student information")

      # Set up fields for input dialog and fill them with current student data
      name_field = FXTextField.new(input_dialog, 30, :opts => TEXTFIELD_READONLY)
      name_field.text = students[selected_index].name
      age_field = FXTextField.new(input_dialog, 30)
      age_field.text = students[selected_index].age.to_s
      gpa_field = FXTextField.new(input_dialog, 30)
      gpa_field.text = students[selected_index].gpa.to_s

      # Add fields to input dialog
      input_dialog.addTextField("Name:", name_field)
      input_dialog.addTextField("Age:", age_field)
      input_dialog.addTextField("GPA:", gpa_field)

      # Show input dialog and wait for user to input data
      if input_dialog.execute != 0
        # Update selected student with input data
        students[selected_index].name = name_field.text
        students[selected_index].age = age_field.text.to_i
        students[selected_index].gpa = gpa_field.text.to_f

        # Update selected student with input data
        students[selected_index].name = name_field.text
        students[selected_index].age = age_field.text.to_i
        students[selected_index].gpa = gpa_field.text.to_f

        # Clear input fields and update student list display
        clear_input_fields
        update_student_list_display

        # Disable edit/delete buttons
        edit_button.enabled = false
        delete_button.enabled = false
        # Clear input fields
        name_field.text = ""
        age_field.text = ""
        gpa_field.text = ""

        # Update student list display
        update_student_list
      end

      # Delete button action
      delete_button.connect(SEL_COMMAND) do
        # Get selected index
        selected_index = student_list.currentRow

        # Delete selected student from list
        students.delete_at(selected_index)

        # Clear input fields
        name_field.text = ""
        age_field.text = ""
        gpa_field.text = ""

        # Update student list display
        update_student_list

        # Disable edit and delete buttons
        edit_button.enabled = false
        delete_button.enabled = false
      end

      # Add all widgets to the main window
      main_window.add(student_list_frame, :expand => true, :fill => [true, true])
      main_window.add(filter_frame, :expand => true, :fill => [true, true])
      main_window.add(control_frame, :expand => true, :fill => [true, true])

      # Show main window
      main_window.show(PLACEMENT_SCREEN)

      # Start FXRuby main event loop
      FXApp.run
    end
    StudentAppWindow.create
  end
end

require 'fox16'

include Fox

# Define the application class
class StudentManager < FXApp
  def initialize
    # Initialize base class
    super("Student Manager", "FXRuby")

    # Create main window
    @main_window = FXMainWindow.new(self, "Student Manager", nil, nil, DECOR_ALL)

    # Define the student list
    @students = [
      Student.new("John", 20, 3.5),
      Student.new("Jane", 21, 3.2),
      Student.new("Bob", 19, 3.8),
      Student.new("Alice", 22, 3.6)
    ]

    # Create student list display
    @list = StudentList.new(@main_window, @students)

    # Create filter panel
    @filter_panel = FilterPanel.new(@main_window, @list)

    # Create control panel
    @control_panel = ControlPanel.new(@main_window, @list, @students)

    # Create new student dialog
    @new_student_dialog = NewStudentDialog.new(@main_window, @students)

    # Create edit student dialog
    @edit_student_dialog = EditStudentDialog.new(@main_window, @students)

    # Handle main window close
    @main_window.connect(SEL_CLOSE) do
      self.quit
    end
  end

  def create
    # Create main window
    @main_window.create

    # Show main window
    @main_window.show(PLACEMENT_SCREEN)

    # Run the application
    super
  end
end

# Call main method to start the application
if __FILE__ == $0
  StudentManager.new.create
end






