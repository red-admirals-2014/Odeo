# CR move this to a JS model.

class Cloud
  include HTTParty

  attr_accessor :process_url

  base_uri 'api.cloudconvert.org'

  def initialize
    @key = ENV['CLOUD_API_KEY']
    @process_url = get_process_url
  end

  private

  def get_process_url
    response = HTTParty.post("https://api.cloudconvert.org/process",{
      :body => {
        apikey: @key,
        inputformat: 'wav',
        outputformat: 'mp3'
      }
    })
    url = "https:#{response['url']}"
    url
  end
end
