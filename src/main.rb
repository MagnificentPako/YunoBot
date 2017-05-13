require "discordrb"
require "dotenv/load"

def prefix_trigger(msg)
    return nil unless msg.author.current_bot?
    return nil unless msg.content.start_with? ENV["PREFIX"]
    msg.content[ENV["PREFIX"].length..-1]
end

bot = Discordrb::Commands::CommandBot.new token: ENV["TOKEN"], type: :user, parse_self: true, prefix: method(:prefix_trigger)
#bot.should_parse_self = true

bot.command :ping do |event|
    event.respond "Pong"
end

#bot.message { |e| puts e.message.inspect }

bot.run
