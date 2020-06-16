#!/usr/bin/env ruby

require 'pp'


begin 

retry_cnt ||=  0

pid = Process.fork do
  puts "From a child "  + $$.to_s
  #exit -13
end  

Process.waitpid(pid)
status  = Process.last_status.exitstatus

pp status
puts $$

retry_cnt += 1
pp retry_cnt


sleep 5

end while retry_cnt < 3  && status != 0 




