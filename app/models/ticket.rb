class Ticket < ActiveRecord::Base
  validates :event, :description, presence: true
  belongs_to :user
end
