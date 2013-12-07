# TCP Ruby Chat
Hi, my name is Simon Escobar and we are going to build a little TCP ruby chat
using the ruby standard library Socket, I'm using ruby 2.0.0 so lets begin.

First we are going to create the necessary files:
    'server.rb'
    'client.rb'
In server.rb and client.rb we have to require the socket library
```ruby
require "socket"
```
then create the respective classes with some attributes to handle users and
rooms
```ruby
class Client
  def initialize server
    @server = server
    @request = nil
    @response = nil
  end
end

class Server
  def initialize port, ip
    @server = nil
    @connections  = {}
    @rooms = {}
    @clients = {}
  end
end
```

The client receive a server instance so it can establish a connection with the server
then, initialize a request and response instance variables for sending and receiving
messages.

The server receive a port which is our channel for establishing a connection between
users, so it can listen the port for any event and send a response to everybody who
is interested in. Also we create 3 hashes.
* Pool of users connected to server
* Rooms which can handle users and an array of rooms
* Clients which are the users instances
```ruby
connections: {
  clients: { client_name: {attributes}, ... },
  rooms: { room_name: [clients_names], ... }
}
```
this way we can know which user is in which room, so the client name must be unique.

then we need to create two threads on client side so it can write/read messages at the same
time, without this functionality our chat would be a very boring and nasty chat

```ruby
@request = Thread.new do
  loop { # write how much you want
    # read from the console
    # when enter, send the message to the server
  }
end

@response = Thread.new do
  loop { # listen for ever
    # listen the server responses
    # show them in the console
  }
end
```

now we are going to build some methods to handle both operations Listen and Write

```ruby
def listen
  @response = Thread.new do
    loop {

    }
  end
end

def send
  @request = Thread.new do
    loop {

    }
  end
end
```

On server side we need something similar, but we need one thread per each user
connected to it, this way we can handle as much users as possible without any concurrency
problem.

```ruby
def run
  loop {
    Thread.start do |client| # each client thread
    end
  }
end
```

lets get dirty coding TCP code, by the way the and PORT MUST be the same
in the client side and server side, and in this case should be in the localhost
```ruby
# client side
server = TCPSocket.open( ip, port )
client = Client.new( server )

# on initialize
# ask user name
listen # call listen method to create the response thread
send #call send method to create the request thread

# on listen inside loop
msg = @server.gets.chomp # gets the server message
puts "#{msg}"

# on send loop
msg = $stdin.gets.chomp # gets users input from commando line
@server.puts( msg )
```

on the other hand
```ruby
# on initialize
@server = TCPServer.open( ip, port )

# on run method inside loop
# for each user connected and accepted by server, create a new thread and pass
# client instance to the block
Thread.start(@server.accept) do | client |
  nick_name = client.gets.chomp.to_sym
  @connections[:clients].each do |other_name, other_client|
    if nick_name == other_name || client == other_client
      client.puts "This username already exist"
      Thread.kill self
    end
  end
  @connections[:clients][nick_name] = client
end
```