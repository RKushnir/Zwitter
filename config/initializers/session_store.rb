# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_timecomunity_session',
  :secret      => '3de999c446fb44b36846e94c61090d492aee744ba50adb6cb4fcc73551e252fd990bef1611dd1ccf0676c0c16e0d3c6fdabaa5532ed8d044b202c04d58d59817'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
