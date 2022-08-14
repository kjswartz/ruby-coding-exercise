#!/usr/bin/env ruby
class Game
  attr_reader :team_a, :team_b

  def initialize(line)
    teams_arr = get_teams_arr line
    @team_a = { name: teams_arr[0][:name], score: teams_arr[0][:score] }
    @team_b = { name: teams_arr[1][:name], score: teams_arr[1][:score] }
  end

  def tie?
    @team_a[:score] == @team_b[:score]
  end

  def winner_name
    if tie?
      nil
    else
      @team_a[:score] > @team_b[:score] ? @team_a[:name] : @team_b[:name]
    end
  end

  def team_a_name
    @team_a[:name]
  end

  def team_b_name
    @team_b[:name]
  end

  private

  def get_teams_arr(line)
    line.split(', ').map { |x| x.match(/(?<name>\D+) (?<score>\d+)/) }
  end
end
