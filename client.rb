  require 'socket'
  require 'json'

  hostname = 'localhost'
  port = 2000

  s = TCPSocket.open(hostname, port)

  puts "GET or POST?"
  input = gets.chomp.downcase

  if input == "get"
    request = "GET index.html HTTP/1.0SPLITFROM: cody"
    s.puts(request)
  elsif input == "post"
    puts "Enter your viking's name: "
    name = gets.chomp
    puts "Enter his fighting style: "
    style = gets.chomp
    puts "Enter your email: "
    email = gets.chomp
    data = {:viking => {:name=>name, :stlye=>style, :email=>email} }.to_json
    request = "POST script HTTP/1.0SPLIT#{data}"
    s.puts(request)
  end
  response = s.read
  header, body = response.split("SPLIT", 2)
  puts(header)
  puts(body)
  s.close
