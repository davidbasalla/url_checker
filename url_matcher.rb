require 'rest-client'

class UrlMatcher
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def match
    puts "Processing: #{link}"
    [link, status_code]
  end

  def status_code
    response.code
  rescue Exception => e
    e.message
  end

  def response
    RestClient.get(url.to_s)
  end

  def url 
    URI.parse(link)
  end
end
