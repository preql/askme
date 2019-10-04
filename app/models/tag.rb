class Tag < ApplicationRecord
  REGEXP = /#[[:word:]-]+/

  has_many :question_tags
  has_many :questions, through: :question_tags, source: :question

  validates :name, presence: true
  validates :name, uniqueness: true
end
