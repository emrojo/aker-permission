module AkerPermissionClientConfig
  def has_permission?(user_email, role)
  	mapping = {read: :r, write: :w, execute: :x}  	
  	permissions.any? do |permission|
  	  (permission.permitted == user_email) && (permission.send(mapping[role]))
  	end
  end

  def self.included(base)
  	base.instance_eval do
	  def self.authorize!(role, resource, user_email)
	  	raise CanCan::AccessDenied.new("Not authorized!", role, resource) unless user_email

	  	# We need to have a resource that has the permissions included. If the paramter does not have
	  	# it, we obtain it again with the inclusion of the permissions
	  	if resource.respond_to?(:permissions)
	  	  instance = resource
	  	else
	  	  # If the parameter is an id:
	  	  if resource.kind_of? String
	  	  	instance = where(id: resource).includes(:permissions).first
	  	  else
	  	  	instance = where(id: resource.id).includes(:permissions).first
	  	  end
	  	end
		unless instance.has_permission?(user_email, role)
		  raise CanCan::AccessDenied.new("Not authorised to perform #{role} on #{instance.class.to_s} #{instance.id}", 
		  	role, instance)
		end
	  end
	end
  end
end