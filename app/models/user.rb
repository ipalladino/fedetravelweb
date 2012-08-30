class User < ActiveRecord::Base
   attr_accessible :name, :address, :telephone, :email, :active, :created_at, :updated_at, :login_amount
end
