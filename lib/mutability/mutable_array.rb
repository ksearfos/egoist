require_relative 'mutable'

module Mutability
  class MutableArray < Mutable
    def initialize(*array)
      super array.flatten    # allow either .new(1,2,3) or .new([1,2,3])
    end
  end
end
