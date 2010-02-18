class Category < ActiveRecord::Base
  has_many :records, :dependent => :delete_all
  belongs_to :user
  validates_associated :user
  validates_presence_of :title, :message => "не може бути порожньою"
  validates_uniqueness_of :title, :scope => :user_id, :message => "уже існує"
  validates_format_of :color, :with => /\A[0-9A-Fa-f]{3,6}\z/, :message => "повинен бути у форматі Hex від 3 до 6 символів"
end
