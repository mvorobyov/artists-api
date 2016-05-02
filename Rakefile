require './db_init'
require 'net/http'
require 'json'

def fetch_and_process uri
  p ">> URL: #{uri}"
  response = Net::HTTP.get uri
  data = JSON.parse response, symbolize_names: true
rescue JSON::ParserError => e
  p '>> Wrong response format'
rescue => e
  p '>> Host is unreachable'
else
  results = data[:results]
  results.each do |result|
    yield result
  end if results.is_a?(Array)
end

def fetch_albums_for id
  p ">> Fetching albums for artist with itunes_id #{id}"
  artist = Artist.find_by itunes_id: id
rescue Mongoid::Errors::DocumentNotFound => e
  p ">> Artist with itunes_id #{id} not found"
else
  uri = URI 'https://itunes.apple.com/lookup'
  params = { id: id, entity: :album }
  # params[:limit] = 2
  uri.query = URI.encode_www_form params
  fetch_and_process uri do |result|
    name, url = result[:collectionName], result[:artworkUrl100]
    if name
      p ">>>>>> Album: #{result}"
      artist.albums << Album.new(name: name, artwork_url_100: url)
    end
  end
end

namespace :itunes do
  task :fetch_artist, [:name] do |t, args|
    p ">> Fetching artist #{args.name}"
    uri = URI 'https://itunes.apple.com/search'
    params = { term: args.name, entity: :musicArtist }
    # params[:limit] = 2
    uri.query = URI.encode_www_form params
    fetch_and_process uri do |result|
      p ">>>> Artist: #{result}"
      name, id = result[:artistName], result[:artistId]
      if name && id
        Artist.create name: name, itunes_id: id
        fetch_albums_for id
      end
    end
  end

  task :clean_db do
    Artist.delete_all
    Album.delete_all
  end
end
