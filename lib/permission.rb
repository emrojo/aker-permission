module AkerPermissionGem
  class Permission < ApplicationRecord
    belongs_to :accessible, polymorphic: true

    before_save :sanitise_permitted
    before_validation :sanitise_permitted

    def sanitise_permitted
      if permitted
        sanitised = permitted.strip.downcase
        if sanitised != permitted
          self.permitted = sanitised
        end
      end
    end
  end
end
