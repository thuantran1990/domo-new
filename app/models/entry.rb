class Entry < ApplicationRecord
  belongs_to :user
  has_many :entry_comments, dependent: :destroy
  accepts_nested_attributes_for :entry_comments, allow_destroy: :true
  has_one_attached :image
  scope :sort_by_created, -> { order(created_at: :desc) }	
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,content_type: { in: %w[image/jpeg image/gif image/png],
								message: "must be a valid image format" },
								size:{ less_than: 5.megabytes,
								message: "should be less than 5MB" }
	def display_image
		image.variant(resize_to_limit: [500, 500])
	end
end
