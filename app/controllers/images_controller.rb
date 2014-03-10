class ImagesController < ApplicationController


  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /uploads
  # GET /uploads.json
  def index
    # TODO: filter on the imageable
    @images = Image.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @image = Image.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @image = Image.create(image_params)
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params[:image].permit(:uploaded_image)
  end


end
