class Player < ApplicationRecord
    has_many :rounds, dependent: :destroy
end
