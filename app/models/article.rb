class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }

  self.per_page = 5

  def self.average_text_length
    # average_text_length of collection of articles
    sum_length = where(nil).reduce(0) { |sum,article| sum += article.text_length }
    sum_length / where(nil).size
  end

  def text_length
    # length of the text of a single article
    text.nil? ? 0 : text.length
  end

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end
end
