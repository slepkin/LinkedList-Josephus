class Link
  attr_accessor :value, :next

  def initialize(value, given_next = nil)
    @value = value
    @next = given_next
  end
end

class LinkedList
  attr_accessor :head, :length

  def initialize(head_value)
    @head = Link.new(head_value)
    @length = 1
  end

  def last
    link = @head
    link = link.next until link.next.nil?
    link
  end

  def add(next_value)
    last.next = Link.new(next_value)
    @length += 1
  end

  def [](index)
    link = @head
    (index % length).times { |i| link = link.next }
    link
  end

  def delete_at(index)
    precursor = self[index - 1]
    if index == 0
      @head = @head.next
    else
      precursor.next = precursor.next.next
    end
    @length -= 1
  end

  def insert(value, index)
    precursor = self[index - 1]
    new_link = Link.new(value, precursor.next)
    @length += 1
    precursor.next = new_link
  end

end

def josephus(size, step)
  circle = LinkedList.new(0)
  (size-1).times { |i| circle.add(i+1) }
  circle.last.next = circle.head

  exec_index = 0
  until circle.length == 1
    exec_index = (exec_index + step) % circle.length
    circle.delete_at(exec_index)
  end

  circle.head.value
end

puts "Given a circle of size 20, with every third person beheaded, person number:"
puts josephus(20, 3)
puts "will be the last survivor."

