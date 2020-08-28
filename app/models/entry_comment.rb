class EntryComment < ApplicationRecord
  belongs_to :user
  belongs_to :entry
  scope :sort_by_created, -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}

end
