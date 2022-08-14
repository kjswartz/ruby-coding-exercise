require_relative '../main'

describe 'Main App' do
  it 'accepts a string file name path of file in relation to main.rb and outputs ranking' do
    expect(main('./spec/sample-input-spec.txt')).to eq(
      [
        [1, 'Tarantulas', 6],
        [2, 'Lions', 5],
        [3, 'FC Awesome', 1],
        [3, 'Snakes', 1],
        [5, 'Grouches', 0]
      ]
    )
  end
end
