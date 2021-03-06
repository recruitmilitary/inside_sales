require 'json'
require 'rest_client'

module InsideSales

  class Client

    Error = Class.new(StandardError)
    AuthenticationError = Class.new(Error)

    def initialize(subdomain, username, password, token)
      @username, @password, @token, @subdomain = username, password, token, subdomain
      @endpoint_url = "https://#{@subdomain}.insidesales.com/do=noauth/rest/service"
    end

    # This is a special type of request that is not handled via
    # method_missing because of the logic required to set the cookies.
    def login
      response = request(:login, [@username, @password, @token])
      @cookies = response.cookies
      response
    end

    # dynamically dispatch methods to the web service
    def method_missing(meth, *args, &block)
      request(camelize(meth.to_s, false), [*args])
    end

    private

    # Unfortunately the InsideSales API does not always return valid
    # JSON, so we have to work around it a bit.
    def request(operation, parameters)
      response = RestClient.post(@endpoint_url, {
                                   :operation => operation,
                                   :parameters => parameters
                                 }.to_json,
                                 { :cookies => @cookies })
      parsed   = JSON.parse response
      if parsed.is_a?(Hash) && parsed.has_key?("exception")
        raise Error, parsed["exception"]["string"]
      else
        parsed
      end
    rescue JSON::ParserError
      response
    end

    # Taken from ActiveSupport
    def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      if first_letter_in_uppercase
        lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      else
        lower_case_and_underscored_word.to_s[0].chr.downcase + camelize(lower_case_and_underscored_word)[1..-1]
      end
    end

  end

end
