#!/usr/bin/env ruby

require 'json'
require 'uri'
require 'yaml'
require 'net/http'
require 'getoptlong'

args = {  
          :yaml  => false,
          :param => "role",
}

opts = GetoptLong.new(
  [ '--dump-yaml', '-y', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--param', '-p', GetoptLong::OPTIONAL_ARGUMENT ]
)

opts.each do |opt, arg|
  case opt
    when '--dump-yaml'
      args[:yaml] = true
    when '--param'
      args[:param] = arg
  end
end

begin
  url = URI.parse('http://169.254.169.254/latest/user-data')
  http = Net::HTTP.new(url.host, url.port)
  response = http.request(Net::HTTP::Get.new(url.request_uri))
  user_data = JSON.parse(response.body)
  if args[:yaml]
    puts user_data.to_yaml
    exit!
  else
    puts user_data[args[:param]]
  end
rescue Exception => e
  STDERR.puts "SCRIPT ERROR: #{e.message}"
end

