require 'action_controller'
require 'grape-jsonapi-resources'
require './db_init'
require './artist_resource'
require './album_resource'

module Artists
  class API < Grape::API
    format :json
    formatter :json, Grape::Formatter::JSONAPIResources

    resources :artists do
      get do
        Artist.all
      end

      route_param :id do
        get do
          render Artist.find(params[:id]), include: ['albums']
        end

        get :albums do
          Artist.find(params[:id]).albums
        end
      end
    end

    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      error!({errors: [{detail: e.problem}]}, 404)
    end
  end
end
