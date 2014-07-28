class Public::EventsCoursesController < ApplicationController
  skip_before_filter :authenticate_devise_user!
  layout 'events_courses', only: [:event_info, :new_participant]

  load 'lib/pdf_generator.rb'

  def index
     @courses = Catalogs::Course.publishable.order(:start_date)
  end

  def event_info
    @cc= Catalogs::Course.find(params[:id])
    if (@cc.start_date_pub..@cc.end_date_pub).cover? Time.now
      image_1 = "/attachments/#{@cc.id}_image_file1.#{@cc.image_file1.sub(/^.*\./,'')}" unless @cc.image_file1.empty?
      image_2 = "/attachments/#{@cc.id}_image_file2.#{@cc.image_file2.sub(/^.*\./,'')}" unless @cc.image_file2.empty?
      image_3 = "/attachments/#{@cc.id}_image_file3.#{@cc.image_file3.sub(/^.*\./,'')}" unless @cc.image_file3.empty?
      @carousel = [image_1, image_2, image_3].compact
    else
      flash[:alert] = t('notices.event_info_unavailable')
      puts flash[:alert]
    end
  end

  def new_participant
    @cc = Catalogs::Course.find(params[:course_id])
    if @cc.registrable
      @catalogs_participant = Catalogs::Participant.new
    else
      flash[:alert] = t('notices.registration_unavailable')
      puts flash[:alert]
    end
  end

  def create_participant
  params.permit!
  @catalogs_participant = Catalogs::Participant.new(params[:catalogs_participant])
  respond_to do |format|
    if @catalogs_participant.save
      registration @catalogs_participant
      #PdfGenerator.registration @catalogs_participant
      format.html { redirect_to @catalogs_participant, notice: 'Participant was successfully created.' }
      format.json { render action: 'show', status: :created, location: @catalogs_participant }
    else
      format.html { render action: 'new' }
      format.json { render json: @catalogs_participant.errors, status: :unprocessable_entity }
    end
  end
  end

  require 'prawn'
  require 'prawn/table'
  require 'prawn/measurement_extensions'

  def registration(r)
    Prawn::Document.generate('registration.pdf', left_margin: 1.in) do
      stroke_axis
      image "public/pdf/assets/pdf_header.jpg"
      pad(20) { text r.course.name, align: :center, style: :bold, size: 14 }

      # TABLE FORMAT
      c_style = {height: (0.25).in, padding: 3, size: 10, border_color: r.course.color_theme1, valign: :middle}
      c_style_h = {background_color: r.course.color_theme3, align: :right, font_style: :bold_italic}
      c_style_d = {}
      alt_1, alt_2= r.course.color_theme_l(3,0.6), r.course.color_theme_l(3,0.65)

      # REGISTRATION DATE
      headers = [[I18n.t('pdf.reg_date')]]
      data = [[I18n.localize(r.created_at, :format => :long_only_date)]]
      col_1 = make_table headers, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]], position: :right

      move_down (0.12).in

      # GENERAL INFO
      pad(10) { text I18n.t('pdf.general_info'), style: :bold, size: 12 }

      headers = [[I18n.t('pdf.name')], [I18n.t('pdf.mail')], [I18n.t('pdf.phone_numbers')], [I18n.t('pdf.workplace')]]
      data = [[r.complete_name], [r.mail], [r.phone_numbers], [r.workplace]]
      col_1 = make_table headers, column_widths: 2.in, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1,alt_2], cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]]

    end

  end

end
