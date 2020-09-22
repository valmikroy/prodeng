#!/usr/bin/env ruby

require 'pp'


data = RecursiveHash.new()




def splitstring(str)
  d = str.split(/\s+/)
  return d[0], d[6], d[8], d[9]
end


def main()
  File.readlines('resources/nginx_logs').each   do |line|
    ip, site, hcode, lat = splitstring(line)
    data[site.to_sym][ip.to_sym][:lat]  unless   data[site.to_sym].has_key?(ip.to_sym)
    data[site.to_sym][hcode.to_sym] = []  unless   data[site.to_sym].has_key?(site.to_sym)
  end	
end



describe "blah" do 
  it 'some true condition' do
    s = '80.91.33.133 - - [17/May/2015:08:05:04 +0000] "GET /downloads/product_1 HTTP/1.1" 304 0 "-" "Debian APT-HTTP/1.3 (0.8.16~exp12ubuntu10.16)"'
    expect(splitstring(s)).to match([])	
  end
end

class RecursiveHash < Hash
  def initialize
    recurse_hash = proc { |h, k| h[k] = Hash.new(&recurse_hash) }
    super(&recurse_hash)
  end
end
