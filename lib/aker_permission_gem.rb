require "aker_permission_gem/version"

autoload :Ability, 'ability'
autoload :Accessible,      'concerns/accessible'

module AkerPermissionGem
  autoload :Ability,         'ability'
  autoload :Accessible,      'concerns/accessible'
  autoload :Permission,      'permission'
end
