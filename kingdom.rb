require 'card'

module Kingdom
  Copper = Card.new(:Copper, 0, "1 Treasure")
  def Copper.treasure
    1
  end
  
  Silver = Card.new(:Silver, 3, "2 Treasure")
  def Silver.treasure
    2
  end
  
  Gold = Card.new(:Gold, 6, "3 Treasure")
  def Gold.treasure
    3
  end

  Estate = Card.new(:Estate, 2, "1 VP")
  def Estate.vp
    1
  end
  
  Duchy = Card.new(:Duchy, 5, "3 VP")
  def Duchy.vp
    3
  end
  
  Province = Card.new(:Province, 8, "6 VP")
  def Province.vp
    6
  end

  Gardens = Card.new(:Gardens, 4, "Worth 1VP for every 10 cards in your deck (rounded down)")
  def Gardens.vp
    @owner.deck_size / 10
  end
                                                                                                                                                          
  Curse = Card.new(:Curse, 0, "-1 VP")
  def Curse.vp
    -1
  end
  
  Cellar = Card.new(:Cellar, 2, "+1 Action.  Discard any number of cards.  +1 Card per card discarded")
  def Cellar.action
    @owner.gain_actions(1)
    #TODO
    #x = 0
    #loop {break unless @owner.optional_discard; x+=1}
    #x.times {@owner.draw}
  end

  Chapel = Card.new(:Chapel, 2, "Trash up to 4 cards from your hand")
  def Chapel.action
    #TODO
    #4.times {break unless @owner.optional_trash}
  end
  
  Moat = Card.new(:Moat, 2, "+2 Cards.  When another player plays an Attack card, you may reveal this from your hand.  If you do, you are unaffected by that Attack.")
  def Moat.action
    2.times {@owner.draw}
  end
  def Moat.reaction
    #TODO
    #cancel the attack
  end

  Black_Market = Card.new(:Black_Market, 3, "+2 Treasure.  Reveal the top 3 cards of the Black Market deck.  You may buy one of them immediately.  Put the unbought cards on the bottom of the Black Market deck in any order.  (Before the game, make a Black Market deck out of one copy of each Kingdom card not in the supply.)")  
  def Black_Market.action
    @owner.gain_treasure 2
    #TODO
    #reveal 3 from black market deck
    #@owner.optional_buy
    #unbought cards on bottom
  end
  
  Chancellor = Card.new(:Chancellor, 3, "+2 Treasure.  You may immediately put your deck into your discard pile.")
  def Chancellor.action
    @owner.gain_treasure 2
    #TODO
    #@owner.discard_deck if @owner.prompt "Discard deck?"
  end
  
  Village = Card.new(:Village, 3, "+1 Card, +2 Actions.")
  def Village.action
    @owner.draw
    @owner.gain_actions 2
  end
  
  Woodcutter = Card.new(:Woodcutter, 3, "+1 Buy, +2 Treasure")
  def Woodcutter.action
    @owner.gain_buys 1
    @owner.gain_treasure 2
  end
  
  Workshop = Card.new(:Workshop, 3, "Gain a card costing up to 4")
  def Workshop.action
    #TODO
    #@owner.gain_one_of (@stock.find_all {cost <= 4})
  end

  Bureaucrat = Card.new(:Bureaucrat, 4, "Gain a silver card; put it on top of your deck.  Each other player reveals a Victory card from his hand and put it on his deck, or reveals a hand with no Victory cards")
  def Bureaucrat.action
    #TODO
    #@owner.gain(:Silver)
    #@opponents.each {put victory card on top}
  end
  
  Envoy = Card.new(:Envoy, 4, "Reveal the top 5 cards of your deck.  The player to your left chooses one for you to discard.  Draw the rest.")
  def Envoy.action
    #TODO
    #t5 = @owner.reveal 5
    #@owner.discard left_opp.choose t5
    #@owner.draw t5
  end
  
  Feast = Card.new(:Feast, 4, "Trash this card.  Gain a card costing up to 5.")
  def Feast.action
    trash
    #TODO
    #@owner.gain {cost <= 5}
  end
  
  Militia = Card.new(:Militia, 4, "+2 Treasure.  Each other player discards down to 3 cards in his hand.")
  def Militia.action
    @owner.gain_treasure 2
    #TODO
    #@opponents.each {|opp| until opp.hand_size == 3 {opp.discard}}
  end
  
  Moneylender = Card.new(:Moneylender, 4, "Trash a Copper card from your hand.  If you do, +3 Treasure.")
  def Moneylender.action
    #TODO
    #@owner.gain_treasure 3 if @owner.select {title == :Copper}.trash
  end
  
  Remodel = Card.new(:Remodel, 4, "Trash a card from your hand.  Gain a card costing up to 2 more than the trashed card.")
  def Remodel.action
    #TODO
    #c = @owner.select
    #c.trash
    #@owner.gain {cost <= c.cost+2}
  end

  Smithy = Card.new(:Smithy, 4, "+3 Cards.")
  def Smithy.action
    3.times {@owner.draw}
  end
  
  Spy = Card.new(:Spy, 4, "+1 Card, +1 Action.  Each player (including you) reveals the top card of his deck and either dicards it or puts it back, your choice.")
  def Spy.action
    @owner.draw
    @owner.gain_action 1
    #TODO
    #@players.each {|player| c = player.reveal 1; if @owner.prompt "Discard?" then c.discard else c.put back}
  end
  
  Thief = Card.new(:Thief, 4, "Each other player reveals the top 2 cards of his deck.  If they revealed any treasure cards, they trash one of them that you choose.  You may gain any or all of these trashed cards.  They discard the other revealed cards.")
  def Thief.action
    #TODO
    #@owner.opponents.each {|opp| @owner.select opp.reveal 2.find_all {|c| c.is_treasure?}.trash (or gain)}
  end

  Throne_Room = Card.new(:Throne_Room, 4, "Choose an Action card in your hand.  Play it twice.")
  def Throne_Room.action
    #TODO
    #c = @owner.select {|c| c.is_action?}
    #c.action
    #c.action
  end
  
  Council_Room = Card.new(:Council_Room, 5, "+4 Cards, +1 Buy.  Each other player draws a card.")
  def Council_Room.action
    4.times {@owner.draw}
    @owner.gain_buys 1
    #TODO
    #@owner.opponents.each {|opp| opp.draw}
  end
  
  Festival = Card.new(:Festival, 5, "+2 Actions, +1 Buy, +2 Treasure")
  def Festival.action
    @owner.gain_actions 2
    @owner.gain_buys 1
    @owner.gain_treasure 2
  end
  
  Laboratory = Card.new(:Laboratory, 5, "+2 Cards, +1 Action")
  def Laboratory.action
    2.times {@owner.draw}
    @owner.gain_actions 1
  end
  
  Library = Card.new(:Library, 5, "Draw until you have 7 cards in hand.  You may set aside any action cards drawn this way, as you draw them; discard the set aside cards after you finish drawing.")
  def Library.action
    #TODO
    #until @owner.hand_size == 7 {c = @owner.draw; if c.respond_to? :action @owner.optional_set_aside c}
    #set_aside.discard
  end

  Market = Card.new(:Market, 5, "+1 Card, +1 Action, +1 Buy, +1 Treasure")
  def Market.action
    @owner.draw
    @owner.gain_actions 1
    @owner.gain_buys 1
    @owner.gain_treasure 1
  end
  
  Mine = Card.new(:Mine, 5, "Trash a Treasure card form your hand.  Gain a Treasure card costing up to 3 more; put it into your hand.")
  def Mine.action
    #TODO
    #c = @owner.select {|c| c.is_treasure?}.trash
    #@owner.gain (:treasure, cost <= c+3)
  end
  
  Witch = Card.new(:Witch, 5, "+2 Cards.  Each other player gains a Curse card.")
  def Witch.action
    2.times {draw}
    #TODO
    #@owner.opponents.each {|opp| opp.gain(:Curse)}
  end

  Adventurer = Card.new(:Adventurer, 6, "Reveal cards from your deck until you reveal 2 Treasure cards.  Put those Treasure cards into your hand and discard the other revealed cards.")
  def Adventurer.action
    #TODO
    #loop {c = @owner.reveal; if c.respond.to? :treasure then c to hand else c.set_aside }
    #set_aside.discard
  end

  Basic = [:Copper, :Silver, :Gold, :Estate, :Duchy, :Province, :Curse]
  Kingdom = self.constants - Basic - [:Basic, :Kingdom]
end