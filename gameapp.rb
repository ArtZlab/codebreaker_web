require 'bundler/setup'
require "codebreaker"

class GameApp
  def self.call(env)
    new(env).resp.finish
  end

  def initialize(env)
    @req = Rack::Request.new(env)
  end

  def resp

    if     @req.path == '/' && @req.get?
           @req.session.clear
           @req.session[:game] = Codebreaker::Game.new
           Rack::Response.new(File.open("views/index.html").read)
    
    elsif  @req.path == '/' && @req.post? && @req.xhr?
           input = @req.body.read.split('=').last
           game = @req.session[:game]
           game.req(input)
           Rack::Response.new(game.resp)

    else   Rack::Response.new('Not Found', 404)

    end

  end

end
