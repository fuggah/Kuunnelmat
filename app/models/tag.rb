class Tag < ActiveRecord::Base

	has_many :kuunnelmatags
	has_many :kuunnelmas, :through => :kuunnelmatags

end
