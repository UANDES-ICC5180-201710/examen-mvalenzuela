class Game < ApplicationRecord

  has_many :purchases
  has_many :users, through: :purchases

  validates :title, length: { minimum: 10,  maximum: 50 }, presence: true, uniqueness: true
  validates :image_url, {presence:true}
  validates :description, length: { minimum: 30 }, presence:true
end
