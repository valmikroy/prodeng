#!/usr/bin/env ruby

require 'pp'
require 'json'

class RecursiveHash < Hash
def initialize
  recurse_hash = proc { |h, k| h[k] = Hash.new(&recurse_hash) }
    super(&recurse_hash)
  end
end



data = RecursiveHash.new()

File.readlines('resources/nginx_logs').each   do |line|
  l = line.split(/\s+/)
  ip = l[0]
  site = l[6]
  response = l[8]
  latency = l[9]
  x = { :H1XX => 0,
    :H2XX => 0,
    :H3XX => 0,
    :H4XX => 0,
    :H5XX => 0
  }
  unless data.has_key?(site.to_sym)
  data[site.to_sym] = x
  end

  r = /(?<type>\d)\d\d/.match(response)
  key_name = sprintf("H%sXX", r[:type])

  data[site.to_sym][key_name.to_sym] += 1

  #puts ip, site, response, latency 
  #break
end	

p data.to_json
