class PhotographersController < ApplicationController
  before_action :authorize, :except => [:application, :application_sent, :apply]
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
    @lightboxes = Lightboxes.where(photographer_id: params[:id])
  end

  # GET /photographers/new
  def new
    set_countries
    @photographer = Photographer.new
  end

  # GET /photographers/application
  def application
    set_countries
    @photographer = Photographer.new
    @application = true
  end

  # GET /photographers/application_sent
  def application_sent
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

  # POST /apply
  def apply
    set_countries
    params[:photographer].merge!(:state=>'pending')
    @photographer = Photographer.new(photographer_params)

    respond_to do |format|
      if @photographer.save
        lightboxes=0
        for i in 1..5 do
          lightboxes += 1 if create_lightbox i, @photographer.id
        end
        format.html { redirect_to '/application_sent' }
      else
        format.html { render action: 'application' }
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

    def lightbox_params
      params.require(:lightbox_title_1,:lightbox_number_1,:lightbox_image_1).permit(:lightbox_title_2,:lightbox_number_2,:lightbox_image_2,:lightbox_title_3,:lightbox_number_3,:lightbox_image_3,:lightbox_title_4,:lightbox_number_4,:lightbox_image_4,:lightbox_title_5,:lightbox_number_5,:lightbox_image_5)
    end
    
    def set_countries
      @countries=["England","Northern Ireland","Scotland","Wales","Eire"]
    end

    def set_states
      @photographer_states=["active","pending","deleted","rejected"]
    end

    def create_lightbox(lb_number, photographer_id)
      lb_index=lb_number.to_s
      title=params["lightbox_title_"+lb_index].strip
      lb_id=params["lightbox_number_"+lb_index].strip
      lb_image=params["lightbox_image_"+lb_index].strip
      if title.length>0 && /^[0-9]+$/.match(lb_id) && /^[0-9]+$/.match(lb_image)
        lb=Lightbox.new(:photographer_id => photographer_id, :istockid => lb_id, :name => title, :exampleimage => lb_image)
        lb.save
        return 1
      end
      return 0
    end
end
