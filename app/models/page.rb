require 'byebug'
class Page < ActiveRecord::Base
  def access_token
    "CAAFCKzF75OsBAM2px6NvOPP31K4GkdjC4dUVnzDvoLVEVGo7gCeBOEZCc9dfRoTXHUZBnlIeTSCCdgSJZC1sIWoJIAQ27HbFpfwN1DdrBWlZBbingCBNnfentSQwe2JQZCmP4NsW1FgDN16S2GFXLAMRiqpPhgrWMEHyixTQbtjBjZA2o9jPSTZCrKn4ZBaGDQ0ZD"
  end

  before_save :fetch_faceboo_data

  def fetch_faceboo_data
    api = Koala::Facebook::API.new(access_token)
    page = api.get_object(page_id)
    self.name = page['name']
    self.picture  = api.get_object( page['cover']['cover_id'])['images'].detect{|i|i['height']==130 or i['width'] == 130}['source']
  end

  def feeds
    Rails.cache.fetch "page_feeds_#{id}" do
      api = Koala::Facebook::API.new(access_token)
      feeds = api.get_object("#{page_id}/feed?limit=10")
    end
  end
end
