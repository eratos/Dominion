class Zone

  def initialize(name, cards=[])
    @name = name
    @cards = cards
  end

  def <<(card)
    @cards << card
  end
  
  def num_cards
    @cards.length
  end
  
  def score
    total_vp = 0
    @cards.each {|card| total_vp += card.vp if card.respond_to? :vp}
    total_vp
  end

  def summary
    s = "#{@name}: #{@cards.length} cards - "
    @cards.each {|card| s << card.title << " "}
    s
  end
  
  def to_s
    s = "#{@name} contains #{@cards.length} cards: "
    @cards.each {|card| s << card.to_s << " "}
    s
  end
  
  def actions
    @cards.find_all {|card| card.respond_to? :action}
  end
  
  def treasure
    total_treasure = 0
    @cards.each {|card| total_treasure += card.treasure if card.respond_to? :treasure}
    total_treasure
  end
  
  def has_actions?
    actions.length > 0
  end
  
  def each
    @cards.each {|card| yield card}
  end
  
  def remove(card)
    @cards.delete(card)
  end

  def move_to(zone)  
    @cards.dup.each{|card| zone << @cards.delete(card) if !block_given? || yield(card) }
  end

end
