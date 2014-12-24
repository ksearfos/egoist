mutability
======

Arrays and Hashes that retain their original identities, even after modification.

Mutability is a module that provides the very simple ability to designate an "original" version of an object that is frozen, and will not change even if the working copy of the object does.

This gem comes with the MutableHash and MutableArray, which provide all the functionality of normal Ruby Arrays/Hashes except with the ability to retain a copy of the original form separate from the working version.  This means that they can be modified and the original can be both reviewed and reverted to later on.

The MutableHash/Array both inherit from the Mutable class, which is also packaged in the gem.  If you have your own class you want to add the functionality to, create a Mutable class inherited from Mutable and initialize the way I did:
```
  class MutableThing < Mutable
    def initialize(thing = Thing.new)
      super thing
    end
  end
```

### Array example
Imagine a class representing a deck of cards. There are 52 cards in a deck, and they are in order when first taken out of the box.
```
  class DeckOfCards
    attr_reader :cards

    def initialize
      @cards = MutableArray.new(1..52.to_a)
    end

    def shuffle
      @cards.shuffle
    end

    def deal(amt)
      @cards.take(amt)
    end
  end

  deck = DeckOfCards.new
  deck.shuffle
  deck.cards.revert!    # set back to out-of-box order

  deck.shuffle
  deck.cards.freeze!    # remember order after shuffling
  deck.deal(16)
  deck.cards.revert!    # set back to shuffling order, essentially un-deal
```

### Hash example
Now imagine a class representing foreign-language flashcards.  There are 10 of them, and after you learn them you want to remove the ones you have mastered to be set aside.  But you don't want to throw them out, so that you can review the full set later.
```
  class FrenchNumbers
    attr_reader :flashcards

    def initialize
      @flashcards = MutableHash.new(
          one: 'une',
          two: 'deux',
          three: 'trois',
          four: 'quatre',
          five: 'cinq',
          six: 'six',
          seven: 'sept',
          eight: 'huit',
          nine: 'neuf',
          ten: 'dix'
      )
    end

    def mix
      @cards.shuffle
    end

    def remove_card(card_key)
      @card.delete_if { |k, _v| k == card_key }
    end

    def review
      until @flashcards.empty?
        mix

        # no, I wouldn't normally write this much code in a single method
        @flashcards.each do |english, french|
          print "#{english}\n >> "
          gets guess

          if guess == 'QUIT'
            break
          elsif guess == french
            remove_card(english)
          end
        end
      end

      puts "Congratulations!  You have learned all the flashcards!"
    end
  end

  flashcards = FrenchNumbers.new
  flashcards.review
    $> >> QUIT   # assume there are 5 left

  # some time later...
  flashcards.review
    $> Congratulations!  You have learned all the flashcards!

  # then the mid-term rolls around...
  flashcards.flashcards.revert!
  flashcards.review      # review them ALL
```

Okay, so those are fairly contrived examples.  Still, they should provide an adequate idea of how to use the MutableArray/MutableHash.
