
class Kuunnelma < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true

	has_many :tags, :through => :kuunnelmatags
	has_many :kuunnelmatags

	def self.all_tags
    	result = {}
    	self.select(:tag).uniq.each do |kuunnelma|
    		result[kuunnelma.tag] = 1
    	end
    	return result
    end
end
