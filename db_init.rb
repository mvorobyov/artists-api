require 'mongoid'
require './artist'
require './album'

Mongoid.load! './mongoid.yml', :development
