# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store
  attr_accessor :max_val

  def initialize
    self.store = RingBuffer.new
    self.max_val = 0
  end

  def enqueue(val)
    self.store.push(val)
    if val > self.max_val
      self.max_val = val
    end

  end

  def dequeue
    self.store.shift

  end

  def max
    big = 0
    for i in 0..store.length-1
      if store[i] > big
        big = store[i]
      end
    end

    big
  end

  def length
    store.length
  end




  # def initialize
  #   self.store = []
  # end
  #
  # def enqueue(val)
  #   self.store.push(val)
  # end
  #
  # def dequeue
  #   self.store.shift
  # end
  #
  # def max
  #   self.store.max
  # end
  #
  # def length
  #   self.store.length
  # end

end
