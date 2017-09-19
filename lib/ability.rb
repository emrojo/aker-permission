require 'set'

# https://github.com/ryanb/cancan/wiki/Defining-Abilities-with-Blocks
class Ability
  include CanCan::Ability

  def initialize(user)
    can do |permission_type, subject_class, subject|
      if !user && !subject
        permission_type==:read
      elsif !subject
        [:create, :read].include?(permission_type)
      else
        permitted?(subject, user, permission_type)
      end
    end
  end

  def permitted?(accessible, user, permission_type)
    return (permission_type==:read) if user.nil?
    permission_type==:create || accessible&.permitted?(user.email, permission_type) || accessible&.permitted?(user.groups, permission_type)
  end
end
