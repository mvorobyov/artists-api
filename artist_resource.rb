class ArtistResource < JSONAPI::Resource
  attributes :name, :itunes_id

  has_many :albums
end