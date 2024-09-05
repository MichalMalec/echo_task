class Endpoint < ApplicationRecord
  HTTP_VERBS = %w[GET POST PUT PATCH DELETE].freeze

  validates :verb, presence: true, inclusion: { in: HTTP_VERBS, message: "%{value} is not a valid HTTP verb" }
  validates :path, presence: true
  validates :code, presence: true
end
