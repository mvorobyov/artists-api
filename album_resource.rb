class AlbumResource < JSONAPI::Resource
  attributes :name, :artwork_url_100

  has_one :artist
end