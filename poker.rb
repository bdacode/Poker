require 'awesome_print'

class Card
  RANKS=%w( A K Q J 10 9 8 7 6 5 4 3 2 )
  SUITS=%w( c d h s )

  attr_accessor :rank, :suit, :face

  def initialize(card_id)
    self.rank = RANKS[card_id % 13]
    self.suit = SUITS[card_id % 4]
    self.face = RANKS[card_id % 13] + SUITS[card_id % 4]
  end
end

class Dealer

  attr_accessor :cards

  def initialize
    self.cards = (0..51).to_a.collect { |card_id| Card.new(card_id) }
  end
  
  def shuffle
    3.times do
      chaos = []
      self.cards.each do |s|
        randomize = rand(chaos.size + 1)
        chaos.insert(randomize, s)
      end
      self.cards = chaos.reverse
    end
  end

  def deal
    dealing = self.cards.slice!(0)
    return dealing
  end

  def spread
  end
end

class Player
  
  attr_accessor :name, :hole, :hand

  def initialize(name, chips)
    @name = name
    @chips = chips
    @hole = []
    @hand = []
  end

  def to_s
    "Player name is: #{@name}\nNumber of chips is: #{@chips}\nHole cards are: #{@hole}"
  end
end

class Table

  attr_accessor :comm

  def initialize
    @comm = []
  end
end

# print("What's your name? ")
p1 = Player.new("Leo", 0)
p2 = Player.new("CPU1", 0)
p3 = Player.new("CPU2", 0)
p4 = Player.new("CPU3", 0)
# puts "Welcome #{p1.name}, don't be a stranger!"
# puts p1

susan = Dealer.new
table = Table.new
susan.shuffle
susan.deal

# ap dealer_deck.cards

2.times do
  p1.hole << susan.deal
end

print "\nHi, #{p1.name}, your hole cards are: "
p1.hole.each do |h|
  print h.face + " "
end

puts "\nTime for the flop..."
3.times do
  table.comm << susan.deal
end
table.comm.each do |c|
  print c.face + " "
end
puts "\nNow it's time for the turn..."
table.comm << susan.deal
print table.comm.last.face
puts "\nAnd now, the river.\n"
table.comm << susan.deal
print table.comm.last.face + "\n"
print "Here's what you're looking at:\n"
p1.hole.each do |h|
  print h.face + " "
end
print "\t"
table.comm.each do |c|
  print c.face + " "
end
p1.hand << p1.hole
p1.hand << table.comm
p1.hand.flatten!
ap p1.hand
p1.hand.each do |h|
  print h.face + " "
end
# print("What's your name? ")
# p1 = Player.new(gets.chomp, 0)
# puts "Welcome #{p1.name}, don't be a stranger!"
# puts p1
# deck = Deck.new
# deck.make
# puts deck.inspect
# deck.shuffle
# puts deck.inspect
# 2.times do
#   p1.hole << deck.deal_hole
# end
# puts p1
# puts deck.inspect