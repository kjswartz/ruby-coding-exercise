require_relative '../lib/game_class'

describe Game do
  before do
    @game = Game.new 'Lions 5, Snakes 3'
  end

  it 'parses passed in string to seperate team names' do
    expect(@game.team_a_name).to eq('Lions')
    expect(@game.team_a[:score]).to eq('5')
    expect(@game.team_b_name).to eq('Snakes')
    expect(@game.team_b[:score]).to eq('3')
  end

  it 'identifies winner if not a tie' do
    expect(@game.winner_name).to eq('Lions')
  end

  it 'identifies a tie if score same' do
    tie_game = Game.new 'Lions 3, Snakes 3'
    expect(tie_game.tie?).to eq(true)
  end
end
