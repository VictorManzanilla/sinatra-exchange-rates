require "sinatra"
require "sinatra/reloader"
require "http"
require "dotenv/load"
require "json"



get("/") do
  currency_api_key = ENV.fetch("CURRENCY_API_KEY")

response = HTTP.get("https://api.exchangerate.host/list?access_key=#{currency_api_key}")

parsed_response = JSON.parse(response)

currency_hash = parsed_response.fetch("currencies")
@currencies_keys = currency_hash.keys


  erb(:homepage)
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch("CURRENCY_API_KEY")}")
  parsed_response = JSON.parse(response)

currency_hash = parsed_response.fetch("currencies")
@currencies_keys = currency_hash.keys
erb(:convert)
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")


  response = HTTP.get("https://api.exchangerate.host/convert?access_key=#{ENV.fetch("CURRENCY_API_KEY")}&from=#{@original_currency}&to=#{@destination_currency}&amount=1")
  parsed_response = JSON.parse(response)
  @currency_hash = parsed_response.fetch("result")
  


  


  erb(:result)
end
