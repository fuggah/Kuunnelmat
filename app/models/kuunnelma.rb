
class Kuunnelma < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
	
	has_many :tags, :through => :kuunnelmatags
	has_many :kuunnelmatags
end
