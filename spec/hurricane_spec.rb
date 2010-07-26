require 'spec_helper'

describe 'Hurricane' do
	
	FILE = File.open('./wordpress_file.xml', 'r')
	@blog = Hurricane::Parse.from(FILE)

	it 'should be offer blog title' do
		@blog.title.should.equal 'Daniel Tamiosso'
	end
	
	it 'should be offer blog link' do
		@blog.link.should.equal 'http://danieltamiosso.com'
	end
	
	it 'should be offer blog description' do
		@blog.description.should.equal 'Only me'
	end
	
	it 'should be offer blog created date' do
		@blog.created_at.rfc2822.should.equal 'Wed, 15 Jul 2009 20:32:34 -0300'
	end
	
	it 'should be offer blog categories' do		
		@blog.categories.should.include? 'agil'
		@blog.categories.should.include? 'boas-praticas'
		@blog.categories.should.include? 'desenvolvimento'
		@blog.categories.should.include? 'design'
	end	
	
	it 'should be offer post list' do		
		@blog.posts.size.should.equal 2
	end	
	
	it 'should be get a post with title' do		
		@blog.posts.first.title.should.equal 'Ou uma coisa ou outra: Command and Query Separation'
	end	
	
	it 'should be get a post with link' do			
		@blog.posts.first.link.should.equal 'http://danieltamiosso.com/2009/07/09/ou-uma-coisa-ou-outra-command-and-query/'
	end
	
	it 'should be get a post with created date' do
		@blog.posts.first.created_at.should.equal 'Thu, 09 Jul 2009 16:50:14 +0000'
	end
	
	it 'should be get a post with description' do
		@blog.posts.first.description.should.equal 'Post text'
	end
		
end