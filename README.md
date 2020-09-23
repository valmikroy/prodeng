# sysde

- fork and wait

  ```ruby
  unless (pid = fork)
      puts "going to sleep"
      sleep 2
  else
      puts "waiting for child #{pid} sleep to finish"
      Process.waitpid(pid,0)
  end
  ```

- rescue 

  ```ruby
  f = File.open("testfile")
  begin
    # .. process
  rescue
    # .. handle error
  else
    puts "Congratulations-- no errors!"
  ensure
    f.close unless f.nil?
  end
  ```

- execute a command and check status 

  ```ruby
  system("echo foo | grep bar")
  puts $?.exitstatus
  puts $?.success? 
  puts $?.pid
  ```

- Mixlib shellout 

  ```ruby
  require 'mixlib/shellout'
  
  def shellout!(*c)
        cmd = Mixlib::ShellOut.new(*c)
        cmd.timeout = 3600
        cmd.run_command
        cmd.error!
        cmd.stdout
  end
  
  begin
  
          shellout!("ls")
  
  rescue StandardError => e
          puts e
          puts "failed to execute"
  else
          puts "successfully executed"
  end
  ```

- Ruby retry and other [exception handling](http://rubylearning.com/satishtalim/ruby_exceptions.html)

  ```ruby
  begin
      retries ||= 0
      puts "try ##{ retries }"
      raise "the roof"
  rescue
      retry if (retries += 1) < 3
  end
  ```

- 