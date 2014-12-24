require 'active_support/hash_with_indifferent_access'

module Mutability
  class MutableHash
    include Mutability

    def initialize(*args)
      super ActiveSupport::HashWithIndifferentAccess.new(*args)   # I just prefer it
    end
  end
end
