require 'discordrb'
require 'json'
require 'uri'
require 'net/http'
require 'openssl'
require 'securerandom'

# discord API
bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD'], prefix: '#'

# shorten command
bot.command(:short, max_args: 1, description: 'Shortens a URL via kutt.it', usage: 'short [longurl]') do |_event, longurl|
  # shorturl = k.submit(longurl, customurl="", password="")
	# finaltext = 'Link shortened! ' + shorturl.to_s
  
  slashtag = SecureRandom.urlsafe_base64(3)
  
  if longurl.include? "http"
    longurl = longurl.to_s
  else
    longurl = "http://" + longurl
  end
  puts longurl
  
  url = URI("https://api.rebrandly.com/v1/links")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Post.new(url)
  request["content-type"] = 'application/json'
  request["apikey"] = ENV['REBRANDLY']
  request.body = "{\"domain\":{\"id\":\"b6adbb5fd4734614b9d51ca400b6af04\"},\"slashtag\":\"#{slashtag}\",\"destination\":\"#{longurl}\"}"

  response = http.request(request)
  puts response.read_body
  puts shorturl = JSON.parse(response.read_body)['shortUrl']
  
  finaltext = 'Link shortened! <https://' + shorturl.to_s + '> :white_check_mark:'
end

bot.command(:ping, description: 'Get your Ping to the Bot', usage: 'ping') do |event|
  # The `respond` method returns a `Message` object, which is stored in a variable `m`. The `edit` method is then called
  # to edit the message with the time difference between when the event was received and after the message was sent.
  m = event.respond('Pong!')
  m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
end

bot.command :help do |event|
  event << '**shortbot Help Menu** :fire_extinguisher:'
  event << 'Short a link:  `#short [url]`'
  event << 'Get your Ping to the Bot:  `#ping`'
  event << 'Get the current version:  `#version`'
  event << 'Access this Help Menu:  `#help`'
  event << '**Support the Development** :money_with_wings:'
  event << 'Donate here: <https://shortbot.xyz/donate>'
  event << '**FAQ** :speech_balloon:'
  event << 'More stuff here: <https://brry.cc/shortbot>'

  # Here we don't have to worry about the return value because the `event << line` statement automatically returns nil.
end

bot.command :version do |event|
  versiontext = '[TEST] Current Version: ' + ENV['VERSION']
end

# Run the bot
bot.run
