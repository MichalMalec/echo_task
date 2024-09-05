class EndpointSerializer < ActiveModel::Serializer
  attributes :type, :id, :atributes

  def atributes
    {
      verb: object.verb,
      path: object.path,
      response: {
        code: object.code,
        headers: object.headers || {},
        body: object.body || ''
      }
    }
  end

  def type
    'endpoints'
  end
end
