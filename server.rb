require 'socket'               # Get sockets from stdlib
require 'json'

server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {
  response = ""
  client = server.accept
  request = client.gets
  headers,body = request.split("SPLIT")
  method, path, version = headers.split(" ")
  if method == "GET" #If get method
    if File.file?(path) #if files exists
      File.open(path, "r") do |file| #read file
        response = "#{version} 200 OK" + "SPLIT" + file.read
      end
    else
      response = "HTTP/1.0 404 NotFound"
    end
  elsif method == "POST"
    params = JSON.parse(body)
    File.open("thanks.html", "r") do |file|
      html = file.read
      html.gsub! "<%= yield %>", "<li>#{params}</li>"
      response = "#{version} 200 OK" + "SPLIT" +"#{html}"
    end
  end
  client.puts(response)
  client.close                 # Disconnect from the client
}
