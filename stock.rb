require 'kingdom'

class Stock
  def initialize(num_players)
    @stock = {}
    @stock[:Copper] = 40
    @stock[:Silver] = 40
    @stock[:Gold] = 40
           
    victory_cards = (num_players == 2 ? 8 : 12)       
    @stock[:Estate] = victory_cards + (3*num_players)
    @stock[:Duchy] = victory_cards
    @stock[:Province] = victory_cards
    
    @stock[:Curse] = (num_players - 1) * 10

    Kingdom::Kingdom.shuffle.slice(0...10).each{|card| @stock[card] = 10}
  end
  
  def has_provinces?
    @stock[:Province] > 0
  end
  
  def empty_stacks
    empty = 0
    @stock.each_value {|count| empty += 1 if count == 0}
    empty
  end
  
  def get(card)
    raise "That isn't in stock!"  unless @stock.has_key?(card) && @stock[card] > 0
    @stock[card] -= 1
    Kingdom.const_get(card).clone
  end
  
  def to_s
    @stock.to_s + " with #{empty_stacks} empty stacks"
  end
  
  def buyable_with (treasure)
    @stock.keys.find_all {|k| @stock[k] > 0 && Kingdom.const_get(k).cost <= treasure}
  end

end