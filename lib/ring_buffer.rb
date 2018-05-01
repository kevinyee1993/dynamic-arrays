require_relative "static_array"

class RingBuffer
  attr_reader :length

  attr_reader :length

  def initialize
    self.length = 0
    self.store = []
    self.capacity = 8
  end

  # O(1)
  def [](index)
    raise("index out of bounds") if index >= self.length
    return store[index]
  end

  # O(1)
  def []=(index, value)
    return nil if index > self.length
    self.store[index] = value
  end

  # O(1)
  def pop
    raise("index out of bounds") if self.length == 0
    self.store.pop
    self.length -= 1


  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.store.push(val)
    self.length += 1
    resize!
  end

  # O(n): has to shift over all the elements.
  def shift
    raise("index out of bounds") if self.length == 0
    self.store.shift
    self.length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.store.unshift(val)
    self.length += 1
    resize!
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    if self.length > self.capacity
      self.capacity *= 2
    end
  end
end
