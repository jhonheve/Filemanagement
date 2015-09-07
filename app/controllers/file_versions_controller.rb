require 'fileutils'
class FileVersionsController < ApplicationController
  before_action :set_file_version, only: [:update, :destroy]

  # GET /file_versions
  # GET /file_versions.json
  def index
    @file_versions = FileVersion.all

    render json: @file_versions
  end

  # GET /file_versions/1
  # GET /file_versions/1.json
  def show
    puts params[:id]
    @file_versions =  FileVersion.where(versioned_file_id: params[:id])    
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
        render json: @file_versions.errors, status: :unprocessable_entity
      end
    else 
      render json: { :message => "The file is not valid" }, :status => :precondition_failed
    end
    
  end

  # PATCH/PUT /file_versions/1
  # PATCH/PUT /file_versions/1.json
  def update
    @file_version = FileVersion.find(params[:id])
    params[:versioned_file_id] = @file_version.versioned_file_id
    if update_versioned_files?       
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
      puts params[:versioned_file_id]
      FileVersion.where(versioned_file_id: params[:versioned_file_id]).update_all(isActive: false)
    end

    def save_file
      begin
        if params[:file]
          @versioned_file = VersionedFile.find(params[:versioned_file_id])
          puts params[:file].content_type, "--------", @versioned_file.content_type , "---"
          if(params[:file].content_type == @versioned_file.content_type)
            
            id = Time.now.to_i.to_s
              puts "1111"
              file = params[:file].read
              puts "222"
              name = params[:file].original_filename
              puts "3233"
              ext = File.extname(name)
              puts "jhoN--------------3", name, "-----------", ext
              filename = id + ext
              path = Rails.root.join('public', "filemanagement" , @versioned_file.id.to_s)
              
              dirname = File.dirname(path)
              FileUtils::mkdir_p path
              bin = File.open(path + filename, "w")
              bin.close
              return filename
          end  
        end       
        return false
      rescue
        false
      end
    end
end
