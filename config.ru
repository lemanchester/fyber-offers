$stdout.sync = true

require './lib/fyber'
require './web'

run Fyber::Web

class Rack::Protection::FrameOptions
  def header
    @header ||= {}
  end
end
