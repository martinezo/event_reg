class Admin::SystemConfigsController < ApplicationController
  before_action :set_admin_system_config, only: [:index]

  def index
  end

  def update
    Admin::SystemConfig.update(params)
    #TODO translate notice
    redirect_to admin_system_config_path, notice: 'Configuración actualizada correctamente'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_system_config
      Admin::SystemConfig.get
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_system_config_params
      params[:admin_system_config]
    end
end
