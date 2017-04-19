require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    location_to_go_in_url = @street_address.gsub(" ","+")
    url_without_street_address = "http://maps.googleapis.com/maps/api/geocode/json?address="
    url_with_address = url_without_street_address + location_to_go_in_url
    parsed_data = JSON.parse(open(url_with_address).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    render("geocoding/street_to_coords.html.erb")
  end
end
