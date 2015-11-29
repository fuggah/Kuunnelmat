class User < ActiveRecord::Base
#	attr_accessible :email, :firstname, :lastname, :password, :password_confirmation, :temp_password
	validates :email, :firstname, :lastname, :presence =>true
	
	validates_uniqueness_of :email
end
