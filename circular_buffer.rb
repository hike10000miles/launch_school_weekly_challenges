class CircularBuffer

  class BufferEmptyException < RuntimeError; end
  class BufferFullException < RuntimeError; end

  def initialize(length)
    @buffer = []
    @length = length
  end

  def full?
    @buffer.size == @length
  end
  
  def read
    raise BufferEmptyException if @buffer.empty?
    @buffer.shift
  end
  
  def write(value)
    return if value == nil
    raise BufferFullException if full?
    @buffer << value
  end

  def write!(value)
    return if value == nil
    read if full?
    write(value)
  end

  def clear
    @buffer.clear
  end
end
