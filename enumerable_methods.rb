module Enumerable

  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    selected_items = []
    self.my_each { |item| selected_items << item if yield(item) }
    selected_items
  end

  def my_all?
    self == self.my_select { |item| yield(item) }
  end

  def my_any?
    i = 0
    while i < self.length
      return true if yield(self[i])
      i += 1
    end
    false
  end

  def my_none?
    !self.my_any? { |item| yield(item) }
  end

  def my_count(item=nil)
    count = 0
    if item
      self.my_each { |arr_item| count += 1 if arr_item == item }
      count
    elsif block_given?
      self.my_each { |arr_item| count += 1 if yield(arr_item) }
      count
    else
      self.my_each { |arr_item| count += 1 }
      count
    end
  end

  def my_map(block=nil)
    new_arr = []
    if block
      self.my_each { |item| new_arr << block.call }
    else
      self.my_each { |item| new_arr << yield(item) }
    end
    new_arr
  end

  def my_inject(num=nil)
    num.is_a?(Integer) ? total = num : total = self.shift
    if num.is_a?(Symbol)
      self.my_each { |item| total = total.send(num, item) }
    end
    self.my_each { |item| total = yield(total, item) if block_given? }
    total
  end

end

def multiply_els(arr)
  arr.my_inject { |total, item| total * item }
end

[1,2,3,4].my_each { |num| puts num }
puts "my_each_with_index:"
[6,4,2,8].my_each_with_index { |num, index| puts "#{index}: #{num}" }
puts "my_select: #{[1,2,3,4].my_select { |item| item.even? }}"
puts "my_all?: #{[1, "hey", 2,3,4].my_all? { |item| item.is_a?(Integer) }}"
puts "my_any?: #{[1,2,3,4].my_any? { |item| item == 3 }}"
puts "my_none?: #{[1,2,3,4].my_none? { |item| item == 10 }}"
puts "my_count: #{[1,3,2,4,2,2].my_count}"
blook = Proc.new { |item| item * 2 }
puts "my_map with proc: #{[1,2,3,4].my_map(&blook)}"
puts "my_map with block: #{[1,2,3,4].my_map { |item| item.to_s}}"
puts "my_inject: #{[1,2,3,4].my_inject(3) { |total, item| total + item }}"
puts "multiply_els: #{multiply_els([2,4,5])}"
