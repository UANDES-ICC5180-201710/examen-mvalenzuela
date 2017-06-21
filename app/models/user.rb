class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :purchases
  has_many :games, through: :purchases

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, length: { minimum: 3,  maximum: 30 }, presence: true
  validates :last_name, length: { minimum: 3,  maximum: 30 }, presence: true

  def to_s
    if first_name and last_name
      return first_name + ' ' + last_name
    else
      return ''
    end
  end

end
