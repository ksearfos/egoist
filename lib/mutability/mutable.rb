require 'forwardable'

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

    def revert!
      @self = @original.dup         # we want an unfrozen copy, so cannot clone
    end

    private

    # cheap delegation
    def method_missing(sym, *args, &block)
      @self.send(sym, *args, &block)
    end
  end
end
