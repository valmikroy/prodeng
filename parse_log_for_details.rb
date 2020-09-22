#!/usr/bin/env ruby

require 'pp'

user ={}

File.readlines('resources/users.log').each   do |line|

  u , v = line.chomp.split(/=/)
  user[u.to_sym] = v
end	

pp user.sort_by{|k,v| v.to_i}
