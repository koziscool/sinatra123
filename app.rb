require 'sinatra'
require_relative 'lib/tower_of_hanoi'

enable :sessions


get '/' do
  @game = TowerOfHanoi.new
  session[ 'towers' ] = @game.towers
  session[ 'game_over' ] = false
  session[ 'valid_move' ] = true
  erb :game, locals: { towers: @game.towers, valid: true, win: false }
end

post '/' do
  @game = TowerOfHanoi.new(session['towers'])

  from = params[ 'from' ].to_i 
  to = params[ 'to' ].to_i

  valid = @game.valid_move?( from, to )
  @game.move( from, to ) if valid

  session[ 'valid_move' ] = valid
  session[ 'towers' ] = @game.towers
  session[ 'game_over' ] = @game.win?


  erb :game, locals: { towers: @game.towers, valid: valid, win: session[ 'game_over' ] }

end
