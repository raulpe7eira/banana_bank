# BananaBank

This code corresponds to the [Section 3:9 of Elixir e Phoenix do Zero Course](https://www.udemy.com/course/elixir-e-phoenix-do-zero) lab by [Rafael Camarda](https://cursos.rafaelcamarda.com/).

> The project simulates a bank, where it's possible to register a user with a real CEP, an account for an user, and do transactions between accounts.

## Compilation, tests and runs

```bash
$ cd banana_bank
$ asdf install
$ mix compile
$ mix ecto.setup
$ mix test
$ iex -S mix phx.server
```

## How to use?

```bash
# retrieve welcome
curl -X GET 'http://localhost:4000/api'

# -----------------------------------------------------------------------------

# create user
curl -X POST 'http://localhost:4000/api/users' \
-H 'Content-Type: application/json' \
-d '{
    "cep": "12312312",
    "email": "raul@mail.com",
    "password": "111111",
    "name": "Raul"
}'

# login user
curl -X POST 'http://localhost:4000/api/users/login' \
-H 'Content-Type: application/json' \
-d '{
    "id": "1",
    "password": "111111"
}'

# retrieve user by id (
#   :id - user identifier
#   :token - authorization token
# )
curl -X GET 'http://localhost:4000/api/users/:id' \
-H 'Authorization: :token'

# update user by id (
#   :id - user identifier
#   :token - authorization token
# )
curl -X PUT 'http://localhost:4000/api/users/:id' \
-H 'Authorization: :token' \
-H 'Content-Type: application/json' \
-d '{
    "email": "raul-new@mail.com",
    "password": "aaaaaa"
}'

# delete user by id (
#   :id - user identifier
#   :token - authorization token
# )
curl -X DELETE 'http://localhost:4000/api/users/:id' \
-H 'Authorization: :token'

# -----------------------------------------------------------------------------

# create account (
#   :token - authorization token
# )
curl -X POST 'http://localhost:4000/api/accounts' \
-H 'Authorization: :token' \
-H 'Content-Type: application/json' \
-d '{
    "user_id": "1",
    "balance": 100000
}'

# -----------------------------------------------------------------------------

# create transaction between accounts (
#   :token - authorization token
# )
curl -X POST 'http://localhost:4000/api/accounts/transactions' \
-H 'Authorization: :token' \
-H 'Content-Type: application/json' \
-d '{
    "from_account_id": "1",
    "to_account_id": "2",
    "amount": 0.01
}'
```

