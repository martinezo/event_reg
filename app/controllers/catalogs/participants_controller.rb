class Catalogs::ParticipantsController < ApplicationController
  before_action :set_catalogs_participant, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /catalogs/participants
  # GET /catalogs/participants.json
  def index
#    @catalogs_participants = Catalogs::Participant.of_course(params[:course_id]).order(:surnames)

    @catalogs_participants = Catalogs::Participant.search(params[:search]).order("#{sort_column} #{sort_direction}").paginate(per_page: 15, page:  params[:page])
  end

  # GET /catalogs/participants/1
  # GET /catalogs/participants/1.json
  def show
  end

  # GET /catalogs/participants/new
  def new
    @catalogs_participant = Catalogs::Participant.new
  end

  # GET /catalogs/participants/1/edit
  def edit
  end

  # POST /catalogs/participants
  # POST /catalogs/participants.json
  def create
    @catalogs_participant = Catalogs::Participant.new(catalogs_participant_params)

    respond_to do |format|
      if @catalogs_participant.save
        format.html { redirect_to @catalogs_participant, notice: 'Participant was successfully created.' }
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
    respond_to do |format|
      if @catalogs_participant.update(catalogs_participant_params)
        format.html { redirect_to @catalogs_participant, notice: 'Participant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @catalogs_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/participants/1
  # DELETE /catalogs/participants/1.json
  def destroy
    @catalogs_participant.destroy
    respond_to do |format|
      format.html { redirect_to catalogs_participants_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogs_participant
      @catalogs_participant = Catalogs::Participant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalogs_participant_params
      params.require(:catalogs_participant).permit(:course_id, :name, :surnames, :mail, :phone_numbers, :workplace, :bachelor_deg, :master_deg, :phd_deg, :inv_name, :inv_rfc, :inv_address, :inv_city, :inv_municipality, :inv_state, :inv_email, :opt_text, :str_op1, :opt_str1, :opt_str2, :opt_bol1, :opt_bol2, :opt_sel, :confirmed, :price)
    end

    def sort_column
      params[:sort] || 'created_at'
    end

    def sort_direction
      params[:direction] || 'asc'
    end
end
