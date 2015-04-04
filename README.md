# Phoenix Rest JSON API Example with JWT

Requires Erlang, Elixir and postgres

To test this out:

1. clone this repo
2. in the new folder, go to restapp/config/dev.exs and enter your postgres database, username, and password
3. in the new folder, go to restapp/config/test.exs and re-enter your postgres database, username, and password
4. in restapp.config.exs, add the following:
config :joken,
  secret_key: "test",
  algorithm: :HS256,
  json_module: JWT.Module  
4. cd to the folder, or just start a terminal in it
5. run mix ecto.migrate --all
6. run mix compile (this compiles a formatter module which is outside of the /web directory and does not compile automagically)
7. run mix test (should have three passing tests)
8. run mix phoenix.server, then go to localhost:4000/user/login to get a token- copy it. 
9. go to /api/invoices, you will see a 401 unauthorized error.  edit the request headers with the following:
Authorization: Bearer *your token*
this must be included in all requests.
9. post json to the same route in the format {"data":{"contact_id":"1"},"includes":[{"sell_price":"7.48"},{"sell_price":"5.32"}]} 
You should recieve a 201 created status, and reloading get /invoices should show both the invoice and related invoice items

Check in /web/models for the invoice and invoice_item models, where the available fields are located


TODO:
test update, getone, and delete routes
move json reponse for update and create routes to view to be strict MVC compliant


Credits:
1. Thoughtbot rest api example
2. Phoenix and Elixir creators Chris Mccord and Jose Valim
3. Ecto creator, joken, plug_jwt