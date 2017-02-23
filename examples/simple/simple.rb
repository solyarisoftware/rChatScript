require 'chatscript'

bot = 'Harry'
user = 'giorgio'
message = 'Hello!'

def info(bot, user)
  puts
  print "client info: " 
  puts "rChatScript version: #{ChatScript::Client.version}"

  print "server info: "
  puts  "#{bot.volley( ':identify', user: user ).text}"
  puts  "             #{bot.volley( ':who', user: user ).text}\n\n"
  #puts "  memstats:" 
  #puts "    #{harry.volley(from_user, ":memstats").text}"
end

harry = ChatScript::Client.new bot: bot

# check  if server is alive
unless harry.alive?
  exit
end  

info harry, user 

loop do
  puts harry.volley(message, user: user).text
  sleep 1
end  

=begin
=end

