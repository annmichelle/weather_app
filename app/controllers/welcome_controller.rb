class WelcomeController < ApplicationController
  
  def index
    # checks that the state and city params are not empty before calling the API
    if params[:zipcode] != '' && !params[:zipcode].nil?
      response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=#{params[:zipcode]}&units=imperial&appid=#{ENV['4ba6d14f1424603ecac9da540cc08e5e']}")
      @status = response['cod']
      # if no error is returned from the call, we fill our instance variables with the result of the call
      if @status != '404' && response['message'] != 'city not found'
        @location = response['name']
        @temp = response['main']['temp']
        @weather_icon = response['weather'][0]['icon']
        @weather_words = response['weather'][0]['description']
        @cloudiness = response['clouds']['all']
        @windiness = response['wind']['speed']
      else
        # if there is an error, we report it to our user via the @error variable
        @error = response['message']
      end
    end
  end
 
  def test
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=75001&units=imperial&appid=#{ENV['4ba6d14f1424603ecac9da540cc08e5e']}")
  
    @results = {}
    @results[:location] = response['name']
    @results[:temp] = response['main'][0]['temp']
    @results[:weather_icon] = response['weather'][0]['icon']
    @results[:weather_words] = response['weather'][0]['description'] 
    @results[:windiness] = response['wind']['speed']
    @results[:cloudiness] = response['clouds']['all']
  end
end
