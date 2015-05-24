require 'digest/sha1'

module Fyber
  class Encrypt

    # @param [String] the string to be encrypted
    # @return [String] encrypted message using SHA1
    def self.generate(message)
      Digest::SHA1.hexdigest(message)
    end

  end

end
