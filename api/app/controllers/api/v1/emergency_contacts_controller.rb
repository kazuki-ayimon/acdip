class Api::V1::EmergencyContactsController < Api::V1::ApplicationController

  # GET /api/v1/emergency_contacts(.json) 緊急連絡先一覧API
  def index
    @emergency_contacts = current_user.emergency_contacts
  end

  # POST /api/v1/emergency_contacts/create(.json) 緊急連絡先作成API(処理)
  def create
    @emergency_contact = current_user.emergency_contacts.build(emergency_contact_params)

    if @emergency_contact.save
      render './api/v1/emergency_contacts/success', locals: { notice: I18n.t('notice.emergency_contact.create') }
    else
      render './api/v1/failure', locals: { alert: I18n.t('alert.emergency_contact.create') }, status: :unprocessable_entity
    end
  end

  # POST /api/v1/emergency_contacts/:id/delete(.json) 緊急連絡先削除API(処理)
  def destroy
    emergency_contact = current_user.emergency_contacts.find(params[:id])

    if emergency_contact.destroy
      render './api/v1/emergency_contacts/success', locals: { notice: I18n.t('notice.emergency_contact.destroy') }
    else
      render './api/v1/failure', locals: { alert: I18n.t('alert.emergency_contact.destroy') }, status: :unprocessable_entity
    end
  end

  private

  def emergency_contact_params
    params.require(:emergency_contact).permit(:name, :phone_number)
  end
end
