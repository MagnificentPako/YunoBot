# frozen_string_literal: true

module DiscordContainers
  # Gives you the markov shit
  module Markov
    extend Discordrb::EventContainer
    extend Discordrb::Commands::CommandContainer

    require 'markov-polo'
    require 'rethinkdb'
    r = RethinkDB::RQL.new
    connection = r.connect(host: 'localhost', port: 28_015, db: 'discord')
    chain = MarkovPolo::Chain.new

    r.table('logs').run(connection).each do |e|
      chain << e.content
    end

    message do |event|
      r.table('logs').insert('content' => event.content).run(connection)
      chain << event.content
    end

    command :markov do |_event|
      chain.generate
    end
  end
end
