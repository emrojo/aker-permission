require "aker_permission_gem/version"

autoload :Ability, 'ability'
autoload :Accessible,      'concerns/accessible'
autoload :AkerPermissionControllerConfig, 'aker_permission_controller_config'

module AkerPermissionGem
  autoload :Ability,         'ability'
  autoload :Accessible,      'concerns/accessible'
  autoload :Permission,      'permission'
end
