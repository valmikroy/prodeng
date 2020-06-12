#!/usr/bin/env ruby

require 'pp'

class RecursiveHash < Hash
  def initialize
    recurse_hash = proc { |h,k| h[k] = Hash.new(&recurse_hash) }
    super(&recurse_hash)
  end
end

data = RecursiveHash.new

File.readlines('resources/nginx_logs').each   do |line|

    d = line.chomp.split(/\s+/)

    ip = d[0].split(/\./)[0,3].join('.')
    month = d[3].split(/\//)[1,2].join('-').gsub(/:.*$/,'')

    data[month.to_sym].has_key?(ip.to_sym) ? data[month.to_sym][ip.to_sym] += 1 : data[month.to_sym][ip.to_sym] = 1



end	


data.each   do |month, ips|
  pp month
  pp ips.sort_by{|k,v| v}.reverse[0]
end	


