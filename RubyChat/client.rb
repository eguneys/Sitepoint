#!/usr/bin/env ruby -w
require "socket"
class Client
  def initialize( server )
    @server = server
    @request = nil
    @response = nil
    listen
    send
  end

  def listen
    @response = Thread.new do
      loop { # listen for ever
        # listen the server responses
        msg = @server.gets.chomp # gets the server messages
        # show them in the console
        puts "#{msg}"
      }
    end
  end

  def send
    @request = Thread.new do
      loop {# write how much you want
        # read from the console
        msg = $stdin.gets.chomp # gets users input from command line
        # when enter, send the message to the server
        @server.puts( msg )
      }
    end
  end
end

server = TCPSocket.open( ip, port )
client = Client.new( server )