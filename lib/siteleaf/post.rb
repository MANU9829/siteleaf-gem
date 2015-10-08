module Siteleaf
  class Post < Page

    attr_accessor :taxonomy
    
    def create_endpoint
      "pages/#{self.parent_id}/posts"
    end
    
    def parent
      Page.find(self.parent_id)
    end
    
    def assets
      result = Client.get "posts/#{self.id}/assets"
      result.map { |r| Asset.new(r) } if result
    end
    
    def filename(posts_path = 'posts')
      paths = url.sub('/','').split('/')
      basename = "#{paths.pop}.markdown"
      path = paths.join('_')
      if path == posts_path 
        if draft?
          path = 'drafts'
        else
          path = 'posts'
          date = Time.parse(published_at).strftime('%Y-%m-%d')
          basename = "#{date}-#{basename}"
        end
      end
      "_#{path}/#{basename}"
    end
    
  end
end