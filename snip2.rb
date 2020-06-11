#!/usr/bin/env ruby
#
#
# Parse a log file, print line by line
#
# Find top 5 IP addresses with the count

require 'pp'
require 'rspec'


ips = {}
File.readlines('resources/nginx_logs').each do |line|
  ip = line.split(/\s/)[0]
  if ips.has_key?(ip.to_sym)
    ips[ip.to_sym][:200] += 1
  else 
    ips[ip.to_sym] = 1
  end
end

sorted = ips.sort_by { |k,v| v }

pp sorted.reverse[0][0].to_s



# resources/nginx_logs
#def read_logile(filenamresources/nginx_logse)
#  File.readlines(filenaresources/nginx_logsme).each do |line|
#    puts line
#  end
#end

#read_logile('resources/resources/nginx_logsnginx_logs')






#describe "blah" do
#    it 'some true condiresources/nginx_logstion' do
#      expect(true).to mresources/nginx_logsatch(true)
#    end  
#
#    it 'line match'   dresources/nginx_logso 
#
#    end	
#end  
#
