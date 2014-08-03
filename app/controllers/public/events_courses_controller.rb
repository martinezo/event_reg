class Public::EventsCoursesController < ApplicationController
  skip_before_filter :authenticate_devise_user!
  layout 'events_courses', only: [:event_info, :new_participant, :registration_done, :create_participant ]

  require 'pdf_generator'

  def index
     @courses = Catalogs::Course.publishable.order(:start_date)
  end

  def event_info
    @cc= Catalogs::Course.find(params[:id])
    if (@cc.start_date_pub..@cc.end_date_pub).cover? Time.now
      image_1 = "/attachments/#{@cc.image_file1_s}" unless @cc.image_file1.empty?
      image_2 = "/attachments/#{@cc.image_file2_s}" unless @cc.image_file2.empty?
      image_3 = "/attachments/#{@cc.image_file3_s}" unless @cc.image_file3.empty?
      @carousel = [image_1, image_2, image_3].compact
    else
      flash[:alert] = t('notices.event_info_unavailable')
      puts flash[:alert]
    end
  end

  def new_participant
    course = Catalogs::Course.find(params[:course_id])
    if course.registrable
      @catalogs_participant = Catalogs::Participant.new
      @catalogs_participant.course_id = course.id
      @color_theme1 = "##{@catalogs_participant.course.color_theme1}"
      @color_theme2 = "##{@catalogs_participant.course.color_theme2}"
      @color_theme3 = "##{@catalogs_participant.course.color_theme3}"
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
        # registration @catalogs_participant, "public/pdf/#{@catalogs_participant.pdf_reg_filename}"
        filename = "public/pdf/#{@catalogs_participant.pdf_reg_filename}"
        PdfGenerator.registration(@catalogs_participant, filename)
        RegistrationMailer.participant_reg(@catalogs_participant, filename).deliver unless @catalogs_participant.mail.strip.empty?
        send_to_admin = !(@catalogs_participant.course.price1_desc+@catalogs_participant.course.price2_desc+@catalogs_participant.course.price3_desc).strip.empty? &&
                        !@catalogs_participant.course.mail_notif_deposit.strip.empty?
        RegistrationMailer.participant_reg_notification(@catalogs_participant, filename).deliver if send_to_admin
        format.html { redirect_to public_registration_done_path, flash: {participant_id: @catalogs_participant.id}}
        format.json { render action: 'registration_done', status: :created, location: @catalogs_participant }
      else
        @color_theme1 = "##{@catalogs_participant.course.color_theme1}"
        @color_theme2 = "##{@catalogs_participant.course.color_theme2}"
        @color_theme3 = "##{@catalogs_participant.course.color_theme3}"
        format.html { render action: :new_participant}
        # format.html { redirect_to public_registration_path(course_id: @catalogs_participant.course_id)}
        format.json { render json: @catalogs_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def registration_done
    @catalogs_participant = Catalogs::Participant.find(flash[:participant_id].to_i)
  end

  def download_file
    file = "public/pdf/#{params[:filename]}"
    name = params[:name]
    type = params[:filename].sub(/^.*\./,'')
    send_file  file, filename: name, type: "application/#{type}"
    #"#{Rails.root}/#{file}",
  end

end
