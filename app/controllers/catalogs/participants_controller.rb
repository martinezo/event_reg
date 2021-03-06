class Catalogs::ParticipantsController < ApplicationController
  layout 'admin'
  before_action :set_catalogs_participant, only: [:show, :edit, :update, :destroy_participant, :confirm_participant, :delete]
  before_action :authorize_resource, only: [:edit, :show, :destroy_participant, :delete]

  helper_method :sort_column, :sort_direction
  require 'pdf_generator'
  require 'xlsx_generator'

  # GET /catalogs/participants
  # GET /catalogs/participants.json
  def index
  end

  def list
    course = Catalogs::Course.find(params[:course_id])
    @course_name = course.name
    @catalogs_participants = Catalogs::Participant.search(params[:search], params[:course_id]).order("#{sort_column} #{sort_direction}").paginate(per_page: 15, page: params[:page])
    authorize! :update, course, :message => "Not autorized for this course"
  end

  # GET /catalogs/participants/1
  # GET /catalogs/participants/1.json
  def show
  end

  # GET /catalogs/participants/new
  def new
    @catalogs_participant = Catalogs::Participant.new
    @catalogs_participant.course_id = params[:course_id]
    # El nombre de la variable de instancia del curso debe llamarse @cc
    # porque el template para la vista pública usa esta variable para
    # tomar los colores del tema
    # @cc = Catalogs::Course.find(params[:course_id])
  end

  # GET /catalogs/participants/1/edit
  def edit
    #@cc = Catalogs::Course.find(params[:course_id])
  end

  # POST /catalogs/participants
  # POST /catalogs/participants.json
  def create
    @catalogs_participant = Catalogs::Participant.new(catalogs_participant_params)

    respond_to do |format|
      if @catalogs_participant.save
        filename = "public/pdf/#{@catalogs_participant.pdf_reg_filename}"
        PdfGenerator.registration(@catalogs_participant, filename)
        format.html { redirect_to @catalogs_participant, notice: t('notices.saved_successfully') }
        format.json { render action: 'show', status: :created, location: @catalogs_participant }
      else
        format.html { render action: 'new' }
        format.json { render json: @catalogs_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catalogs/participants/1
  # PATCH/PUT /catalogs/participants/1.json
  def update
    @catalogs_participant = Catalogs::Participant.find(params[:id])

    #upload 'upload file 1'
    filename =  params[:catalogs_participant][:upload_file1]
    upload_file = params[:catalogs_participant_upload_file1_tag]
    @catalogs_participant.upload_file(upload_file, @catalogs_participant.upload_file1_s(filename)) if upload_file

    #upload 'upload file 2'
    filename =  params[:catalogs_participant][:upload_file2]
    upload_file = params[:catalogs_participant_upload_file2_tag]
    @catalogs_participant.upload_file(upload_file, @catalogs_participant.upload_file2_s(filename)) if upload_file

    #upload 'upload file 3'
    filename =  params[:catalogs_participant][:upload_file3]
    upload_file = params[:catalogs_participant_upload_file3_tag]
    @catalogs_participant.upload_file(upload_file, @catalogs_participant.upload_file3_s(filename)) if upload_file


    respond_to do |format|
      if @catalogs_participant.update(catalogs_participant_params)
        filename = "public/pdf/#{@catalogs_participant.pdf_reg_filename}"
        PdfGenerator.registration(@catalogs_participant, filename)
        format.html { redirect_to @catalogs_participant, notice: t('notices.updated_successfully')}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @catalogs_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload_files(catalogs_participant)
    #upload upload_file1
    filename =  params[:catalogs_participant][:upload_file1]
    upload_file = params[:catalogs_participant_upload_file1_tag]
    catalogs_participant.upload_file(upload_file, catalogs_participant.upload_file1_s(filename)) if upload_file

    #upload upload_file2
    filename =  params[:catalogs_participant][:upload_file2]
    upload_file = params[:catalogs_participant_upload_file2_tag]
    catalogs_participant.upload_file(upload_file, catalogs_participant.upload_file2_s(filename)) if upload_file

    #upload upload_file3
    filename =  params[:catalogs_participant][:upload_file3]
    upload_file = params[:catalogs_participant_upload_file3_tag]
    @catalogs_participant.upload_file(upload_file, @catalogs_participant.upload_file3_s(filename)) if upload_file
  end


  def confirm_participant
    @catalogs_participant.update_attribute(:confirmed, !@catalogs_participant.confirmed)
  end

  # DELETE /catalogs/participants/1
  # DELETE /catalogs/participants/1.json
  def destroy_participant
    @catalogs_participant.destroy
  end

  def delete

  end

  def download_pdf
    file = "public/pdf/#{params[:filename]}"
    name = params[:name]
    type = params[:filename].sub(/^.*\./,'')
    send_file  file, filename: name, type: "application/#{type}"
    #"#{Rails.root}/#{file}",
  end

  def download_attachment
    file = "public/attachments/participants/#{params[:filename]}"
    name = params[:name]
    type = params[:filename].sub(/^.*\./,'')
    send_file  file, filename: name, type: "application/#{type}"
    #"#{Rails.root}/#{file}",
  end

  def download_xlsx_list
    participants = Catalogs::Participant.where(course_id: params[:course_id]).for_course(params[:course_id])
    course = Catalogs::Course.find(params[:course_id])
    XlsxGenerator.xlsx_participants(participants,course)
    file = "public/xlsx/participants.xlsx"
    send_file("#{Rails.root}/public/xlsx/participants.xlsx", filename: "Participants_#{Time.now().strftime('%Y%M%d%H%m')}.xlsx", type: "application/vnd.ms-excel")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogs_participant
      @catalogs_participant = Catalogs::Participant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white index through.
    def catalogs_participant_params
      params.require(:catalogs_participant).permit(:course_id, :name, :surnames, :mail, :phone_numbers, :workplace,
                                                   :bachelor_deg, :master_deg, :phd_deg, :invoice_required, :inv_name, :inv_rfc,
                                                   :inv_address, :inv_city, :inv_municipality, :inv_state_id, :inv_mail,
                                                   :opt_text, :str_op1, :opt_str1, :opt_str2, :opt_bol1, :opt_bol2,
                                                   :opt_sel, :confirmed, :price, :price_id, :upload_file1, :upload_file2,
                                                   :upload_file3)
    end

    # Authorize cancan
    def authorize_resource
      authorize! :manage, @catalogs_participant, :message => t('notices.not_authorized')
    end 

    def sort_column
      params[:sort] || 'name,surnames'
    end

    def sort_direction
      params[:direction] || 'asc'
    end
end
