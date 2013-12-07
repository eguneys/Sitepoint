#!/usr/bin/env ruby -w
require "socket"
class Client
  def initialize( server )
    @server = server
    @request = nil
    @response = nil
  end

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
end