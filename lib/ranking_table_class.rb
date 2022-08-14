#!/usr/bin/env ruby

class RankingTable
  attr_reader :rankings

  def initialize
    @rankings = {}
  end

  def add_game(game)
    add_teams game.team_a_name, game.team_b_name
    calculate_ranking_points game
  end

  def write_out
    compile_rankings.each do |ranking|
      line = format_output_line ranking
      puts line
    end
  end

  private

  def add_teams(team_a, team_b)
    @rankings[team_a] ||= 0
    @rankings[team_b] ||= 0
  end

  def calculate_ranking_points(game)
    if game.tie?
      @rankings[game.team_a_name] += 1
      @rankings[game.team_b_name] += 1
    else
      @rankings[game.winner_name] += 3
    end
  end

  def compile_rankings
    sorted_rankings.reduce([]) do |all_arr, ranking|
      prev = all_arr.last
      if prev.nil?
        all_arr.push(ranking.insert(0, 1))
      else
        all_arr.push(ranking.insert(
                       0,
                       prev[2] == ranking[1] ? prev[0] : all_arr.length + 1
                     ))
      end
    end
  end

  # sort by score descending then name ascending
  def sorted_rankings
    @rankings.to_a.sort { |a, b| [b[1], a[0]] <=> [a[1], b[0]] }
  end

  def pluralize(number, text)
    number != 1 ? text + 's' : text
  end

  def format_output_line(ranking)
    ranking[0].to_s + '. ' + ranking[1] + ', ' + ranking[2].to_s + pluralize(ranking[2], ' pt')
  end
end
