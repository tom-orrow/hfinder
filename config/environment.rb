# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load ENV settings
$CONFIG = YAML.load_file Rails.root.join('config', 'settings.yml')

# Initialize the Rails application.
Hfinder::Application.initialize!
