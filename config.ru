$stdout.sync = true

require './web'

run Fyber::Web

class Rack::Protection::FrameOptions
  def header
    @header ||= {}
  end
end
