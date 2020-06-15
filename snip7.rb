#!/usr/bin/env ruby

require 'pp'
require 'rspec'



def example_function(input)
  if input > 5
    input   -= 1
  elsif input < 5
    input   += 1  
  end
  return input
end


# Run with  rspec spec --format documentation
describe "Test example function" do 
  it 'decrement' do
    expect(example_function(6)).to match(5)	
  end
  it 'increment' do
    expect(example_function(3)).to match(4)	
  end
  it 'error' do
    expect(example_function(5)).to match(5)	
  end
end
