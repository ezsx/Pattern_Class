require 'fox16'

include Fox

class ListWindow < FXMainWindow
  def initialize(app)
    super(app, "List Example", :width => 400, :height => 200)

    @list_widget = FXList.new(self, nil, 0, LIST_SINGLESELECT|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    @list_widget.appendItem("Item 1")
    @list_widget.appendItem("Item 2")
    @list_widget.appendItem("Item 3")

    @list_widget.connect(SEL_COMMAND) do |sender, selector, data|
      if sender == @list_widget
        selected_item = @list_widget.getItemText(@list_widget.currentItem)
        puts "Selected item: #{selected_item}"
      end
    end

    # Call show method to display the window
    show(PLACEMENT_SCREEN)
  end
end

app = FXApp.new
ListWindow.new(app)
app.create
app.run
