class Album
  include Mongoid::Document

  field :name, type: String
  field :artwork_url_100, type: String

  belongs_to :artist

  scope :named, ->(name){ where(name: name) }

  validates_presence_of :name
  validates_presence_of :artist
  validate :unique_album_for_artist

  def unique_album_for_artist
    errors.add :name, 'needs to be unique for artist' if artist && artist.albums.named(name).count > 0
  end
end