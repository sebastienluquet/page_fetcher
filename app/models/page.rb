class Page < ActiveRecord::Base
  def access_token
    "CAAFCKzF75OsBAM2px6NvOPP31K4GkdjC4dUVnzDvoLVEVGo7gCeBOEZCc9dfRoTXHUZBnlIeTSCCdgSJZC1sIWoJIAQ27HbFpfwN1DdrBWlZBbingCBNnfentSQwe2JQZCmP4NsW1FgDN16S2GFXLAMRiqpPhgrWMEHyixTQbtjBjZA2o9jPSTZCrKn4ZBaGDQ0ZD"
  end

  before_create :fetch_facebook_data

  def fetch_facebook_data
    api = Koala::Facebook::API.new(access_token)
    begin
      page = api.get_object(page_id)
      self.name = page['name']
      if page['cover']
        cover = api.get_object( page['cover']['cover_id'])
        thumbnail = ['images'].detect{|i|i['height']==130 or i['width'] == 130}
        if thumbnail
          self.picture  = thumbnail['source']
        end
      end
    rescue Koala::Facebook::ClientError => e
      errors.add(:page_id, :invalid)
    end
  end

  def feeds
    Rails.cache.fetch "page_feeds_#{id}" do
      api = Koala::Facebook::API.new(access_token)
      feeds = api.get_object("#{page_id}/feed?limit=10")
    end
  end
end
