class Board < ApplicationRecord
	has_many :teams, dependent: :destroy
	has_many :users, through: :teams
	has_many :notes
	validates :name, presence: true, length: {maximum: 20}
end
