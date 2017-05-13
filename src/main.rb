# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'

# A small thingy which (ab)uses the proc prefix so it only
# listens for messages coming from itself -> a selfbot
def prefix_trigger(msg)
  return nil unless msg.author.current_bot?
  return nil unless msg.content.start_with? ENV['PREFIX']
  msg.content[ENV['PREFIX'].length..-1]
end

# Create the bot
bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'],
                                          type: :user,
                                          parse_self: true,
                                          prefix: method(:prefix_trigger)

bot.ready do |_event|
  puts '================'
  puts 'READY REEEEEEEEE'
  puts '================'
end

# Lazily Collect all the containers
module DiscordContainers; end
Dir['src/containers/*.rb'].each { |mod| load mod }
DiscordContainers.constants.each do |mod|
  bot.include! DiscordContainers.const_get mod
end

# Run the bot
bot.run
