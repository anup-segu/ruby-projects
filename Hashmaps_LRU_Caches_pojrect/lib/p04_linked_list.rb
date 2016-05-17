
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @count = 0
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @count == 0
  end

  def get(key)
    current_link = first
    until current_link == @tail
       return current_link.val if current_link.key == key
       current_link = current_link.next
    end
    # nil
  end

  def get_link(key)
    current_link = first
    until current_link == @tail
       return current_link if current_link.key == key
       current_link = current_link.next
    end
    # nil
  end

  def include?(key)
    get(key) != nil
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    @tail.prev.next = new_link
    new_link.prev = @tail.prev
    new_link.next = @tail
    @tail.prev = new_link
    @count += 1
  end

  def remove(key)
    current_link = first
    until current_link == @tail
      if current_link.key == key
        current_link.prev.next = current_link.next
        current_link.next.prev = current_link.prev
        @count -= 1
      end
      current_link = current_link.next
      nil
    end

  end

  def each
    current_link = first
    until current_link == @tail
      yield(current_link)
      current_link = current_link.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
