class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
  validate :clickbait?

  CLICKBAIT_TERMS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d+/i,
    /Guess/i
  ]

  def clickbait?
    if CLICKBAIT_TERMS.none? { |ter| ter.match title }
      errors.add(:title, "This HAS to be clickbait!")
    end
  end
end