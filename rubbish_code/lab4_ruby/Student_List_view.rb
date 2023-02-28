

require 'fox16'

include Fox

require '../../ruby_APP/Student'
require '../../ruby_APP/Student_List'
require '../../ruby_APP/Student_Filter_Search'



class Student_List_view < FXMainWindow
  def initialize(app)
    super(app, "Student List", :width => 800, :height => 600)

    @list_widget = FXList.new(self, nil, 0, LIST_SINGLESELECT|LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # Call show method to display the window
    show(PLACEMENT_SCREEN)
  end
end

app = FXApp.new
ListWindow.new(app)
app.create
app.run
