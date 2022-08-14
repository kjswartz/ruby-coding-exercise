require_relative '../lib/game_class'
require_relative '../lib/ranking_table_class'

describe RankingTable do
  before do
    @ranking = RankingTable.new
    @game_a = Game.new 'Lions 3, Snakes 3'
    @game_b = Game.new 'Tarantulas 1, FC Awesome 0'
    @game_c = Game.new 'Lions 1, FC Awesome 1'
    @game_d = Game.new 'Tarantulas 3, Snakes 1'
    @game_e = Game.new 'Lions 4, Grouches 0'
  end

  it "pluralizes text with an 's' if number NOT 1" do
    expect(@ranking.send(:pluralize, 1, 'pt')).to eq('pt')
    expect(@ranking.send(:pluralize, 0, 'pt')).to eq('pts')
    expect(@ranking.send(:pluralize, 2, 'pt')).to eq('pts')
  end

  it 'adds 3 points to winning team' do
    @ranking.add_game(@game_e)
    expect(@ranking.rankings['Lions']).to eq(3)
    expect(@ranking.rankings['Grouches']).to eq(0)

    game_b = Game.new 'Lions 2, Grouches 5'
    @ranking.add_game(game_b)
    expect(@ranking.rankings['Lions']).to eq(3)
    expect(@ranking.rankings['Grouches']).to eq(3)
  end

  it 'adds 1 points to both teams if tie' do
    @ranking.add_game(@game_a)
    expect(@ranking.rankings['Lions']).to eq(1)
    expect(@ranking.rankings['Snakes']).to eq(1)

    game_b = Game.new 'Lions 2, Snakes 5'
    @ranking.add_game(game_b)
    expect(@ranking.rankings['Lions']).to eq(1)
    expect(@ranking.rankings['Snakes']).to eq(4)
  end

  it 'sorts rankings based on descending score and then alphabetically if tie' do
    @ranking.add_game(@game_a)
    @ranking.add_game(@game_b)
    @ranking.add_game(@game_c)
    @ranking.add_game(@game_d)
    @ranking.add_game(@game_e)

    expect(@ranking.rankings).to eq({ 'FC Awesome' => 1, 'Grouches' => 0, 'Lions' => 5, 'Snakes' => 1,
                                      'Tarantulas' => 6 })
    expect(@ranking.send(:sorted_rankings)).to eq([['Tarantulas', 6], ['Lions', 5], ['FC Awesome', 1], ['Snakes', 1],
                                                   ['Grouches', 0]])
  end

  it 'compiles rankings based on score' do
    @ranking.add_game(@game_a)
    @ranking.add_game(@game_b)
    @ranking.add_game(@game_c)
    @ranking.add_game(@game_d)
    @ranking.add_game(@game_e)
    expect(@ranking.send(:compile_rankings)).to eq([[1, 'Tarantulas', 6], [2, 'Lions', 5], [3, 'FC Awesome', 1],
                                                    [3, 'Snakes', 1], [5, 'Grouches', 0]])
  end

  it 'formats a ranking arr to string' do
    ranking = [1, 'team_name', 3]
    expect(@ranking.send(:format_output_line, ranking)).to eq('1. team_name, 3 pts')
  end
end
