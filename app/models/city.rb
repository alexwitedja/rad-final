class City < ApplicationRecord
    belongs_to :timezone

    def self.search(term)
        where("lower(city) ILIKE ?", "%#{term.downcase}%")
    end
end
