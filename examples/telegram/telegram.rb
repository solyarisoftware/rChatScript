require 'telegram/bot'
require 'chatscript'

# return timestamp in ISO8601 with precision in milliseconds
def timestamp
  Time.now.utc.iso8601 #(3)
end

cs_bot = ChatScript::Client.new bot: 'Harry'

# check  if server is alive
unless cs_bot.alive?
  exit
end  

# get environment variable for Telegram token
token = ENV['TELEGRAM_BOT_API_TOKEN']
unless token
  STDERR.puts "environment variable TELEGRAM_BOT_API_TOKEN unset"
  STDERR.puts "export TELEGRAM_BOT_API_TOKEN=your_telegram_bot_api_token"
  exit
end  

# Thank you Alexander Tipugin for: 
#   https://github.com/atipugin/telegram-bot-ruby
#
# BTW:
#   https://core.telegram.org/bots/2-0-intro

Telegram::Bot::Client.run(token) do |telegram|
  telegram.listen do |message|

    chat_id = message.chat.id

    user_id = message.from.id
    user_first_name = message.from.first_name
    user_last_name = message.from.last_name
    user_username = message.from.username

    user_msg = message.text

    puts "#{timestamp} USER #{user_id} #{user_first_name} #{user_last_name} #{user_username}"
    
    # log user message 
    puts "#{timestamp} CHAT #{user_id} > #{user_msg}"

    case user_msg
    
    when '/start' # initial message
      reply = cs_bot.start(user: user_id).text

      telegram.api.send_message(chat_id: chat_id, text: reply)

      # log bot reply
      puts "#{timestamp} CHAT #{user_id} < #{reply}"

    else # all other user messages
      reply = cs_bot.volley(user_msg, user: user_id).text

      telegram.api.send_message(chat_id: chat_id, text: reply)

      # log bot reply
      puts "#{timestamp} CHAT #{user_id} < #{reply}"
    end
  end
end
