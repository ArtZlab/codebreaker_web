require './gameapp'
use Rack::Static, :urls => ["/assets"]
use Rack::Session::Cookie, key: 'codebreaker',
                           path: '/',
                           expire_after: 2592000,
                           secret: 'codebreaker'
run GameApp