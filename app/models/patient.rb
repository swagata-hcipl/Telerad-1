class Patient < ActiveRecord::Base
	# belongs_to :user
	# has_many :studies

	has_many :studies
	has_many :users, through: :studies

end
