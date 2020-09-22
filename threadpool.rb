#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pp'
class ThreadPool
  def initialize(size)
    @size = size
    @jobs = Queue.new

    @pool = Array.new(@size) do |i|
      Thread.new do
        Thread.abort_on_exception = true
        Thread.current[:id] = i

        catch(:exit) do
          loop do
            job = @jobs.pop
            job.call
          end
        end
      end
    end

    if block_given?
      yield self
      shutdown
    end
  end

  def schedule(&block)
    @jobs << block
  end

  def shutdown
    @size.times do
      schedule { throw :exit }
    end
    @pool.map(&:join)
    true
  end
end



ThreadPool.new(10) do |pool|
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
  pool.schedule { puts rand(100); sleep 1 }
end  



