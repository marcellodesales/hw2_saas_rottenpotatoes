# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rottenpotatoes::Application.initialize!

# TMDb configuration https://github.com/aarongough/ruby-tmdb
# setup your API key
Tmdb.api_key = "6ab5c7d848120954b255b916cf5d6b16"
# setup your default language
Tmdb.default_language = "en"

