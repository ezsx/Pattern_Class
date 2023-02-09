# Написать методы, которые находят минимальный,
# элементы, номер первого положительного элемента. Каждая
# операция в отдельном методе. Решить задачу с помощью
# циклов(for и while).

def min(a)
  min = a[0]
  for i in 0...a.size
    if a[i] < min
      min = a[i]
    end
  end
  return min
end

def max(a)
  max = a[0]
  for i in 0..a.size-1
    if a[i] > max
      max = a[i]
    end
  end
  return max
end

def first_positive(a)
#   используем while
  i = 0
  while i < a.size
    if a[i] > 0
      return i
    end
    i += 1
  end
  return "no positive elements"
end

def main
#   ввод массива
  puts "Введите размер массива: "
  n = gets.chomp.to_i
  a = Array.new(n)
  for i in 0..n-1
    puts "Введите элемент массива: "
    a[i] = gets.chomp.to_i
  end
  puts "Минимальный элемент массива: #{min(a)}"
  puts "Максимальный элемент массива: #{max(a)}"
  puts "Номер первого положительного элемента: #{first_positive(a)}"
end

main