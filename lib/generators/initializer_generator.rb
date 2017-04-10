class InitializerGenerator < Rails::Generators::Base
  def create_initializer_file
    #create_file "config/initializers/initializer.rb", "# Add initialization content here"
    generate "migration CreatePermissions permitted:string:index r:boolean w:boolean x:boolean accessible:references{polymorphic}"
  end
end
