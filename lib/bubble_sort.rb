# frozen_string_literal: true

def bubble_sort(arr)
  sorted = false
  until sorted
    sorted = true
    arr.each_with_index do |_, i|
      next if i >= arr.length - 1

      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        sorted = false
      end
    end
  end
  arr
end
