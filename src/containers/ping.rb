# frozen_string_literal: true

module DiscordContainers
  # A simple ping command
  module Ping
    extend Discordrb::Commands::CommandContainer
    command :ping do |event|
      event.message.edit "Pong! `#{(Time.now - event.timestamp) * 1000} ms`"
    end
  end
end
