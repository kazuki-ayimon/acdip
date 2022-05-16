class Api::V1::InfomationsController < Api::V1::ApplicationController
  def index
    @infomations = Infomation.by_target(current_user).page(params[:page]).per(Settings['default_infomations_limit'])
    update_infomation_check
  end

  def important
    @infomations = Infomation.by_target(current_user).by_force
  end

  def show
    @infomation = Infomation.find(params[:id])
    return head :not_found if @infomation.blank? || !@infomation.target_user?(current_user) || @infomation.started_at > Time.current

    if @infomation.ended_at.present? && @infomation.ended_at < Time.current
      render './api/v1/failure', locals: { alert: I18n.t('errors.messages.infomation.ended') }, status: :not_found
    end
  end

  private

  def update_infomation_check
    return if current_user.blank? || @infomations.blank? || @infomations.current_page != 1

    current_user.infomation_check_last_started_at = @infomations.first.started_at
    current_user.save!
  end
end