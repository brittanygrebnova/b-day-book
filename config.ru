require 'require_all'
require_all 'app'

use Rack::MethodOverride
use UsersController
use BirthdaysController
run ApplicationController
