module Siteleaf
  class Page < Content

    def create_endpoint
      "sites/#{self.site_id}/pages"
    end
    
  end
end