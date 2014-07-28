class Catalogs::CoursesController < ApplicationController

  before_action :set_catalogs_course, only: [:show, :edit, :update, :destroy, :change_owner, :update_owner]
  helper_method :sort_column, :sort_direction

  layout 'events_courses', only: [:preview]
  
  # GET /catalogs/courses
  # GET /catalogs/courses.json
  def index
    @catalogs_courses = Catalogs::Course.search(params[:search]).order("#{sort_column} #{sort_direction}").paginate(per_page: 15, page:  params[:page])
  end

  # GET /catalogs/courses/1
  # GET /catalogs/courses/1.json
  def show
  end

  # GET /catalogs/courses/new
  def new
    @catalogs_course = Catalogs::Course.new
  end

  # GET /catalogs/courses/1/edit
  def edit
    authorize! :update, @catalogs_course, :message => "Not authorized to enter this section."
  end

  # POST /catalogs/courses
  # POST /catalogs/courses.json
  def create
    @catalogs_course = Catalogs::Course.new(catalogs_course_params)

    if @catalogs_course.save
       flash[:notice] = t('notices.saved_successfully')
       render :js => "window.location = '#{edit_catalogs_course_path(@catalogs_course)}'"
    else
       @errors = @catalogs_course.errors
    end
  end

  # PATCH/PUT /catalogs/courses/1
  # PATCH/PUT /catalogs/courses/1.json
  def update
    @catalogs_course = Catalogs::Course.find(params[:id])
    authorize! :update, @catalogs_course, :message => "Not authorized to enter this section."

    #upload content_file
    filename =  params[:catalogs_course][:content_file]
    content_file = params[:catalogs_course_content_file_tag]
    @catalogs_course.upload_file(content_file, @catalogs_course.content_file_s(filename)) if content_file

    #upload image file 1
    filename =  params[:catalogs_course][:image_file1]
    image_file = params[:catalogs_course_image_file1_tag]
    @catalogs_course.upload_file(image_file, @catalogs_course.image_file1_s(filename)) if image_file

    #upload image file 2
    filename =  params[:catalogs_course][:image_file2]
    image_file = params[:catalogs_course_image_file2_tag]
    @catalogs_course.upload_file(image_file, @catalogs_course.image_file2_s(filename)) if image_file

    #upload image file 3
    filename =  params[:catalogs_course][:image_file3]
    image_file = params[:catalogs_course_image_file3_tag]
    @catalogs_course.upload_file(image_file, @catalogs_course.image_file3_s(filename)) if image_file

    respond_to do |format|
      if @catalogs_course.update(catalogs_course_params)
        format.html { redirect_to @catalogs_course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @catalogs_course.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_owner

  end

  def update_owner
    if @catalogs_course.update_attributes(user_id: catalogs_course_params[:user_id])
      index
    else
      @errors = @catalogs_course.errors
    end
  end

  # DELETE /catalogs/courses/1
  # DELETE /catalogs/courses/1.json
  def destroy
    @catalogs_course.destroy
    respond_to do |format|
      format.html { redirect_to catalogs_courses_url }
      format.json { head :no_content }
    end
  end


  def preview
    @cc= Catalogs::Course.find(params[:id])
    image_1 = "/attachments/#{@cc.image_file1_s}" unless @cc.image_file1.empty?
    image_2 = "/attachments/#{@cc.image_file2_s}" unless @cc.image_file2.empty?
    image_3 = "/attachments/#{@cc.image_file3_s}" unless @cc.image_file3.empty?
    @carousel = [image_1, image_2, image_3].compact
  end

  def download_file
    file = "public/attachments/#{params[:filename]}"
    name = params[:name]
    type = params[:filename].sub(/^.*\./,'')
    send_file  file, filename: name, type: "application/#{type}"
    #"#{Rails.root}/#{file}",
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogs_course
      @catalogs_course = Catalogs::Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white index through.
    def catalogs_course_params
      params.require(:catalogs_course).permit(:user_id, :name, :start_date, :description, :schedule, :location,
                                              :content_file, :price1, :price2, :price3, :price1_desc, :price2_desc, :price3_desc,
                                              :opt_text, :opt_str1,
                                              :opt_str2, :opt_bol1, :opt_bol2, :opt_sel, :opt_sel_options, :payment_methods, :target,
                                              :prerequisites, :min_quota, :max_quota, :instructors, :contact,
                                              :image_file1, :image_file2, :image_file3, :start_date_pub,
                                              :end_date_pub, :start_date_reg, :end_date_reg, :mail_notif_deposit,
                                              :academic_data_required, :info_after_reg, :color_theme1,
                                              :color_theme2, :color_theme3, :opt_field, :opt_field_title)
    end

    def sort_column
      params[:sort] || 'created_at'
    end

    def sort_direction
      params[:direction] || 'asc' 
    end

end
