class ClientController < ApplicationController
  def index
    @photographers = Photographer.order(:name)
  end
  
  def show
    set_photographer
    set_lightboxes
  end
 
  def location
    @photographers = Photographer.order(:city)
    @hash = Gmaps4rails.build_markers(@photographers) do |phtg, marker|
      marker.lat phtg.latitude
      marker.lng phtg.longitude
      marker.infowindow "<h3 class='infobox'><a href='/BritStock/photog/"+phtg.id.to_s+"'>"+phtg.name+"</a></h3>"+phtg.description
    end
  end

  def istocklightbox
    require 'xmlrpc/client'
    # istockapikey is secret
    eval(File.open('/web/www.theasis.co.uk/BritishStock/britstock/istockapikey').read)
    sserver="api.istockphoto.com"
    path="/webservices/xmlrpc/"
    server = XMLRPC::Client.new3( :host=>sserver, :path=>path, :timeout=>10000)
    server.http_header_extra = {"accept-encoding" => "identity"}
    p={"apiKey"=>@apikey,"lightboxID"=>params[:lbid],"perPage"=>100}
    @images=[]
    result=server.call("istockphoto.lightbox.listContents",p)
    result.scan(/fileid="(\d+)"/).each{ |img| @images<<img[0] }
    @images=@images.sort_by{rand}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photographer
      @photographer = Photographer.find(params[:id])
      if !@photographer.image || @photographer.image.length<2 then
        @photographer.image='britstock-logo1.png'
      end
    end

    def set_lightboxes
      @lbs = Lightbox.where(photographer_id: params[:id])
    end

end
