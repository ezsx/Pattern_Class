array = Array.new(10) { rand(1..100) } # generate array of 10 random integers
File.write("file.txt", array.join("\n")) # write array to file, one element per line
