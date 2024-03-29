class Users::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?

    if resource.persisted?
      sign_up(resource_name, resource)

      if resource.account_admin?
        flash[:notice] = "Set up your account"
        redirect_to settings_events_host_path(resource.events_host)
      else
        redirect_to root_path
      end

    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

end