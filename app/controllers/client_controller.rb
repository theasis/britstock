class ClientController < ApplicationController
  skip_before_action :authorize
  def index
    @photographers = Photographer.order(:name)
  end
  
  def done
  end
  
  def show
    set_photographer
    set_lightboxes
  end
 
  def location
    @photographers = Photographer.order(:city)
    @cities = Photographer.select(:city).distinct
    @hash = Gmaps4rails.build_markers(@cities) do |city, marker|
      city_photographers=Photographer.where("city='"+city.city+"'")
      marker.lat city_photographers[0].latitude
      marker.lng city_photographers[0].longitude
      photographer_list="<ul class='infobox'>"
      city_photographers.each do |phtg|
        photographer_list+="<li><a href='/photog/"+phtg.istock_name+"'>"+phtg.name+" (<i>"+phtg.locationspecifier+"</i>)</a></li>"
      end
      photographer_list+="</ul>"
      marker.infowindow "<h3 class='infobox'>#{city.city}</a></h3>"+photographer_list
    end
  end

  def istocklightbox
    require 'xmlrpc/client'
    # istockapikey is secret
    eval(File.open('/web/www.focalhero.co.uk/britstock/istockapikey').read)
    sserver="api.istockphoto.com"
    path="/webservices/xmlrpc/"
    server = XMLRPC::Client.new3( :host=>sserver, :path=>path, :timeout=>10000)
    server.http_header_extra = {"accept-encoding" => "identity"}
    p={"apiKey"=>@apikey,"lightboxID"=>params[:lbid],"perPage"=>100}
    @images=[]
    result=server.call("istockphoto.lightbox.listContents",p)
    result.scan(/totalitems="(\d+)"/).each{ |t| @totalitems=t }
    result.scan(/fileid="(\d+)"/).each{ |img| @images<<img[0] }
    @images=@images.sort_by{rand}
    render :json => {images:@images,totalitems:@totalitems};
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photographer
      @photographer = Photographer.find_by(istock_name: params[:id])
      if !@photographer.image || @photographer.image.length<2 then
        @photographer.image='britstock-logo1.png'
      end
    end

    def set_lightboxes
      @lbs = Lightbox.where(photographer_id: @photographer.id)
    end

end
