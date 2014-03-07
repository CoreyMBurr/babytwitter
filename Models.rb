class User < ActiveRecord::Base
	has_many :user_addresses
	has_many :addresses, through: :user_addresses
	has_many :posts

	def full_name
		if fname && lname
			fname + " " + lname
		elsif fname
			fname
		elsif
			lname
		else
			""
		end
	end
end

class Address < ActiveRecord::Base
	has_many :user_addresses
	has_many :users, through: :user_addresses

end

class UserAddress < ActiveRecord::Base
	belongs_to :user
	belongs_to :address
end

class Post < ActiveRecord::Base
	belongs_to :user
end
