FactoryBot.define do
    factory :endpoint do
      verb { 'GET' }
      path { '/example_path' }
      code { 200 }
      headers { {} }
      body { '{"message": "Hello World"}' }
    end
end
