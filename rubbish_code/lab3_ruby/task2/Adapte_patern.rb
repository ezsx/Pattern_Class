#
# Here is a trivial example of implementing an Adapter Pattern in Ruby:
#
#   Suppose we have two classes: OldPrinter which can only print strings
#   and NewPrinter which can print hashes. We want to use NewPrinter
#   for printing strings too. We can create an adapter class PrinterAdapter
#   which takes an object of OldPrinter and provides an interface that NewPrinter uses.
#

class OldPrinter
  def print_string(text)
    puts text
  end
end

class NewPrinter
  def print_hash(data)
    puts data.values.join(", ")
  end
end

class PrinterAdapter
  def initialize(old_printer)
    @old_printer = old_printer
  end

  def print_data(data)
    if data.is_a?(String)
      @old_printer.print_string(data)
    elsif data.is_a?(Hash)
      NewPrinter.new.print_hash(data)
    end
  end
end

# Now we can use the PrinterAdapter class to print both strings and hashes as follows:

old_printer = OldPrinter.new
adapter = PrinterAdapter.new(old_printer)

adapter.print_data("Hello World") # Output: Hello World

data = { name: "John", age: 25, location: "USA" }
adapter.print_data(data) # Output: John, 25, USA

# In this example, we have used the Adapter Pattern to make the OldPrinter class compatible
# with the NewPrinter class interface.
# The PrinterAdapter class acts as a bridge between the two incompatible interfaces.