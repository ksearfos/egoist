require_relative 'mutable'

module Mutability
  class MutableHash < Mutable
    def initialize(hash = {})
      super hash
    end
  end
end
