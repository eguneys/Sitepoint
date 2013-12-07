#!/usr/bin/env ruby -w
require "socket"
class Server
  def initialize( port, ip )
    @server = nil
    @connections = Hash.new
    @rooms = Hash.new
    @clients = Hash.new
    @connections[:server] = @server
    @connections[:rooms] = @rooms
    @connections[:clients] = @clients
  end

  def run
    loop {
      Thread.start do |client| # each client thread
      end
    }
  end
end