class Record < ActiveRecord::Base
  belongs_to :category
  validates_associated :category
  validates_presence_of :duration, :message => "не може бути пустою"
end
