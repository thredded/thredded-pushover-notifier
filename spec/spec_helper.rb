$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'thredded/pushover_notifier'

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }

