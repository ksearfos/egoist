egoist
======

Objects with a strong sense of identity.

The Egoist module (when included) adds the ability for an object to track itself at various states, and even to revert to a previous state if desired.  In the simplest terms, this eliminates the need for a duplicate object floating around that stores the original form of something that gets modified a lot.

In particular, the gem comes with predefined Hash and Array variants that include the module.  This is helpful in any cases where you want to work with some sort of collection, adding and subtracting and otherwise modifying its elements, and still keep track of its original form.

For example, imagine you are working with a deck of cards.  The deck needs to be mutable -- that is, it has to change to keep up with what cards have been dealt and what order they were shuffled into.  But occasionally you want to either peak at the full deck in its current order, regardless of what was shuffled -- or even revert back to out-of-the-box order!  With Egoist, this is trivial.
```
class Deck
  attr_reader :cards
  
  def initialize
    @cards = EgoistArray(1..52.to_a)
    @cards.save!                  # original order
  end
  
  def shuffle
    @cards.shuffle!
    @cards.save!('shuffled')      # shuffled order
  end
  
  def deal(amount)
    @cards.shift(amount)
  end
  
  def redeal
    @cards.revert!
    shuffle
    deal
  end
end

d = Deck.new
d.shuffle                      #==>  [24, 29, 5, 1, 51, 41, 39, 21, 45, 7, 19, 42, 23, 31, 32, 50, 34, 3, 17, 22, 10, 4, 15, 35, 40, 52, 38, 14, 27, 46, 9, 12, 2, 26, 8, 6, 18, 44, 49, 36, 11, 25, 13, 28, 48, 47, 20, 16, 33, 43, 37, 30]
4.times { d.deal(5) }

d.deck.shuffled                #==> [24, 29, 5, 1, 51, 41, 39, 21, 45, 7, 19, 42, 23, 31, 32, 50, 34, 3, 17, 22, 10, 4, 15, 35, 40, 52, 38, 14, 27, 46, 9, 12, 2, 26, 8, 6, 18, 44, 49, 36, 11, 25, 13, 28, 48, 47, 20, 16, 33, 43, 37, 30]
d.redeal
d.deck.original                #==> 1..52
d.deck.shuffled                #==> [14, 37, 29, 26, 23, 51, 25, 19, 8, 11, 47, 33, 9, 7, 44, 52, 45, 36, 2, 31, 30, 41, 1, 27, 21, 4, 28, 32, 5, 22, 50, 40, 15, 24, 38, 17, 39, 3, 42, 48, 18, 12, 6, 43, 16, 49, 13, 46, 20, 35, 10, 34]

4.times { d.deal(5) }
d.deck.revert!(:shuffled)      #==> [14, 37, 29, 26, 23, 51, 25, 19, 8, 11, 47, 33, 9, 7, 44, 52, 45, 36, 2, 31, 30, 41, 1, 27, 21, 4, 28, 32, 5, 22, 50, 40, 15, 24, 38, 17, 39, 3, 42, 48, 18, 12, 6, 43, 16, 49, 13, 46, 20, 35, 10, 34]
```
