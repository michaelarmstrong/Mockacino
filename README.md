Mockacino
=====================

A very simple and easy to use MOCK API server that serves static JSON written in ruby/sinatra.

----------

 **NOTE:** This is a super simple, super fragile MOCKING SERVER Intended so you can test routes and mock an API with static jso whilst you're still building the real production API. **DO NOT EVER use this in production...** Seriously. It breaks a lot and will if you try... DONT. Absolutely 0 effort went into it, therefor 0 Warranty. Use if you dare.

 **DOCS:**

 Folder structure defines API calls.... return.json is what gets served.

    site_root ->
        [ http method ] -> [ api call route ] -> [ json response contents of call return.json ] 
   
   e.g.

    site_root ->
        GET -> users -> return.json
        POST -> users -> create -> return.json
 
 If you have static assets you wanna reference in the json, plonk them in the ASSETS folder
 
   e.g.
  
    site_root -> file.jpg
 
   You can call http://yourhost:port/ASSETS/file.jpg
   
   Here's the directory structure of the sample project included here
 
    mockacino.rb  
    ./site_root/ASSETS
    ./site_root/GET
    ./site_root/POST
    ./site_root/GET/sheep
    ./site_root/GET/sheep/create
    ./site_root/GET/sheep/return.json
    ./site_root/GET/sheep/create/return.json

Which supports calls like...

    http://localhost:4321/sheep
    http://localhost:4321/sheep/create
    
And gives responses from the static result.json file like...

    {
        "sheep": [
            {
                "id": "1234",
                "name": "Dolly Two",
                "url": "http://mike.kz/sheep1234",
                "assets": {
                    "small_image": "http://cloned.sheep.com/ASSETS/small.jpg",
                    "large_image": "http://cloned.sheep.com/ASSETS/large.jpg"
                }
            }
        ]
    }



**Usage:**

    gem install sinatra
    ruby mockacino.rb


   =)  I'm [@ArmstrongAtWork][1] on Twitter if you wanna moan.


  [1]: http://twitter.com/ArmstrongAtWork
