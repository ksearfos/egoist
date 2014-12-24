module Mutability
  DELEGATED_METHODS = %i(to_s == === is_a? kind_of?)
end

# these use this module, so need to require post-definition
require 'mutability/mutable_hash'
require 'mutability/mutable_array'
