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

## Endpoints
Right now, from the perspective of the client there are 3 entities, Users, Todos and Tokens.

We can create a user by posting to `/users` with a username and desired password
```
POST /users
{
  "username": "jurrre",
  "password": "2s3cr3t4u"
}
```

Once we do this we can retrieve a token by posting this same info to `/tokens`
```
POST /tokens
{
  "username": "jurrre"
  "password": "2s3cr3t4u"
}

# RESPONSE
{
  "token": "i8gT-xL6QCKj_bwFr9JPOA",
  "_embedded": {
    "user": {
      "id": 2,
      "username": "jurrre"
    }
  }
}
```

Now we can start creating Todo's by posting to `/todos`
```
POST /todos
X-Authorization: i8gT-xL6QCKj_bwFr9JPOA
Body:
{
  "title": "Make a client app"
}

# RESPONSE
{
  "id": 2,
  "title": "Make a client app",
  "completed": false,
  "_links": {
    "self": {
      "href": "http://localhost:5000/todos/2"
    }
  }
}
```

We can fetch a collection of todos by getting from `/todos`
```
GET /todos
X-Authorization: i8gT-xL6QCKj_bwFr9JPOA

# RESPONSE
{
  "total": 2,
  "_embedded": {
    "todos": [
    {
      "id": 1,
      "title": "Make a client app",
      "completed": false,
      "_links": {
        "self": {
          "href": "http://localhost:5000/todos/1"
        }
      }
    },
    {
      "id": 2,
      "title": "Make an iOS app",
      "completed": false,
      "_links": {
        "self": {
          "href": "http://localhost:5000/todos/2"
        }
      }
    }
    ]
  },
  "_links": {
    "self": {
      "href": "http://localhost:5000/todos"
    }
  }
}
```

There are also ways to update todos by sending a `patch` to `todos/:id` and fetching a single todo by sending a `get` to `/todos/:id`
