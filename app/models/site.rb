class Site < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  VALID_NAME_REGEX = /\A^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$\z/ix
  validates :name, presence: true, length: { maximum: 140 }, format: { with: VALID_NAME_REGEX }, uniqueness: true
end
