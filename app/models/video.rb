class Video < ApplicationRecord


  extend FriendlyId
    friendly_id :name, use: :slugged

    validates :name, presence: true
    validates :description, presence: true
    validates :video_source_id, presence: true
    validates :name, length: { minimum: 3 }
    validates :name, format: {
       with: /\A[^0-9 !@#\$%\^&*+_=]+\z/,
       message: "The name has invalid characters, please supply a different name."
    }
   belongs_to :project
end
