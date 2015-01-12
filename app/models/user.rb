class User < ActiveRecord::Base
  # has_many :patients
  # has_many :studies, through: :patients

  has_many :studies
  has_many :patients, through: :studies
  
  validates :name, :presence => true, :length => { :in => 6..100 }
  validates :gateway, :presence => true, :uniqueness => true, :length => { :in => 2..20 }
  validates :gateway_type, :presence => true, :length => { :in => 3..20 }
  validates :password, :confirmation => true #password_confirmation attr
  has_secure_password
  validates_length_of :password, :in => 6..20, :on => :create 
end
