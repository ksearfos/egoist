require_relative 'mutable'

module Mutability
  class MutableArray < Mutable
    def initialize(array = [])
      super array
    end
  end
end
