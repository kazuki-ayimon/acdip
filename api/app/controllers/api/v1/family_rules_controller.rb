class Api::V1::FamilyRulesController < Api::V1::ApplicationController
  before_action :set_family_rule, only: %i[show update destroy]

  # GET /api/v1/family_rule(.json) 家族ルール取得API
  # def show

  # end

  # POST /api/v1/family_rules/update(.json) 家族ルール更新API(処理)
  def update
    if @family_rule.update!(family_rule_params)
      render './api/v1/success', locals: { notice: I18n.t('notice.family_rule.update') }
    else
      render './api/v1/failure', locals: { alert: I18n.t('alert.family_rule.update') }, status: :unprocessable_entity
    end
  end

  # POST /api/v1/family_rules/delete(.json) 家族ルールリセットAPI(処理)
  def destroy
    if @family_rule.destroy!
      render './api/v1/success', locals: { notice: I18n.t('notice.family_rule.destroy') }
    else
      render './api/v1/failure', locals: { alert: I18n.t('alert.family_rule.destroy') }, status: :unprocessable_entity
    end
  end

  private

  def set_family_rule
    @family_rule = current_user.prepare_family_rule
  end

  def family_rule_params
    params.require(:family_rule).permit(
      :contact_means_memo,
      :emergency_measure_memo,
      :family_role_memo,
      :leave_home_memo,
      :refuge_memo
    )
  end
end
