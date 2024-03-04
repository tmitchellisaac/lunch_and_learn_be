class UserSerializer
  include JSONAPI::Serializer

  attributes  :email,
              :name,
              :api_key
end