#!/usr/bin/ruby

require "serialport.so"
require 'socket'

def init

  client = UNIXSocket::new("/tmp/arduino_color_pickr_socket_server")

  if ($*[0] == "quit") 
    client.puts("quit")
  else
    client.puts("R#{format_number($*[0])}~G#{format_number($*[1])}~B#{format_number($*[2])}~")
  end

  client.close

end

def format_number(num)
  while (num.length < 3) 
    num = "0" + num
  end
  return num
end

init
