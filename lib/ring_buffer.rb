require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    self.length = 0
    # self.store = []
    self.capacity = 8
    self.store = StaticArray.new(self.capacity)
    self.start_idx = 0
  end

  # O(1)
  def [](index)
    raise("index out of bounds") if index >= self.length
    # return store[index]

    #takes into account the start index being at the end of the array
    self.store[start_idx + index]
  end

  # O(1)
  def []=(index, value)
    return nil if index > self.length
    # self.store[index] = value
    self.store[start_idx + index] = value
  end

  # O(1)
  def pop
    raise("index out of bounds") if self.length == 0
    popped = self.store[self.length - 1 + self.start_idx]
    self.store[self.length - 1 + self.start_idx] = nil
    self.length -= 1

    p "pop"
    p self.store

    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    # self.store[length] = val
    self.length += 1
    resize!
    self.store[length + self.start_idx - 1] = val

    p "push"
    p length + self.start_idx
    p self.store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise("index out of bounds") if self.length == 0
    shifted = self.store[start_idx]
    self.store[start_idx] = nil
    self.length -= 1
    self.start_idx += 1

    # if self.start_idx > self.capacity
    #   self.start_idx = 0
    # end

    p "shifted"
    p self.store

    shifted
    # shifted = self.store[0]
    # self.store = store[1..-1]
    # self.length -= 1
    # return shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.length += 1
    resize!

    self.start_idx -= 1

    if self.start_idx < 0
      new_idx = self.start_idx % self.capacity
    end

    self.store[new_idx] = val

    p "unshifted"
    p self.store
    val
    # self.length += 1
    # resize!
    # newStore = StaticArray.new(capacity)
    #
    # newStore[0] = val
    # for i in 1..length-1
    #   newStore[i] = self.store[i-1]
    # end
    #
    # self.store = newStore
    # return val
  end


  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

#resize not correct can't just copy everything over need to account for
#keeping the extra stuff at the very end of the new array
  def resize!
    if self.length > self.capacity
      prev_capacity = self.capacity
      self.capacity *= 2

      newStaticArr = StaticArray.new(self.capacity)

#need to do this loop using start_idx instead of just the actual idx
      # for i in 0..self.length
      #   newStaticArr[i] = self.store[i]
      # end

#wait leave the start_idx as a negative number and instead just
#evaluate it every time
      for i in 0..self.length - 2
        curr_start_idx = (self.start_idx + i) % self.capacity
        prev_start_idx = (self.start_idx + i) % prev_capacity
        newStaticArr[curr_start_idx] = self.store[prev_start_idx]
      end

      self.store = newStaticArr
    end
  end


end
