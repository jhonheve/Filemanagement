class FileVersionsController < ApplicationController
  before_action :set_file_version, only: [:show, :update, :destroy]

  # GET /file_versions
  # GET /file_versions.json
  def index
    @file_versions = FileVersion.all

    render json: @file_versions
  end

  # GET /file_versions/1
  # GET /file_versions/1.json
  def show
    @file_versions =  FileVersion.find(params[:versioned_file_id])
    #@file_versions =  FileVersion.find(:versioned_file_id => params[:versioned_file_id])
    render json: @file_versions
  end

  # POST /file_versions
  # POST /file_versions.json
  def create
    path = save_file
    if path
      if update_versioned_files?
         @file_version = FileVersion.new(:path =>path, :versioned_file_id => params[:versioned_file_id], :isActive => true )
         if @file_version.save
            render json: @file_version, status: :created, location: @file_version
         else
           render json: @file_version.errors, status: :unprocessable_entity
         end
      else
        render json: @file_version.errors, status: :unprocessable_entity
      end      
    end
    
  end

  # PATCH/PUT /file_versions/1
  # PATCH/PUT /file_versions/1.json
  def update
    if update_versioned_files?
       @file_version = FileVersion.find(params[:id])
       if @file_version.update(:isActive => true)
         head :no_content
       else
         render json: @file_version.errors, status: :unprocessable_entity
       end  
    else 
      render json: @file_version.errors, status: :unprocessable_entity
    end
  end

  # DELETE /file_versions/1
  # DELETE /file_versions/1.json
  def destroy
    @file_version.destroy

    head :no_content
  end

  private

    def set_file_version
      @file_version = FileVersion.find(params[:id])
    end

    def update_versioned_files?
      @file_versions = FileVersion.find(params[:versioned_file_id])
      @file_versions.update( :isActive => false) ? true : false
    end

    def save_file
      begin
        if params[:file]
          @versioned_file = VersionedFile.find(params[:versioned_file_id])
          if(params[:file].content_type == @versioned_file.content_type)
              id = time.now.to_i.to_s
              file = params[:file].read
              name = file.original_filename
              ext = File.extname(name)
              filename = id + ext
              File.open(Rails.root.join('public', 'filemanagement', @versioned_file.id.to_s, filename), 'wb') do |file|
                file.write(file)
              end
              return filename
          end  
        end
        return false
      rescue
         false
      end
    end
end
