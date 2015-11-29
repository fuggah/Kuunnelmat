
class Kuunnelma < ActiveRecord::Base
	attr_accessible :name, :artist, :year
	validates_uniqueness_of :name
end
