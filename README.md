[![Build Status](https://travis-ci.org/jackjoe/ex_activity.svg)](https://travis-ci.org/jackjoe/ex_activity)

# ExActivity

Web app logging as it was meant to be: non-blocking and abundant\*

###### \* non-blocking means: in a separate Elixir Task.

> **Warning:** this is still very alpha

## What?

Web applications have a lot going on, and you want to be in control of the flow. Logging is crucial, but logging too much will slow down those µ-second response times! Not with Elixir and
ExActivity! It logs activity to your database in a non-blocking way, using Ecto. You have control what you log, in a structured way.

## Installation

### Setup

Add `ex_activity` and your Ecto database adapter to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_activity, "~> 0.2.0"},
    {:mariaex, "~> 0.8.2"} # you can use any other Ecto adapter here
  ]
end
```
Then run `mix deps.get` to fetch the dependencies.

Next provide configuration for the repo ExActivity will use:

```elixir
config :ex_activity, ExActivity.Repo,
  adapter: Ecto.Adapters.MySQL, # or use postgres
  username: "sqluser",
  password: "",
  database: "app_db",
  hostname: "localhost",
```

### Migrate

The repo contains two migration files to setup your db. Just copy them to your own `priv/repo/migrations` folder and run:

`mix ecto.migrate`

> Note: using other adapters than `MySQL` has not been thoroughly tested. Although once setup we use no proprietary query syntax, the migrations you can run to get your db ready using the mix tasks *are* MySQL specific. This in on our TODO list.

## Usage

Provide a filled out `ExActivity.Log` struct and pass it to the log method:

```elixir
ExActivity.log(%ExActivity.Log{
  type: "api_call",
  action: "UserController/list" ,
  result: "user_count: 10"
})
```

### Properties
  * `type` - gives more context about the action you are logging; it could be the name of the controller where you log from, the context, ...
  * `action` - method name, sub-action in method, ...
  * `result` - outcome of the action such as ERROR, SUCCESS, WRONG_CODE, ...
  * `details` - more like meta date about current state
  * `data` - raw data, request parameters, db result, ...

  _For now everything should be string or integer (for some fields), we will try to expand this to accept more data/struct like structures, and encode them to JSON._

## Documentation

The docs can be found at [https://hexdocs.pm/ex_activity](https://hexdocs.pm/ex_activity).

## Why? Use `:logger` already!

We are new to the Phoenix/Elixir club, and were set in our ways when it comes to logging. We prefer to log important actions to a database, in a unified way. While we use the default Elixir logger to log general stuff to services like PaperTrail, we needed something more. We used ActivityLog in Laravel before, so we made ExActivity.

## TODO

  - [x] improve documentation
  - [x] ip / user_agent from conn
  - [ ] make migrations adapter agnostic (LONGTEXT)
  - [ ] run migrations when installing
  - [x] extend docs with more information

## License

ExActivity is Copyright © 2017 Jack+Joe. It is free software, and may be
redistributed under the terms specified in the [LICENSE](/LICENSE) file.
