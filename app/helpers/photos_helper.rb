module PhotosHelper
  def options_from_hash hash
    options = ""
    hash.each_pair do |key, val|
      options += "<option value='#{key}'>#{val}</option>"
    end
    options
  end

  def campaign_photos_path
    "/campaigns/#{@campaign.id}/photos"
  end
  
  def campaign_photo_path photo
    "#{campaign_photos_path}/#{photo.id}"
  end
  
  def edit_campaign_photo_path photo
    campaign_photo_path(photo) + '/edit'
  end

  def destroy_campaign_photo_path photo
    campaign_photo_path(photo) + '/destroy'
  end

  def campaign_photo_url photo
    campaign_photos_path + "/#{photo.id}"
  end

  def new_campaign_photo_path
    "#{campaign_photos_path}/new"
  end

  alias :photos_url :campaign_photos_path
  alias :photo_url :campaign_photo_url
  alias :photos_path :campaign_photos_path 
  alias :photo_path :campaign_photo_path
  alias :edit_photo_path :edit_campaign_photo_path
  alias :destroy_photo_path :destroy_campaign_photo_path
  alias :new_photo_path :new_campaign_photo_path
end
