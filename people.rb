#Create a parent Person class that contains the attribute name and an initializer to set the name.
class Person
  attr_accessor :name
  def greeting
    puts "Hi, my name is #{name}."
  end
end
#Let's start by creating two classes: one called Student and another called Instructor.
class Student < Person
#The student class has a method called learn that outputs "I get it!".
  def learn
    puts "I get it!"
  end
end

class Instructor < Person
  #The instructor class has a method called teach that outputs "Everything in Ruby is an Object".
  def teach
    puts "Everything in Ruby is an Object."
  end
end
instructor1 = Instructor.new
instructor1.name = "Chris"
instructor1.greeting
student1 = Student.new
student1.name = "Cristina"
student1.greeting
instructor1.teach
student1.learn
student1.teach
#This causes an error because the teach method belongs to the Instructor class
