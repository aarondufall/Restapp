# Phoenix Rest JSON API Example with JWT

Requires Erlang, Elixir and postgres

To test this out:

1. clone this repo
2. in the new folder, go to restapp/config/dev.exs and enter your postgres database, username, and password
3. in the new folder, go to restapp/config/test.exs and re-enter your postgres database, username, and password
4. cd to the folder, or just start a terminal in it
5. run mix.deps.get to retrieve jwt libraries
6. run mix ecto.migrate --all
7. run mix compile (this compiles a formatter module which is outside of the /web directory and does not compile automagically)
8. run mix test (should have three passing tests)
9. run mix phoenix.server, then go to localhost:4000/user/login to get a token- copy it. 
10. go to /api/invoices, you will see a 401 unauthorized error.  edit the request headers with the following:
Authorization: Bearer *your token*
this must be included in all requests.
11. post json to the same route in the format {"data":{"contact_id":"1"},"includes":[{"sell_price":"7.48"},{"sell_price":"5.32"}]} 
You should recieve a 201 created status, and reloading get /invoices should show both the invoice and related invoice items

Check in /web/models for the invoice and invoice_item models, where the available fields are located

NOTE: Found no function clause problem in Joken jwt library in Joken.Claims at :crypto hmacs do.  Submitted pull request to creator, but in mean time please replace claims.ex and utils.ex in restapp/deps/joken/lib/joken with same files from my joken fork. After replacing, run mix deps.compile to compile the new files.   


TODO:
Fix tests- always 401 error due to no token passed.
test update, getone, and delete routes
move json reponse for update and create routes to view to be strict MVC compliant


Credits:
1. Thoughtbot rest api example
2. Phoenix and Elixir creators Chris Mccord and Jose Valim
3. Ecto creator, joken, plug_jwt