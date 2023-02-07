# Найти количество чисел, взаимно простых с заданным.

def gcd(a, b)
  while b != 0
    a, b = b, a % b
  end
  a
end

# Найти сумму цифр числа, делящихся на 3

def sum_div_3(n)
  sum = 0
  while n > 0
    sum += n % 10 if (n % 10) % 3 == 0
    n /= 10
  end
  sum
end

# Найти все делители числа являющийся взаимно простым с
# наибольшим количеством цифр данного числа.

def max_div(n)
  max = 0
  div = 0
  for i in 1..n
    if n % i == 0
      if gcd(n, i) == 1
        if i.to_s.length > max
          max = i.to_s.length
          div = i
        end
      end
    end
  end
  div
end

# вызвать все функции

def main
  puts "Введите число: "
  n = gets.chomp.to_i
  puts "Количество чисел, взаимно простых с #{n}: #{gcd(n, n)}"
  puts "Сумма цифр числа, делящихся на 3: #{sum_div_3(n)}"
  puts "Максимальный делитель числа: #{max_div(n)}"
end

main