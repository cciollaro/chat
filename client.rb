require 'socket'
require 'readline'

CLEAR_CUR_LINE = "\x1b[2K\x1b[0G"
hostname = 'localhost'
port = 8888
your_name = 'you'
their_name = 'anon'
server = TCPSocket.open(hostname, port)

#listener thread
Thread.new do
	while mesg = server.gets
		print CLEAR_CUR_LINE
		puts "#{their_name}: #{mesg}"
		print "#{your_name}: #{Readline.line_buffer}"
	end
end

begin

	while msg = Readline::readline("#{your_name}: ", true)
		server.puts msg
	end
	
rescue Interrupt
									#try to tell the server you've left
	server.puts 'peacin' rescue nil	#but don't worry if you can't
rescue Errno::EPIPE
	puts 'server disconnected'
ensure
	print CLEAR_CUR_LINE
	puts 'bye'
end
