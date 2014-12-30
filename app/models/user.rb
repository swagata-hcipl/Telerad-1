class User < ActiveRecord::Base
	has_many :patients
end
