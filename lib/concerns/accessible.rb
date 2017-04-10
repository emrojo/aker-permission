require 'active_support/concern'

module AkerAuthorisationGem
  module Accessible
    extend ActiveSupport::Concern

    included do
      has_many :permissions, as: :accessible, :class_name => 'AkerAuthorisationGem::Permission'
      #after_create :set_default_permission

      def set_default_permission(user_email)
        self.permissions.create([{ permitted: user_email, r: true, w: true }, { permitted: 'world', r: true }])
      end

      # Takes a user_or_group as a string e.g. "blackbeard@sanger.ac.uk" and an access parameter e.g. :r
      def permitted?(email_or_group, access)
        self.permissions.exists?(permitted: email_or_group, access.to_sym => true)
      end
    end

  end
end