# sysde

- fork and wait and signals

  ```ruby
  unless (pid = fork)
      puts "going to sleep"
      sleep 2
  else
      puts "waiting for child #{pid} sleep to finish"
      Process.waitpid(pid,0)
  end
  
  # Ruby way 
  
  child_pid = fork do 
    puts "executing in the child"
  end  
  
  puts "Waiting for child to finish"
  Process.waitpid(pid,0)
  
  
  # Creating asignal handler for a child
  
  child_pid = fork do
    puts "Child"
    
    Signal.trap("HUP") do
      puts "HUP Signal caught"
      exit(true)
    end  
  	
    # neverending loop
    while true do end
  
  end  
  
  Process.kill("HUP", child_pid)
  Process.wait  
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

- File read in one shot 

  ```ruby
  File.read('settings.json')
  ```

- Write into a file 

  ```ruby
  open('test.txt', 'w') { |output_file|
      output_file.print 'Write to it just like STDOUT or STDERR'
      output_file.puts 'print(), puts(), and write() all work.'
  }
  ```

  

- JSON parse

  ```ruby
  require 'ruby'
  
  json_object = JSON.parse(File.read('settings.json'))
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
  
  # just a list of array can be collected
  
  Dir['*.png']
  Dir['**/*']  ## Recursively go through directories and get all files
  # Or
  Dir.glob('*.png')
  
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

- Read files from STDIN

  ```ruby
  # ARGF will process these from STDIN
  #cat myfile.txt | ruby myscript.rb
  #ruby myscript.rb < myfile.txt
  
  # ARGF will load these files by name (as if one big input was provided to STDIN)
  #ruby myscript.rb myfile.txt myfile2.txt
  
  
  ARGF.each do |line|
  	puts line
  end
  ```

- Rakefile 

  ```ruby
  #!/usr/bin/ruby
  # Rakefile
  
  task default: [:build, :install]  # Will run :build then :install
  
  task :clean do
      puts "Cleaning"
  end
  
  task :build => [:clean] do  # Will run :clean first
      puts "Building"
  end
  
  task :install do
      puts "Installing"
  end
  
  
  # rake
  # rake clean
  # rake build
  # rake install
  ```

  





