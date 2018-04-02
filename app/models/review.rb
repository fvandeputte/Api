class Review < ApplicationRecord
    validates :author, presence: true
    validates :comment, presence: true
    belongs_to :article
end
