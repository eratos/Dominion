require 'stock'
require 'player'
require 'log'

class Game
  attr_accessor :stock
  
  def initialize(num_players)
    log = Log.instance.log
  
    log.info "Initializing a #{num_players}-player game"
    
    @stock = Stock.new(num_players)
    
    log.debug @stock
    
    @players=[]
    num_players.times {@players << Player.new(self);}
    
    cards = []
    
    turn_player = 0
    
    while @stock.has_provinces? && @stock.empty_stacks < 3
      @players[turn_player].turn
      turn_player = (turn_player + 1) % num_players
    end

    winner = @players.max {|a,b| a.score <=> b.score}

    puts "#{winner.name} is the winner with #{winner.score} points!"

    log.debug @stock
  end  

end

g = Game.new(2)