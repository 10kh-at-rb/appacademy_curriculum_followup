function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

function Course(courseName, department, numCredits) {
  this.courseName = courseName;
  this.department = department;
  this.numCredits = numCredits;
  this.students = [];
}

Student.prototype.name = function () {
  return this.firstName + " " + this.lastName;
};

Student.prototype.enroll = function (course) {
  if (this.courses.lastIndexOf(course) === -1) {
    course.students.push(this.name());
    this.courses.push(course);
  }
};

Student.prototype.courseLoad = function() {
  var courseLoad = {};
  var courses = this.courses;

  for(var i = 0; i < courses.length; i++) {
    if (Object.keys(courseLoad).lastIndexOf(courses[i].department) === -1) {
      courseLoad[courses[i].department] = courses[i].numCredits;
    } else {
      courseLoad[courses[i].department] += courses[i].numCredits;
    }
  }

  return courseLoad;
};

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};

var austin = new Student("Austin", "Gatlin");
var algebra = new Course("Algebra", "Math", 3);
var calculus = new Course("Calculus", "Math", 3);
var quantumMechanics = new Course("Quantum Mechanics", "Physics", 3);
algebra.addStudent(austin);
austin.enroll(calculus);
austin.enroll(quantumMechanics);

// console.log(austin.courseLoad());
console.log(algebra.students);
