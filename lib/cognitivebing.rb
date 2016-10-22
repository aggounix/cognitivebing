require "cognitivebing/version"
require 'json'
require 'open-uri'
require 'net/http'

class CognitiveBing
  attr_accessor :account_key, :params 
  
  def initialize(account_key, params = {})
    @account_key = account_key    
    @params = params
  end
  
  def search(search_term)
    
    user = ''
    #sources_portion = URI.encode_www_form_component('\'' + @type + '\'')
    query_string = 'q='
    query_portion = URI.encode_www_form_component('\'' + search_term + '\'')
    params = "&Ocp-Apim-Subscription-Key=#{@account_key}&count=20&offset=0&mkt=fr-FR&safesearch=Moderate"
    #@params.each do |k,v|
    #  params << "&#{k.to_s}=\'#{v.to_s}\'"
    #end
    
    
    web_search_url = "https://api.cognitive.microsoft.com/bing/v5.0/search?"
    full_address = web_search_url + query_string + query_portion + params   
    
    
    uri = URI(full_address)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field("Ocp-Apim-Subscription-Key", @account_key)
    

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https'){|http|
      http.request(req)
    }

    body = JSON.parse(res.body, :symbolize_names => true)
        
    #puts body[:webPages].keys
    #puts body[:webPages][:value]
    #result_set = body[:d][:results]
    return body
  end
end