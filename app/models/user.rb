class User < ActiveRecord::Base
	has_many :patients

  validates :name, :presence => true, :length => { :in => 6..100 }
  validates :gateway, :presence => true, :uniqueness => true, :length => { :in => 6..20 }
  validates :gateway, :presence => true
  validates :password, :confirmation => true #password_confirmation attr
  has_secure_password
  validates_length_of :password, :in => 6..20, :on => :create 
end
