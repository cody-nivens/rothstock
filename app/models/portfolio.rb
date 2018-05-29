class Portfolio < ApplicationRecord
  belongs_to :user
  validates_presence_of :name

  has_many :holdings
end
