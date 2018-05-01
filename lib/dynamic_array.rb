require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.length = 0
    # self.store = []
    self.capacity = 8
    self.store = StaticArray.new(self.capacity)
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
    # self.store.pop
    self.length -= 1
    self.store = self.store[0..-2]
    return store[-2]

  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.length += 1
    resize!
    self.store[length] = val
    # self.store.push(val)
    # self.length += 1
    # resize!
  end

  # O(n): has to shift over all the elements.
  def shift
    raise("index out of bounds") if self.length == 0
    shifted = self.store[0]
    self.store = store[1..-1]
    self.length -= 1
    return shifted
    # self.store.shift
    # self.length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.length += 1
    resize!
    newStore = StaticArray.new(capacity)

    newStore[0] = val
    # for(i in 1..self.store.length-1)
    for i in 1..length-1
      newStore[i] = self.store[i-1]
    end

    self.store = newStore
    return val
    # self.store.unshift(val)
    # self.length += 1
    # resize!
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    if self.length > self.capacity
      self.capacity *= 2
    end
  end
end
