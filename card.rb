class Card
  attr_accessor :title, :cost, :text, :owner
  
  def initialize(title, cost, text)
    @title = title
    @cost = cost
    @text = text
  end
  
  def to_s
    @title.to_s + ": " + @text
  end
  
  def is_action?
    respond_to? :action
  end

  def is_treasure?
    respond_to? :treasure
  end
  
  def is_vp?
    respond_to? :vp && vp >= 0
  end
  
  def is_curse?
    @title == :Curse
  end
  
  def is_reaction?
    respond_to? :reaction
  end
    
end