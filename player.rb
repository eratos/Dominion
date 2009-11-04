require 'deck'
require 'zone'
require 'kingdom'

class Player
  attr_accessor :name
  
  @@player_count = 0

  def initialize (game, name="Player #{@@player_count+1}")
    @hand = Zone.new :Hand
    @discard = Zone.new :Discard
    @game = game
    @name = name
    
    @deck = Deck.new
    7.times {@deck << @game.stock.get(:Copper)}     
    3.times {@deck << @game.stock.get(:Estate)}
      
    @deck.shuffle!    
      
    5.times {draw} 
    
    @@player_count += 1
  end
  
  def draw
    begin
      c = @deck.draw
      @hand << c
    rescue
      @discard.dup.each {|card| @deck << @discard.remove(card)}
      @deck.shuffle!
      begin
        c = @deck.draw
        @hand << c
      rescue
        c = nil
        #Neither deck nor discard has any cards - just fail to draw.
      end
    end
    c
  end
  
  def gain_actions(num)
    @actions += num
  end

  def gain_buys(num)
    @buys += num
  end

  def gain_treasure(num)
    @treasure += num
  end
  
  def deck_size
    @deck.num_cards + @hand.num_cards + @discard.num_cards
  end

  def prompt(text)
    puts text
    gets.chomp[0].upcase == "Y"
  end
  
  def turn
    log = Log.instance.log
    
    log.debug "Beginning turn"
    log.debug @hand.summary
    
    @actions = 1
    @buys = 1
    @treasure = 0
    actions_taken = 0
    
    played = Zone.new (:Played)
    while actions_taken < @actions && @hand.has_actions?
      puts @hand.summary
      puts "What can I play?"
      puts @hand.actions
      input = gets.chomp.to_i
      card = @hand.actions[input]
      played << @hand.remove(card)
      card.action
      actions_taken += 1
    end 
    
    cards_bought = 0
    @treasure += @hand.treasure
    
    log.debug "Treasure to spend: #{@treasure}"
    while cards_bought < @buys
      puts @hand.summary
      puts "What can I buy with #{@treasure}?"
      buyable = @game.stock.buyable_with(@treasure)
      buyable.each {|card| puts Kingdom.const_get(card)}
      input = gets.chomp.to_i
      puts "Buying #{buyable[input]}"
      card = @game.stock.get(buyable[input])
      card.owner = self
      @discard << card
      @treasure -= card.cost
      cards_bought += 1
    end 
    
    log.debug "Ending turn"
    log.debug @hand
    log.debug @discard.summary
    played.move_to @discard
    @hand.move_to @discard
    5.times {draw}
    log.debug @hand.summary
    log.debug @discard.summary
  end
  
  def hand_size
    @hand.num_cards
  end
  
  def score
    @hand.score + @deck.score + @discard.score
  end
   
end