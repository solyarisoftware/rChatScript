simple [ChatScript](https://github.com/bwilcox-1234/ChatScript) client Ruby gem, with usage examples.

## ChatScript

[ChatScript](https://github.com/bwilcox-1234/ChatScript) is a natural Language tool/dialog manager.d$ CS is 
* CS __language__ is a powerful _metalanguage_ to describe complex conversational flows, where rules are created by humans writers in program scripts through a process called dialog flow scripting. 
* CS __engine__ is a very performant rule-based server. Please refer to the [github home](https://github.com/bwilcox-1234/ChatScript) and the [wiki](https://github.com/bwilcox-1234/ChatScript/tree/master/WIKI).
 
  > BTW, I'm happy to have contributed myself to the above mentioned wiki pages.

## ChatScript client-server mode

CS can run in two way:

* _standalone_ (interactive console)
* as a TCP _server_. This gem is just a Ruby implementation of a ChatScript client.
  More info in the [Client/Server Manual](https://github.com/bwilcox-1234/ChatScript/blob/master/WIKI/CLIENTS-AND-SERVERS/ChatScript-ClientServer-Manual.md).


## Install ChatScript and run the server

Install ChatScript from github repo:

    $ git clone https://github.com/bwilcox-1234/ChatScript

Set LinuxChatScript64 executable:

    $ chmod +x ChatScript/BINARIES/LinuxChatScript64

Run ChatScript server in background:

    $ nohup sh -c 'cd /your_path/ChatScript/BINARIES && ./LinuxChatScript64 port=1024' >/dev/null 2>&1 &


## Install the rChatScript gem

Add this line to your application's Gemfile:
```ruby
gem 'chatscript'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chatscript


## Usage examples

### Basic volley 

In ChatScript parlance, a _volley_  is a synchronous interaction (request/response) 
between a _user_ and a _bot_ (running as a CS engine application).
Here and example of a simple request/reponse in-bound text _volley_ 
([source](examples/simple/simple.rb)):

```ruby

# simple.rb
require 'chatscript'

# create a client for the bot with name 'Harry'
harry = ChatScript::Client.new bot: 'Harry'

# set username
user = 'giorgio'

# Hello message
text = 'Hello!'

#
# send a message from user 'giorgio' to bot 'Harry' 
# and get the bot's reply (the text without the OOB)
#
bot_reply = harry.volley(text, user: user).text
#=> I don't know what to say.

```


### Out Of Bound (OOB) Messages

```ruby
# create a message containing just the text part:
msg = ChatScript::Message.new ' this message contains just the text part '

msg.text
#=> "this message contains just the text part"
msg.oob
#=> ""

# create a message initialized with text part and oob part: 
msg =  ChatScript::Message.new 'Bonjour a tout le monde', oob: 'introductions_setup()'
    
msg.text
#=> "Bonjour a tout le monde"
    
msg.oob
#=> "introductions_setup()"
    
# create a message from a single string containing both text and oob parts:
msg =  ChatScript::Message.new '[  this is an oob message  ] hi there! '
    
msg.text
#=> "hi there!"
    
msg.oob
#=> "this is an oob message"
    
msg.to_str
#=> "[ this is an oob message ] hi there!"

```

#### Asyncronous events 

TODO - how to manage events and push notification with ChatScript OOB messages. 

#### Driving instant messaging GUI

TODO - how to use OOB messages for enhance text reply with other instant messaging chat app media (photo, videos, voice messages, etc.)

### A custom client console

TODO - a comfortable Linux CLI console for ChatScript developers

### Integrate ChatScript with any channel

#### Telegram Messenger Adapter

Very simple! Here below an extract ([source](examples/telegram/telegram.rb)):

```ruby
    case message

    when '/start' # initial message
      reply = cs_bot.start(user: user_id).text
      telegram.api.send_message(chat_id: chat_id, text: reply)

      puts "#{timestamp} < #{reply}"

    else # all other user messages
      reply = cs_bot.volley(message, user: user_id).text
      telegram.api.send_message(chat_id: chat_id, text: reply)

      # log bot reply
      puts "#{timestamp} < #{reply}"
```

![](/examples/telegram/screenshot_1.png)
 

## Licence


    The MIT License (MIT)

    Copyright (c) 2017 Giorgio Robino

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


## Contact

- blog: [@solyarisoftware](http://www.twitter.com/solyarisoftware)
- mail: [giorgio.robino@gmail.com](mailto:giorgio.robino@gmail.com)

