# README

# run app
`bin/rails s`

# run tests
`rspec`

# cURLs for testing purposes

* GET /endpoints
`curl -X GET http://localhost:3000/endpoints`

* POST /endpoints
```
curl -X POST http://localhost:3000/endpoints \
  -H "Content-Type: application/json" \
  -d '{
        "data": {
          "type": "endpoints",
          "attributes": {
            "verb": "GET",
            "path": "/greeting",
            "response": {
              "code": 200,
              "headers": {},
              "body": "{\"message\": \"Hello, world\"}"
            }
          }
        }
      }'
```

* PATCH /endpoints/:id
```
curl -X PATCH http://localhost:3000/endpoints/1 \
  -H "Content-Type: application/json" \
  -d '{
        "data": {
          "type": "endpoints",
          "attributes": {
            "verb": "POST",
            "path": "/greeting",
            "response": {
              "code": 404,
              "headers": {},
              "body": "{\"message\": \"Updated response body\"}"
            }
          }
        }
      }'
```

* DELETE /endpoints/:id
`curl -X DELETE http://localhost:3000/endpoints/1`

* Client: (e.g.) POST /url
`curl -X POST http://localhost:3000/greeting`