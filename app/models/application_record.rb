##
# A useless wrapper that adds a single unused attribute to everything.
#
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
