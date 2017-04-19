class AkerPermissionGenerator < Rails::Generators::Base
   include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number(dir)
    Time.now.strftime("%Y%m%d%H%M%S")
  end

  def accessible_id_type
    return 'int' unless Rails.configuration.respond_to? :accessible_id_type
    Rails.configuration.accessible_id_type
  end

  def create_permission_migration
    migration_template 'migration_template.rb', 'db/migrate/create_permissions.rb'
  end

end
