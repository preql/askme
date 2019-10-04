class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  after_save :build_tags

  private

  def build_tags
    self.tags.clear
    hashtags = (text + ' ' + answer.to_s).scan(Tag::REGEXP).uniq

    hashtags.each do |tag|
      self.tags << Tag.find_or_create_by(name: tag.downcase)
    end
  end
end
