require 'rubygems'
require 'time'
require 'hpricot'

module Hurricane

	class Parse
		def self.from(file)
			blog = Blog.new	
			doc = Hpricot::XML(file)
			(doc/:channel).each do |info|
				blog.title = (info/:title)[0].inner_html
				blog.description = (info/:description).inner_html
				blog.link = (info/:link)[0].inner_html
				blog.created_at = Time.rfc2822((info/'pubDate')[0].inner_html)
	
				(info/'wp:category'/'wp:category_nicename').each do |category|
					blog.categories << category.inner_html
				end
	
				(info/:item).each do |item|
					post = Post.new
					post.title = (item/:title).inner_html
					post.link = (item/:link).inner_html
					post.created_at = (item/'pubDate').inner_html
					post.description = (item/'content:encoded').inner_html.gsub('<![CDATA[', '').gsub(']]>', '')
					blog.posts << post
				end
	
			end
			blog
		end
	end
	
	class Blog
		def initialize
			@categories = Array.new
			@posts = Array.new
		end
		attr_accessor :title, :link, :description, :created_at, :categories, :posts
	end
	
	class Post
		attr_accessor :title, :link, :created_at, :description
	end
	
end