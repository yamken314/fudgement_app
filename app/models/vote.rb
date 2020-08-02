class Vote < ApplicationRecord
  has_many :users
  belongs_to :choice
end
