# Todo API

A simple HAL/JSON Todo API with Sinatra and PostgreSQL.
This API will let you register an account, sign in, create/edit/delete and view Todo's.

## Setup

```bash
bundle install
rake db:setup # this will generate a todos_development and todos_test db
rake db:migrate # runs the migrations in db/migrations
rake db:migrate RACK_ENV=test # migrate test db
```

You can run the specs with the default `rake` command.
The server can be started with foreman by running `foreman start`.

## System requirements
- Ruby 2.1.5
- PostgreSQL
