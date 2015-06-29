require 'forwardable'

# **************************************************************************
# Mutability::Mutable
#
# This class adds a wrapper around a an object that keeps an unchanged
#  copy of the object.  This allows it to be mutated as much as needed and
#  still be compared against the original version, or even reset to the
#  original.
#
# Adds the freeze! and revert! methods and delegates most methods to the
#  working version (@self).  The following methods act upon the Mutable
#  object itself and not its working version:
#    - #inspect
#    - #=
#    - any equality methods that are not built on #== or #===
# **************************************************************************

module Mutability
  class Mutable
    extend Forwardable

    def_delegators :@self, *Mutability::DELEGATED_METHODS

    attr_reader :original
    attr_accessor :self

    def initialize(original)
      @original = original.freeze   # don't modify, even accidentally!
      revert!
    end

    def freeze!
      @original = deep_clone(@self)
    end

    def revert!
      @self = deep_clone(@original)        # we want an unfrozen copy, so cannot clone
    end

    def respond_to?(method)
      super || @self.respond_to?(method)
    end

    private

    # cheap delegation
    def method_missing(sym, *args, &block)
      @self.send(sym, *args, &block)
    end

    def deep_clone(hash)
      Marshal.load(Marshal.dump(hash))
    end
  end
end
