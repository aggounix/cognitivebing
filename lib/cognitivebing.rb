require "cognitivebing/version"
require 'json'
require 'open-uri'
require 'net/http'

class CognitiveBing
  class BingUnavailableException < StandardError;
  end

  attr_accessor :account_key, :params

  def initialize(account_key, params = {}, version: 'v7.0')
    @account_key = account_key
    @params = params
    @version = version
  end


  def search(search_term, type = 'web')


    query_string = '?q='
    query_portion = URI.encode_www_form_component(search_term)
    params = ""
    @params.each do |k, v|
      params << "&#{k.to_s}=#{v.to_s}"

    end

    web_search_url = ""

    if type == "videos"
      web_search_url = "https://api.cognitive.microsoft.com/bing/#{@version}/videos/search"
    elsif type == "image"
      web_search_url = "https://api.cognitive.microsoft.com/bing/#{@version}/images/search"
    else
      web_search_url = "https://api.cognitive.microsoft.com/bing/#{@version}/search"
    end

    full_address = web_search_url + query_string + query_portion + params

    uri = URI(full_address)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field("Ocp-Apim-Subscription-Key", @account_key)


    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http|
      http.request(req)
    }


    body = JSON.parse(res.body, :symbolize_names => true)
  rescue => e
    if e.message.include?("Bing services aren't available right now")
      raise(BingUnavailableException)
    else
      raise(e)
    end
  end

  def suggestions(search_term)


    query_string = '?q='
    query_portion = URI.encode_www_form_component(search_term)


    web_search_url = "https://api.cognitive.microsoft.com/bing/#{@version}/suggestions"

    full_address = web_search_url + query_string + query_portion

    uri = URI(full_address)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field("Ocp-Apim-Subscription-Key", @account_key)


    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http|
      http.request(req)
    }

    body = JSON.parse(res.body, :symbolize_names => true)


    return body
  end

end


class CognitiveBingNews
  attr_accessor :account_key

  def initialize(account_key, params = {})
    @account_key = account_key
    @params = params
  end

  def search(search_term)


    query_string = '?q='
    query_portion = URI.encode_www_form_component(search_term)
    paramsbuilder = "&Ocp-Apim-Subscription-Key=#{@account_key}"
    @params.each do |k, v|
      paramsbuilder << "&#{k.to_s}=#{v.to_s}"


    end

    web_search_url = "https://api.cognitive.microsoft.com/bing/#{@version}/news/search"


    full_address = web_search_url + query_string + query_portion + paramsbuilder


    uri = URI(full_address)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field("Ocp-Apim-Subscription-Key", @account_key)


    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http|
      http.request(req)
    }

    body = JSON.parse(res.body, :symbolize_names => true)


    return body
  end


  def category(category_term, params = {})

    web_search_url = URI("https://api.cognitive.microsoft.com/bing/#{@version}/news/")
    web_search_url.query = URI.encode_www_form({
      # Request parameters
      'category' => category_term.to_s
    })


    uri = URI(web_search_url)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field("Ocp-Apim-Subscription-Key", @account_key)


    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http|
      http.request(req)
    }

    body = JSON.parse(res.body, :symbolize_names => true)


    return body
  end


  def trending

    web_search_url = "https://api.cognitive.microsoft.com/bing/#{@version}/news/trendingtopics"


    uri = URI(web_search_url)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field("Ocp-Apim-Subscription-Key", @account_key)


    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http|
      http.request(req)
    }

    body = JSON.parse(res.body, :symbolize_names => true)

    return body
  end
end
