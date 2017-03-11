require 'time' 
require 'socket' 
require 'timeout'
require "chatscript/version"

module ChatScript


  # https://www.chatbots.org/ai_zone/viewthread/2434/
  class Message
    attr_accessor :text, :oob

    def initialize(text = '', oob: '')
      if text.match(/\[.*\]/).nil?
        # no oob inside txt
        @text = text.strip
        @oob = oob
      else   
        # split oob from txt 
        @oob, @text = text.match(/\[(.*)\](.*)/).captures
        
        # remove any blanks
        @text.strip!
        @oob.strip!
      end
    end  

    def command?
      @text.start_with? ':'
    end

    def to_str
      @oob.empty? ? @text : "[ #@oob ] #@text"
    end  

  end # end class Message 


  class Client

    def self.version
      VERSION
    end

    attr_accessor :hostname, :port, :bot, :default_user 
    attr_reader :error 

    def initialize( hostname: 'localhost', port: 1024, bot: '', 
                    default_user: 'guest', error_handler: method(:error_handler) )
      @hostname = hostname
      @port = port
      @bot = bot
      @default_user = default_user
      @error_handler = error_handler
    end

    # 
    # error handler default method
    # http://stackoverflow.com/questions/522720/passing-a-method-as-a-parameter-in-ruby
    #
    def error_handler
      @error = $!
      STDERR.print "#{timestamp}: runtime error connecting to server: #@error\n" 
    end  

    def last_error
      @error
    end  

    #
    # first volley
    # user message is null (void string)
    #
    def start( user: @default_user ) 
      volley( '', user: user )
    end  


    #
    # send a user message to the bot and get the bot reply
    #
    def volley( message, user: @default_user )
      begin 
        # open client socket 
        socket  = TCPSocket.open(@hostname, @port)

        # send user message to bot
        socket.write( "#{user}\0#{@bot}\0#{message}\0" )

        # return the bot's answer as Message
        Message.new socket.read

      rescue 
        @error_handler.call
      end 
    end  

    #
    # send a user message to the bot and get th ebot reply
    #
    def alive?
      begin 
        # open client socket 
        socket  = TCPSocket.open(@hostname, @port)

        # send an alive check message 
        socket.write( "\0\0\0" )

        Message.new socket.read
        true
      rescue 
        @error_handler.call
        false
      end 
    end  

    private

    # return timestamp in ISO8601 with precision in milliseconds 
    def timestamp
      Time.now.utc.iso8601(3)
    end

  end # end class 

end  # end module
