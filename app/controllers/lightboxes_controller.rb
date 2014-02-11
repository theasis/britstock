class LightboxesController < ApplicationController
  before_action :set_lightbox, only: [:show, :edit, :update, :destroy]

  # GET /lightboxes
  # GET /lightboxes.json
  def index
    @lightboxes = Lightbox.find(:all, :order => "photographer_id")
    @photographers = Photographer.all
  end

  # GET /lightboxes/1
  # GET /lightboxes/1.json
  def show
    @photographers = Photographer.all
  end

  # GET /lightboxes/new
  def new
    @lightbox = Lightbox.new
    @photographers = Photographer.all
  end

  # GET /lightboxes/1/edit
  def edit
  end

  # POST /lightboxes
  # POST /lightboxes.json
  def create
    @lightbox = Lightbox.new(lightbox_params)

    respond_to do |format|
      if @lightbox.save
        format.html { redirect_to @lightbox, notice: 'Lightbox was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lightbox }
      else
        format.html { render action: 'new' }
        format.json { render json: @lightbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lightboxes/1
  # PATCH/PUT /lightboxes/1.json
  def update
    respond_to do |format|
      if @lightbox.update(lightbox_params)
        format.html { redirect_to @lightbox, notice: 'Lightbox was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lightbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lightboxes/1
  # DELETE /lightboxes/1.json
  def destroy
    @lightbox.destroy
    respond_to do |format|
      format.html { redirect_to lightboxes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lightbox
      @lightbox = Lightbox.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lightbox_params
      params.require(:lightbox).permit(:name, :description, :photographer_id, :istockid, :exampleimage)
    end
end
