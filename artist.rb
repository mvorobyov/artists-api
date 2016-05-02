class Artist
  include Mongoid::Document

  field :name, type: String
  field :itunes_id, type: String

  has_many :albums, autosave: true

  validates_presence_of :name
  validates_presence_of :itunes_id
  validates_uniqueness_of :itunes_id
end