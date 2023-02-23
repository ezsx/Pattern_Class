# task1

puts "Hello World"

# task2

name = ARGV[0]
puts "Привет, #{name}!!!"

puts "Какой Ваш любимый язык программирования?"
langv = STDIN.gets.chomp
case langv
when "ruby"
  puts "Подлиза!"
when "C++"
  puts "Жесть умный!!"
when "Python"
  puts "Вопросов больше нет..."
else
  puts "Скоро будет Ruby!"
end

name = ARGV[0]
puts "Привет, #{name}!!!"

# task3

puts "Введите команду для ОС"
cmd_os = `#{STDIN.gets.chomp}`
puts cmd_os
# system cmd_os

puts "Введите команду языка ruby"
cmd_ruby= `ruby -e "#{STDIN.gets.chomp}"`
# system "ruby -e \"#{cmd_ruby}\""
puts cmd_ruby