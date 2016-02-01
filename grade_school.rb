class School
  def initialize
    @students = {}
  end

  def to_h
    @students.each { |key, _| @students[key] = @students[key].sort }
    students_sorted = {}
    @students.keys.sort.each do |grade|
      students_sorted[grade] = @students[grade]
    end
    students_sorted
  end
  
  def add(name, grade)
    @students[grade] = [] if @students[grade] == nil
    @students[grade] << name
  end

  def grade(num)
    if @students[num] == nil
      @students[num] = []
    else
      @students[num]
    end
  end
  
end

