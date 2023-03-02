# The Template Method is a design pattern used in Object-Oriented Programming (OOP)
# that defines the basic steps of an algorithm and allows subclasses to override some
# of these steps without changing the overall structure of the algorithm.
# In Ruby, the Template Method pattern can be implemented using the following steps:
#
# Create an abstract base class that defines the basic algorithm and declares
# the methods that will be implemented by the subclasses.
#
# Define a concrete class that implements the methods declared by the base class.
#
# Define a subclass that extends the base class and overrides some of the methods
# to provide specific implementations.
#
# Here is an example of how the Template Method pattern can be implemented in Ruby:

class AbstractClass
  def template_method
    # Basic algorithm steps
    step_one
    step_two
    step_three
  end

  private_class_method :new

  def step_one
    raise NotImplementedError, 'This method should be implemented by the subclass'
  end

  def step_two
    raise NotImplementedError, 'This method should be implemented by the subclass'
  end

  def step_three
    raise NotImplementedError, 'This method should be implemented by the subclass'
  end
end

class ConcreteClass < AbstractClass
  def step_one
    puts 'Step one of the concrete algorithm'
  end

  def step_two
    puts 'Step two of the concrete algorithm'
  end

  def step_three
    puts 'Step three of the concrete algorithm'
  end
end

class Subclass < AbstractClass
  def step_one
    puts 'Step one of the subclass algorithm'
  end

  def step_two
    puts 'Step two of the subclass algorithm'
  end
end

#
# In this example, the `AbstractClass` is the base class that defines the basic algorithm with the
# `template_method` and the abstract methods `step_one`, `step_two`, and `step_three`.
# The `ConcreteClass` extends the `AbstractClass` and provides concrete implementations
# of all the abstract methods. Finally, the `Subclass` extends the `AbstractClass` and overrides only
# `step_one` and `step_two` methods.
#
#  You can then use the `template_method` of each class to run the
# algorithm with the specific steps implemented by each subclass:

abstract = AbstractClass.new
abstract.template_method
# This will raise NotImplementedError for each abstract method

concrete = ConcreteClass.new
concrete.template_method
# This will run the concrete algorithm implemented by ConcreteClass

subclass = Subclass.new
subclass.template_method
# This will run the subclass algorithm with the specific steps overridden in Subclass
#
# In summary, the Template Method pattern in Ruby
# allows you to define a basic algorithm with abstract
# methods that will be implemented by subclasses. This pattern helps you to reduce code
# duplication and enforce a common structure for your algorithms while still allowing
# for flexibility and customization in specific cases.
#   end