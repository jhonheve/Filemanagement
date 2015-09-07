class VersionedFilesController < ApplicationController
  before_action :set_versioned_file, only: [:show, :update, :destroy]

  # GET /versioned_files
  # GET /versioned_files.json
  def index
    @versioned_files = VersionedFile.all

    render json: @versioned_files
  end

  # GET /versioned_files/1
  # GET /versioned_files/1.json
  def show
    render json: @versioned_file
  end

  # POST /versioned_files
  # POST /versioned_files.json
  def create
    @versioned_file = VersionedFile.new(versioned_file_params)

    if @versioned_file.save
      render json: @versioned_file, status: :created, location: @versioned_file
    else
      render json: @versioned_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /versioned_files/1
  # PATCH/PUT /versioned_files/1.json
  def update    
    @versioned_file = VersionedFile.find(params[:id])
    puts @versioned_file.id
    if @versioned_file.update(versioned_file_params)
      head :no_content
    else
      render json: @versioned_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /versioned_files/1
  # DELETE /versioned_files/1.json
  def destroy    
    @versioned_file.destroy
    head :no_content
  end

  private

    def set_versioned_file
      @versioned_file = VersionedFile.find(params[:id])
    end

    def versioned_file_params
      params.require(:versioned_file).permit(:name, :description, :content_type)
    end
end
