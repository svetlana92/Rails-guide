class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { minimum: 5 }
  validates :tags,
            presence: true,
            length: { maximum: 5, message: 'must be less than 5' }

  def self.average_text_length
    # average_text_length of collection of articles
    sum_length = where(nil).reduce(0) { |a,e| a += e.text_length }
    sum_length / where(nil).count
  end

  def text_length
    # length of the text of a single article
    text.nil? ? 0 : text.length
  end

  def self.search(search)
    if search
      where('title LIKE ? OR author LIKE ?', "%#{search}%", "%#{search}%")
    else
      where(nil)
    end
  end
end
