# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
#module AkerAuthorisationGem
  class Ability
    include CanCan::Ability

    def initialize(user)
      can :create, AkerAuthorisationGem::Accessible

      can :read, AkerAuthorisationGem::Accessible do |accessible|
        permitted?(accessible, user, :r)
      end

      can :write, AkerAuthorisationGem::Accessible do |accessible|
        permitted?(accessible, user, :w)
      end
    end

    def permitted?(accessible, user, access)
      accessible.permitted?(user.email, access) || accessible.permitted?(user.fetch_groups, access)
    end
  end
#end