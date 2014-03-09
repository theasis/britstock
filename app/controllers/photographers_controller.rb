class PhotographersController < ApplicationController
  before_action :authorize
  before_action :set_photographer, only: [:show, :edit, :update, :destroy]


  # GET /photographers
  # GET /photographers.json
  def index
    set_countries
    @photographers = Photographer.all
  end

  # GET /photographers/1
  # GET /photographers/1.json
  def show
    set_countries
    set_states
  end

  # GET /photographers/new
  def new
    set_countries
    @photographer = Photographer.new
  end

  # GET /photographers/1/edit
  def edit
    set_countries
    set_states
  end

  # POST /photographers
  # POST /photographers.json
  def create
    set_countries
    @photographer = Photographer.new(photographer_params)

    respond_to do |format|
      if @photographer.save
        format.html { redirect_to @photographer, notice: 'Photographer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photographer }
      else
        format.html { render action: 'new' }
        format.json { render json: @photographer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photographers/1
  # PATCH/PUT /photographers/1.json
  def update
    set_countries
    set_states
    respond_to do |format|
      if @photographer.update(photographer_params)
        format.html { redirect_to @photographer, notice: 'Photographer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photographer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photographers/1
  # DELETE /photographers/1.json
  def destroy
#    Lightbox.where(photographer_id: @photographer.id).delete_all
    @photographer.state='deleted'
    @photographer.save
    respond_to do |format|
      format.html { redirect_to photographers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photographer
      @photographer = Photographer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photographer_params
      params.require(:photographer).permit(:name, :description, :website, :phone, :email, :istock_name, :istock_userid, :password, :city, :country, :locationspecifier, :avatar, :state)
    end
    
    def set_countries
      @countries=["England","Northern Ireland","Scotland","Wales","Eire"]
    end

    def set_states
      @photographer_states=["active","pending","deleted","rejected"]
    end
end
