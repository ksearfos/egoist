module Mutability
  class MutableArray
    include Mutability

    def initialize(*args)
      super Array.new(*args)
    end
  end
end
