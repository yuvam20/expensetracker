require 'httparty'
require 'net/http'
require 'uri'
module Dummyy
   
    def fetchingapi
        # invoice={

        # }
        # url ='https://my.api.mockaroo.com/key="b490bb80"'
        # response=RestClient.get(url)
        # render json:response
        api_key ='b490bb80'
        # HTTParty.post('https://my.api.mockaroo.com/',{
        #     :basic_auth => { :username => api_key },
        #     :body => { 'invoice_id' => 123 }
        # })
        uri='https://my.api.mockaroo.com/invoices.json'
res=Net::HTTP.post URI('https://my.api.mockaroo.com/invoices.json'),
        {"invoice_id" => 2}.to_json,
        'X-API-Key' => "b490bb80"

        
        # res =Net::HTTP.get_response(uri)
        puts res.body

    end
end