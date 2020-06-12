class Clock < ApplicationRecord
    validates :city, uniqueness: { case_sensitive: false }
end
