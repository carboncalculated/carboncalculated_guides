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

output = File.expand_path("../output", __FILE__)
require 'sinatra'
set :root, File.dirname(output)
set :public, output

get "/" do
  File.read(File.join(output, 'index.html'))
end
run Sinatra::Application


