class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :name, uniqueness: true


  has_many :subscriptions, dependent: :destroy


  def subscribed?

  stripe_id?


 end


 def self.subs_count
        User.where.not(stripe_id: nil).count
      end



end
