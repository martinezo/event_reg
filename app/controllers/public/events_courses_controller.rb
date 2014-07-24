class Public::EventsCoursesController < ApplicationController
  skip_before_filter :authenticate_devise_user!
  layout 'events_courses', only: [:event_info]

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
      flash[:alert] = t('notices.event_info_unavalable')
      puts flash[:alert]
    end
  end
end
