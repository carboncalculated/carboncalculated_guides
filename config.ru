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

use Rack::Static, :urls => ['/output/images', '/output/stylesheets', '/output/javascripts'], :root => "output"
use Rack::ETag
use Rack::Rewrite do
  rewrite '/', '/index.html'
end
run Rack::Directory.new('output')