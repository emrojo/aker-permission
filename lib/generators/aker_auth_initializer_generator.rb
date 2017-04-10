class AkerAuthInitializerGenerator < Rails::Generators::Base
  def create_permission_migration
    generate "migration CreatePermissions permitted:string:index r:boolean w:boolean x:boolean accessible:references{polymorphic}"
  end
end
