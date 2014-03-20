You'll need to update a few config files in order to do things exactly the same way
as focalhero.co.uk:
- google_config.rb contains google API secrets: see google_config.rb.example
- paypal_config.rb contains PayPal API secrets: see paypal_config.rb.example
- google_analytics.rb contains Google Analytics tracking code: see
  google_analytics.rb.example

Those are to allow site admins to log in using OAuth2 and have the sign-in managed by
GooglePlus or Paypal.
Alternatively you can handle your own logins if you want to make your site admins have to
cope with yet another account and password, and if you want to handle password security
yourself. (You don't!)
If you don't intend to use the Google sign-in API, the PayPal sign-in
API or Google Analytics tracking then just copying the example files
as-is should be fine!

- istockapikey contains iStock API secret key: see istockapikey.example

This allows reading of lightbox content via the istock API. If you don't have an API
key you could, of course, implement a fixed set of images or read the contents with
a JavaScript ajax function, for example.

