#!/usr/bin/env ruby
#
#fizz buzz problem
# Write a program that outputs the string representation of numbers from 1 to n.
# But for multiples of three it should output “Fizz” instead of the number and
# or the multiples of five output “Buzz”. For numbers which are multiples of
# both three and five output “FizzBuzz”.


#(1..100).to_a.each   do |i|
#  if i%3 == 0 && i%5 == 0
#    puts "FizzBuzz" + " " +  i.to_s
#  elsif i%3 == 0 && i%5 != 0
#    puts "Fizz" + " " + i.to_s
#  elsif i%5 == 0 && i%3 != 0
#    puts "Buzz" + " " + i.to_s
#  else
#    puts i
#  end
#end	


(1..100).to_a.each   do |i|
  s = ''
  s += 'Fizz' if i%3 == 0
  s += 'Buzz' if i%5 == 0
  s.empty? ? (puts i ): (puts s )

end	
