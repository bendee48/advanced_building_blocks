def bubble_sort(arr)
  loop do
    swapped = false
    i = 0
    while i < (arr.size) -1
      num1 = arr[i]
      num2 = arr[i+1]
      if num1 > num2
        arr[i] = num2
        arr[i+1] = num1
        swapped = true
      end
      i += 1
    end
    break if !swapped
  end
  arr
end

p bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(arr)
  loop do
    swapped = false
    i = 0
    while i < (arr.size) -1
      item1 = arr[i]
      item2 = arr[i+1]
      res = yield(item1, item2)
      if res > 0
        arr[i] = item2
        arr[i+1] = item1
        swapped = true
      end
      i += 1
    end
    break if !swapped
  end
  arr
end

p bubble_sort_by(["hi","hello","hey"]) { |left,right| left.length - right.length }
