class PhotosController < ApplicationController

   # Homepage
   def index
      @list_of_all_my_photos = Photo.all

      render("photos/index.html.erb")
   end


   # Add Photo Form
   def new_form
      render("photos/new_form.html.erb")
   end
   # Add Photo Behind the Scenes Code
   def create_row
      #Parameters > :img_url = "www.etc.com", :img_caption = "Text"
      url = params[:img_url]
      caption = params[:img_caption]
      new_photo = Photo.new
      new_photo.source = url
      new_photo.caption = caption
      new_photo.save
      redirect_to("/photos")
   end


   # Show Photo Details
   def show
      #Parameters > :id = "4300"
      @id = params[:id]
      i = Photo.find(@id)
      @photo_source = i.source
      @caption = i.caption
      @updated_at = i.updated_at
      time = Time.new
      seconds_since_upload = time-i.updated_at
      minutes_since_upload = seconds_since_upload/60
      hours_since_upload = minutes_since_upload/60
      days_since_upload = hours_since_upload/24

      if days_since_upload.round(0) < 1
         if hours_since_upload.round(0) < 1
            if minutes_since_upload.round(0) == 1
               @time_since_upload = minutes_since_upload
               @time_type = "minute"
            elsif minutes_since_upload.round(0) < 1
               @time_since_upload = "Less than a"
               @time_type = "minute"
            else
               @time_since_upload = minutes_since_upload.round(0)
               @time_type = "minutes"
            end

         elsif hours_since_upload.round(0) == 1
            @time_since_upload = hours_since_upload.round(0)
            @time_type = "hour"
         elsif hours_since_upload.round(0) > 1
            @time_since_upload = hours_since_upload.round(0)
            @time_type = "hours"
         end

      elsif days_since_upload.round(0) == 1
         @time_since_upload = days_since_upload.round(0)
         @time_type = "day"
      else
         @time_since_upload = days_since_upload.round(0)
         @time_type = "days"
      end

      render("photos/show.html.erb")
   end


   # Edit Photo Form
   def edit_form
      #Parameters > :id = "4300"
      @id = params[:id]
      @img = Photo.find(@id)

      render("photos/edit_form.html.erb")
   end
   # Edit Photo Behind the Scenes
   def update_row
      #Parameters > :id = "4300", :img_url = "www.etc.com", :img_caption = "Text"
      @id = params[:id]
      url = params[:img_url]
      caption = params[:img_caption]
      update_photo = Photo.find(@id)
      update_photo.source = url
      update_photo.caption = caption
      update_photo.save
      redirect_to("/photos/#{@id}")
   end

   def destroy_row
      #Parameters > :id = "4300"
      @id = params[:id]
      a = Photo.find(@id)
      a.destroy

      redirect_to("/photos")
   end

end
