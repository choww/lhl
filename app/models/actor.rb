class Actor < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :movies, through: :roles

  accepts_nested_attributes_for :roles, allow_destroy: true
end
