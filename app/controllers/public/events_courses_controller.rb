class Public::EventsCoursesController < ApplicationController
  def index
     @courses = Catalogs::Course.all
  end

  def event_info
  end
end
