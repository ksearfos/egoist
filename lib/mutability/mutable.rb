require 'forwardable'

module Mutability
  class Mutable
    extend 'Forwardable'

    def_delegator :@self, MUTABILITY::DELEGATED_METHODS

    attr_reader :self, :original

    def initialize(original)
      @self = original
      @original = original.freeze   # don't modify, even accidentally!
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
