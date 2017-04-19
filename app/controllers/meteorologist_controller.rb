require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    location_to_go_in_url_final = @street_address.gsub(" ","+")
    url_without_street_address_final = "http://maps.googleapis.com/maps/api/geocode/json?address="
    url_with_address_final = url_without_street_address_final + location_to_go_in_url_final
    parsed_data_final = JSON.parse(open(url_with_address_final).read)

    latitude_final = parsed_data_final["results"][0]["geometry"]["location"]["lat"]

    latitude_final_text = latitude_final.to_s

    longitude_final = parsed_data_final["results"][0]["geometry"]["location"]["lng"]

    longitude_final_text = longitude_final.to_s

    url_without_location_final = "https://api.darksky.net/forecast/44d1deb1806ffde94d484f376278ab17/"

    url_with_location_final = url_without_location_final + latitude_final_text + "," + longitude_final_text

    parsed_data_final_location = JSON.parse(open(url_with_location_final).read)



    @current_temperature = parsed_data_final_location["currently"]["temperature"]

    @current_summary = parsed_data_final_location["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_final_location["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_final_location["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_final_location["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
