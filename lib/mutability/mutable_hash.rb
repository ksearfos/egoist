require 'active_support/hash_with_indifferent_access'
require_relative 'mutable'

module Mutability
  class MutableHash < Mutable
    def initialize(*args)
      super ActiveSupport::HashWithIndifferentAccess.new(*args)   # I just prefer it
    end
  end
end
