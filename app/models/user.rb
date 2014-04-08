class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  include RoleModel
  roles_attribute :roles_mask
  roles :admin, :officer, :crew_chief, :driver, :attendant
  
  has_paper_trail
end
