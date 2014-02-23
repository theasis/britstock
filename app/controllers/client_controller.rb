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
    @photographers = Photographer.order(:locationspecifier)
    @cities = Photographer.select(:city).distinct
    @regions = Photographer.select(:locationspecifier).distinct
    markers = Marker.all
    marker_lookup = Hash[ markers.map{ |m| [m.label,{:lat => m.latitude, :lng => m.longitude}]}]
    @hash = Gmaps4rails.build_markers(@regions) do |region, marker|
      region_photographers=Photographer.where("locationspecifier='"+region.locationspecifier+"'")
      ml=marker_lookup[region_photographers[0].locationspecifier]
      if ml
        marker.lat ml[:lat]
        marker.lng ml[:lng]
      else
        marker.lat region_photographers[0].latitude
        marker.lng region_photographers[0].longitude
      end
      photographer_list="<ul class='infobox'>"
      region_photographers.each do |phtg|
        photographer_list+="<li><a href='/artist/"+phtg.istock_name+"'>"+phtg.name+" (<i>"+phtg.city+"</i>)</a></li>"
      end
      photographer_list+="</ul>"
      marker.infowindow "<h3 class='infobox'>#{region.locationspecifier}</a></h3>"+photographer_list
    end
  end

  def location2
    location
	@countries = Photographer.select(:country).distinct.order(:country)
	@per_country = {}
	@countries.each do |c|
	  @per_country[c.country] = Photographer.where(country: c.country).order(:locationspecifier)
	end
  end
  
  def istocklightbox
    oldcache=false
    cache = Cache.where(:lightbox_id => params[:lbid]).first
    if(cache)
      @totalitems=cache.filecount||0
      @images=cache.filelist
      oldcache = cache.updated_at < 1.day.ago
    end
    if (!cache || oldcache)
      require 'xmlrpc/client'
      # istockapikey is secret
      eval(File.open(Rails.root.join('istockapikey').to_s).read)
      sserver="api.istockphoto.com"
      path="/webservices/xmlrpc/"
      server = XMLRPC::Client.new3( :host=>sserver, :path=>path, :timeout=>10000)
      server.http_header_extra = {"accept-encoding" => "identity"}
      p={"apiKey"=>@apikey,"lightboxID"=>params[:lbid],"perPage"=>100}
      @images=[]
      result=server.call("istockphoto.lightbox.listContents",p)
      result.scan(/totalitems="(\d+)"/).each{ |t| @totalitems=t[0].to_i||0 }
      result.scan(/fileid="(\d+)"/).each{ |img| @images<<img[0] }
      cache = Cache.new unless cache
      cache.filecount=@totalitems
      cache.filelist=@images
      cache.lightbox_id=params[:lbid]
      cache.save
    end
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
