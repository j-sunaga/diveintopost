class Agenda < ApplicationRecord
  belongs_to :team
  belongs_to :user
  has_many :articles, dependent: :destroy

  scope :agenda_title, -> (search) { where("title LIKE ?", "%#{search}%")}

end
