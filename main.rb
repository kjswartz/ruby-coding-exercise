#!/usr/bin/env ruby
require_relative 'lib/game_class'
require_relative 'lib/ranking_table_class'

def main(input_file)
  return unless input_file

  ranking = RankingTable.new
  input_lines = IO.readlines(input_file)
  input_lines.each do |line|
    game = Game.new line
    ranking.add_game(game)
  end
  ranking.write_out
end

main ARGV[0]
