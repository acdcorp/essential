class User < ActiveRecord::Base
  include UserPermissions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :creator, class_name: 'User'
  belongs_to :updater, class_name: 'User'
  belongs_to :company
  belongs_to :role

  def full_name
    first_name + ' ' + last_name
  end
end
