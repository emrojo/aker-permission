# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, AkerPermissionGem::Accessible

    can :read, AkerPermissionGem::Accessible do |accessible|
      permitted?(accessible, user, :r)
    end

    can :write, AkerPermissionGem::Accessible do |accessible|
      permitted?(accessible, user, :w)
    end

    can :execute, AkerPermissionGem::Accessible do |accessible|
      permitted?(accessible, user, :x)
    end

  end

  def permitted?(accessible, user_data, access)
    #if user_data.is_a? Hash
    #  user = user_data['user']
    #  groups = user_data['groups']
    #  return accessible.permitted?(user['email'], access) || accessible.permitted?(groups, access)
    #else
      accessible.permitted?(user_data.email, access) || accessible.permitted?(user_data.groups, access)
    #end
  end
end
