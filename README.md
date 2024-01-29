# Cloudally API


This is a wrapper for the CloudAlly portal API v1. You can see the API endpoints here https://api.cloudally.com/documentation

Currently only the GET requests for the Partner Portal API are implemented.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cloudally'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cloudally

## Usage

Before you start making the requests to API provide the client id and client secret and email/password using the configuration wrapping.

```
CloudAlly.configure do |config|
	config.client_id = ENV["CLOUDALLY_CLIENT_ID"]
	config.client_secret = ENV["CLOUDALLY_CLIENT_SECRET"]
	config.username = ENV["CLOUDALLY_USER"]
	config.password = ENV["CLOUDALLY_PASSWORD"]
	config.logger = Logger.new( "./cloudally-http.log" )
end
CloudAlly.partner_login
client = CloudAlly.client
```

## Resources
### Authentication
```
client.partner_login
```
|Resource|API endpoint|Description|
|:--|:--|:--|
|.auth_partner or .partner_login|/auth/partner|Authenticate partner|
|.auth or .login|/auth|Authenticate portal user|
|.auth_refresh|/auth/refresh|Refresh authentication token|

### Partner Portal
Endpoint for partner related requests https://api.cloudally.com/documentation#/Partner%20Portal
```
partner = client.get_partner
puts partner.email
```

|Resource|API endpoint|
|:--|:--|
|.partners or .get_partner|/v1/partners|
|.partner_bills|/v1/partners/bills
|.partner_status or .get_status_by_partner|/v1/partners/status|
|.partner_tasks|/v1/partners/tasks|
|.partner_resellers or .get_resellers_list  |/v1/partners/resellers|
|.partner_resellers( partner_id ) or .get_reseller_by_partner_id( partner_id )|/v1/partners/resellers/{partner_id}|
|.partner_users or .get_users_by_partner|/v1/partners/users|

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jancotanis/cloudally.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
