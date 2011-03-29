begin
  # Try to require the preresolved locked set of gems.
  require ::File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

Bundler.require(:default)

require 'rack/contrib'
require 'rack-rewrite'

output = File.expand_path("../output", __FILE__)

use Rack::Static, :urls => ['/images', '/stylesheets', '/javascripts'], :root => output
use Rack::Rewrite do
  rewrite '/', "/index.html"
end
run Rack::File.new('output')


