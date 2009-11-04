require 'zone'

class Deck < Zone
  
  def initialize(cards=[])
    super(:Deck, cards)
  end
  
  def shuffle!
    @cards.shuffle!
  end
  
  def draw
    raise "Drawing from empty deck" unless @cards.length>0
    @cards.shift
  end
  
end