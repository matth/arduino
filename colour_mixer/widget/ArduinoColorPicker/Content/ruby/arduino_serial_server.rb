#!/usr/bin/ruby

require "serialport.so"
require 'socket'

SOCKET = "/tmp/arduino_color_pickr_socket_server" 

if (File.exists?(SOCKET))
  File.delete(SOCKET)
end

# new UNIX Socket server
server = UNIXServer::new(SOCKET)

# params for serial port
port_str = $*[0] 
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
 
open_serial = true
 
while (open_serial == true)

  session = server.accept
  str = session.gets

  if (str.include?("quit")) 
    open_serial = false
  else 
    sp.puts(str)
  end

  session.close

end

sp.close

File.delete(SOCKET)

