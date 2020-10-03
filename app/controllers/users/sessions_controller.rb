# frozen_string_literal: true

class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # resource_params.keys.map(&:to_sym)は,送られてきたパラメータのkeyをチェックし、配列にします
    # 例えば値は[:password, :login]とかになります
    # resource_class.authentication_keysは、先程設定した認証のためのkeyで、つまり[:login]です
    # &でこの２つの積集合をとり、firstメソッドでその中身を取っています
    # つまりfield => :loginです
    field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first
    @resource = nil

    if field
      q_value = get_case_insensitive_field_form_resource_params(field)

      @resource = find_resource(:email, q_value) if q_value.match?(/@/)
      @resource = find_resource(:phone_number, q_value) if q_value.match?(/\A\d{10}$|^\d{11}\z/)
    end

    if @resource && valid_params?(field, q_value) && (!@resource.respond_to?(:active_for_atuhentication?) || @resource.active_for_authentication?)
      valid_password = @resource.valid_password?(resource_params[:password])
      if (@resource.respond_to?(:valid_for_authentication?) && !@resource.valid_for_authentication? { valid_password}) || !valid_password
        return render_create_error_bad_credentials
      end
      @token = @resource.create_token
      @resource.save

      sign_in(:user, @resource, store: false, bypass: false)

      yield @resource if block_given?

      render_create_success
    elsif @resource && !(!@resource.respond_to?(:active_for_atuhentication?) || @resource.active_for_authentication?)
      if @resource.respond_to?(:locked_at) && @resource.locked_at
        render_create_error_account_loked
      else
        render_create_error_not_confirmed
      end
    else
      render_create_error_bad_credentials
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected
  private

  def resource_params
    params.permit(:password, :login)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
