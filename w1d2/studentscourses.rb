class Student
  attr_reader :courses

  def initialize(first, last)
    @first = first
    @last = last
    @courses = []
  end

  def name
    "#{@first} #{@last}"
  end

  def enroll(course)
    if(!courses.include?(course))
      courses.push(course)
      course.students << self
    end
  end

  def course_load
    hash = {}
    courses.each do |course|
      key = course.department
      if hash.has_key?(key)
        hash[key] += course.credits
      else
        hash[key] = course.credits
      end
    end
    hash
  end

  def inspect
    "#{@first} #{@last}"
  end

end

class Course
  attr_accessor :students
  attr_reader :credits, :department

  def initialize(course_name, department, credits)
    @course_name = course_name
    @department = department
    @credits = credits
    @students = []
  end

  def add_student(student)
    student.enroll(self)
  end

  def inspect
    "#{@course_name}"
  end

end
