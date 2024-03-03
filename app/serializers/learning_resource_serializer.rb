class LearningResourceSerializer
  include JSONAPI::Serializer

  attributes :video,
              :images,
              :country
end