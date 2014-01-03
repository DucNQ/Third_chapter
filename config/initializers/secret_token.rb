# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

require 'securerandom'

def secure_token
	token_file = Rails.root.join('.secret')
	if File.exist?(token_file)
		File.read(token_file).chomp
	else 
		token = SecureRandom.hex(64)
		File.write(token_file, token)
		token
	end
end

ThirdChapter::Application.config.secret_key_base = 'e40e7d67e59cef8a7b2e9655aa88de0e4ab300915fe36dc96349405c2990e86ee0c6e1cf199a5353422533702518dcddf4748d211545b0f9cd3e1ad3c9c150e4'
