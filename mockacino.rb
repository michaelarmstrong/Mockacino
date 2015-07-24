#!/bin/env ruby
#
# NOTE: This is a super simple, super fragile MOCKING SERVER
#       Intended so you can test routes and mock an API with static json
#       whilst you're still building the real production API.
#       DO NOT EVER use this in production... Seriously.
#       It breaks a lot and will if you try... DONT.
#       Absolutely 0 effort went into it, therefor 0 Warranty.
#       Use if you dare.
#
# DOCS:
#
# Folder structure defines API calls.... return.json is what gets served.
#
#   site_root ->
#       [ http method ] -> [ api call route ] -> [ json response contents of call return.json ] 
#   
#   e.g.
#
#   site_root ->
#       GET -> users -> return.json
#       POST -> users -> create -> return.json
#
# If you have static assets you wanna reference in the json, plonk them in the ASSETS folder
# 
#   e.g.
#  
#   site_root -> file.jpg
#
#   You can call http://yourhost:port/ASSETS/file.jpg
#
#
#   =)  I'm @ArmstrongAtWork on Twitter if you wanna moan.
#
#
require 'sinatra'

# Configurable Bits

class MockacinoConfig
    @site_root = 'site_root'
    @get_path = 'GET'
    @post_path = 'POST'
    @assets_path = 'ASSETS'
    @index_file = 'return.json'
    @config_file = 'config'
    @port_number = 4321
    @listen_address = '0.0.0.0' 

   def self.site_root 
     return @site_root
   end
   
   def self.get_path
     return @get_path
   end

   def self.post_path
     return @post_path
   end

   def self.assets_path
     return @assets_path
   end

   def self.index_file
     return @index_file
   end

   def self.config_file
     return @config_file
   end

   def self.port_number
     return @port_number
   end

   def self.listen_address
      return @listen_address
   end
end

# Important Bits


set :port, MockacinoConfig.port_number
set :bind, MockacinoConfig.listen_address

get '/' do
  puts "It was a {#request.request_method} request, serving #{@site_root}/#{@get_path}/#{@index_file}"
  File.read(File.join(@site_root, @get_path, @index_file))
end

get '/#{MockacinoConfig.assets_path}/:token' do
  path = params[:token]
  puts "It was an ASSET request, serving #{MockacinoConfig.assets_path}/#{path}"
  File.read(File.join(MockacinoConfig.site_root, MockacinoConfig.assets_path, path))
end

post '/:token*' do
  path = params[:token]
  extension = params[:splat].first
  
  filePath = File.join(MockacinoConfig.site_root, MockacinoConfig.post_path, path, extension, MockacinoConfig.config_file)
  if File.exist?(filePath)
      file = File.read(filePath)
      status file
  end

  puts "It was a POST request, routing to #{MockacinoConfig.site_root}/#{MockacinoConfig.post_path}/#{path}#{extension}/#{MockacinoConfig.index_file}"
  File.read(File.join(MockacinoConfig.site_root, MockacinoConfig.post_path, path, extension, MockacinoConfig.index_file))
end

get '/:token*' do
  path = params[:token]   
  extension = params[:splat].first
  
  filePath = File.join(MockacinoConfig.site_root, MockacinoConfig.get_path, path, extension, MockacinoConfig.config_file)
  if File.exist?(filePath)
      file = File.read(filePath)
      status file
  end

  puts "It was a GET request, routing to #{MockacinoConfig.site_root}/#{MockacinoConfig.get_path}/#{path}#{extension}/#{MockacinoConfig.index_file}"
  File.read(File.join(MockacinoConfig.site_root, MockacinoConfig.get_path, path, extension, MockacinoConfig.index_file))
end





