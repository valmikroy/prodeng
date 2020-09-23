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

- Read file line by line 

  ```ruby
  File.readlines('resources/nginx_logs').each   do |line|
  
      d = line.chomp.split(/\s+/)
  
  end	
  ```

- API query 

  ```ruby
  require 'net/http'
  require 'uri'
  require 'json'
  
  
  
  uri = URI.parse("http://echoip.com")
  response = Net::HTTP.get_response(uri)
  
  ## with basic auth 
  
  uri = URI.parse("https://api.example.com/surprise")
  request = Net::HTTP::Post.new(uri)
  request.basic_auth("banana", "coconuts")
  request.body = "sample data"
  
  req_options = {
    use_ssl: uri.scheme == "https",
  }
  
  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  
  
  ## complex auth 
  
  
  uri = URI.parse("https://api.digitalocean.com/v2/domains/example.com/records")
  request = Net::HTTP::Post.new(uri)
  request.content_type = "application/json"
  request["Authorization"] = "Bearer b7d03a6947b217efb6f3ec3bd3504582"
  request.body = JSON.dump({
    "type" => "A",
    "name" => "www",
    "data" => "162.10.66.0",
    "priority" => nil,
    "port" => nil,
    "weight" => nil
  })
  
  req_options = {
    use_ssl: uri.scheme == "https",
  }
  
  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  
  # response.code
  # response.body
  ```

- Dir walk 

  ```ruby
  def walk(d)
  	Dir.foreach(d) do |x|
  		next if x == '.'  || x == '..'
  		path = "#{d}/#{x}"
  		walk(path) if File.directory?(path)
  		next  if File.directory?(path) # unsure about this line
  		steps_to_act_on_file(path)
  	end
  end
  
  ```

- Threading

  ```ruby
  require 'thread'
  
  
  t = []
  
  
  m = Mutex.new
  
  200.times do |i|
  
  	t << Thread.new do 
  		
      # mutex lock but it could any task which you want to carry 
      m.synchronize  do
  			puts i
  		end
      
  	end
  
  end
  
  # fire threads
  t.map { |x|  x.join }
  ```

- 

