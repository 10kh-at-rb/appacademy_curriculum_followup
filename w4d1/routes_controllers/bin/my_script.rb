require 'addressable/uri'
require 'rest-client'

begin

  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1'
    # query_values: {
    #   'food[italian]' => 'pizza',
    #   'food[mexican]' => 'pizza',
    #   'food[texmex][tortilla]' => 'pizza',
    #   'food[texmex][corntaco]' => 'pizza',
    #   'places' => 'pizza'
    # }
  ).to_s


  hash = {:user => {
        :username => 'Omzig'
      }}

  puts RestClient.put(url, hash)

rescue Exception
end
