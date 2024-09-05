class Endpoint < ApplicationRecord
  validates :verb, presence: true
  validates :path, presence: true
  validates :code, presence: true
  
  validates :verb, inclusion: { in: %w[GET POST PUT PATCH DELETE], message: "%{value} is not a valid HTTP verb" }
end
