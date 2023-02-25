require 'fox16'
include Fox

class HelloWorldWindow < FXMainWindow
  def initialize(app)
    # Call the base class constructor first
    super(app, "Hello, World!", :width => 300, :height => 100)

    # Create a horizontal frame to hold the label and button
    hframe = FXHorizontalFrame.new(self, LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # Create a label and add it to the horizontal frame
    @label = FXLabel.new(hframe, "Hello, World!")

    # Create a button and add it to the horizontal frame
    button = FXButton.new(hframe, "Click me!")
    button.connect(SEL_COMMAND) do
      @label.text = "Button clicked!"
    end
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
HelloWorldWindow.new(app)

# Run the application
app.create
app.run
