module AkerPermissionClientConfig
  def has_permission?(username_and_groups, role)
    permissions.any? do |permission|
      username_and_groups.include?(permission.permitted) && permission.attributes["permission-type"].to_s==role.to_s
    end
  end

  def self.included(base)

    base.instance_eval do |klass|
      def self.authorize!(role, resource_id, username_and_groups)
        instance = where(id: resource_id).includes(:permissions).first
        unless instance.has_permission?(username_and_groups, role)
          raise AkerPermissionGem::NotAuthorized.new("Not authorised to perform #{role} on #{self} #{resource_id}")
        end
      end
    end
  end
end