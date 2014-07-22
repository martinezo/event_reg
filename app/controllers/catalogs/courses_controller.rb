class Catalogs::CoursesController < ApplicationController
  before_action :set_catalogs_course, only: [:show, :edit, :update, :destroy, :preview]
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

    #upload content_file
    content_file_name =  params[:catalogs_course][:content_file]
    content_file = params[:catalogs_course_content_file_tag]
    @catalogs_course.upload_file(content_file, "#{@catalogs_course.id.to_s}_program_file.#{content_file_name.sub(/^.*\./,'')}") if content_file

    #upload image file 1
    image_file1_name =  params[:catalogs_course][:image_file1]
    image_file1 = params[:catalogs_course_image_file1_tag]
    @catalogs_course.upload_file(image_file1, "#{@catalogs_course.id.to_s}_image_file1.#{image_file1_name.sub(/^.*\./,'')}") if image_file1

    #upload image file 2
    image_file2_name =  params[:catalogs_course][:image_file2]
    image_file2 = params[:catalogs_course_image_file2_tag]
    @catalogs_course.upload_file(image_file2, "#{@catalogs_course.id.to_s}_image_file2.#{image_file2_name.sub(/^.*\./,'')}") if image_file2

    #upload image file 3
    image_file3_name =  params[:catalogs_course][:image_file3]
    image_file3 = params[:catalogs_course_image_file3_tag]
    @catalogs_course.upload_file(image_file3, "#{@catalogs_course.id.to_s}_image_file3.#{image_file3_name.sub(/^.*\./,'')}") if image_file3

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

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogs_course
      @catalogs_course = Catalogs::Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalogs_course_params
      params.require(:catalogs_course).permit(:user_id, :name, :start_date, :description, :schedule, :location, :content_file, :price1, :price2, :price3, :payment_methods, :target, :prerequisites, :min_quota, :max_quota, :instructors, :contact, :image_file1, :image_file2, :image_file3, :start_date_pub, :end_date_pub, :start_date_reg, :end_date_reg, :mail_notif_deposit, :academic_data_required, :info_after_reg, :color_theme1, :color_theme2, :color_theme3, :opt_field, :opt_field_title)
    end

    def sort_column
      params[:sort] || 'created_at'
    end

    def sort_direction
      params[:direction] || 'asc' 
    end
 
end
