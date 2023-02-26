require 'fox16'
include Fox

class StudentListView < FXMainWindow
  def initialize(app)
    # Call the base class constructor first
    super(app, "Student List", :width => 600, :height => 400)

    # Create a tab widget

    hframe = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X|LAYOUT_FILL_Y)

    tab_widget = FXTabBook.new(hframe)

    student_list_tab = FXTabItem.new(tab_widget, "Student List")

    vframe = FXVerticalFrame.new(student_list_tab, :opts => LAYOUT_FILL_X|LAYOUT_FILL_Y)


    control_buttons_hframe = FXHorizontalFrame.new(vframe, :opts => LAYOUT_FILL_X)

    add_button = FXButton.new(control_buttons_hframe, "Add Student")






  end

  def create
    # Create the application instance and the main window
    super
    show(PLACEMENT_SCREEN)
  end
end

# Create the application instance
app = FXApp.new

# Create the main window
StudentListView.new(app)

# Run the application
app.create
app.run
