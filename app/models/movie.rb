class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks
  before_destroy :check_for_bookmarks

  validates :title, :overview, presence: true
  validates :title, uniqueness: true

  private

  def check_for_bookmarks
    if bookmarks.positive?
      errors.add_to_base('cannot delete movie while bookmarks exist')
      false
    end
  end
end
