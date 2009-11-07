# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bbs_session',
  :secret      => '81d572d85939b565859aab8798facb5c931404fb8ba0e06eb9a02bc6a315183a6803047c5941e543bb4b5f9d39266f9481cdd7a4dfa87fd31d2b7a238dfa1af7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
