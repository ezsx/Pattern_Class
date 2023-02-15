# Найти количество чисел, взаимно простых с заданным.

def gcd(a, b)
  while b != 0
    a, b = b, a % b
  end
  a
end

def phi(n)
  result = n
  i = 2
  while i * i <= n
    if n % i == 0
      while n % i == 0
        n /= i
      end
      result -= result / i
    end
    i += 1
  end
  if n > 1
    result -= result / n
  end
  return result
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
def divisors(n)
  m = 1
  m *= 2 while m * 2 <= n

  primes = []
  2.upto(m) do |i|
    is_prime = true
    2.upto(Math.sqrt(i)) do |j|
      if i % j == 0
        is_prime = false
        break
      end
    end
    primes << i if is_prime
  end

  digits = n.to_s.size

  divisors = []
  1.upto(n) do |d|
    next if n % d != 0 # d не является делителем n
    next if d.gcd(m) != 1 # d не взаимно прост с m
    next if d.to_s.size > digits # количество цифр в d больше, чем в n
    divisors << d
  end

  return divisors
end

# вызвать все функции

def main
  puts "Введите число: "
  n = gets.chomp.to_i
  puts "Количество чисел, взаимно простых с #{n}: #{phi(n)}"
  puts "Сумма цифр числа, делящихся на 3: #{sum_div_3(n)}"
  puts "Максимальный делитель числа взаимно простыми с данным: #{divisors(n)}"
end

main