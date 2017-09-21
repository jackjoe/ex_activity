[![Build Status](https://travis-ci.org/jackjoe/ex_activity.svg)](https://travis-ci.org/jackjoe/ex_activity)

# ExActivity

Logs activity to your database - using Ecto. You have control what you log, in a structured way.

> **Warning:** this is still very alpha

## Installation

Add `ex_activity` and your Ecto database adapter to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_activity, "~> 0.2.0"},
    {:mariaex, "~> 0.8.2"} # you can use any other Ecto adapter here
  ]
end
```
Then run mix deps.get to fetch the dependencies.

Next provide configuration for the repo ExActivity will use:

```elixir
config :ex_activity, ExActivity.Repo,
  adapter: Ecto.Adapters.MySQL, # or use postgres
  username: "sqluser",
  password: "",
  database: "app_db",
  hostname: "localhost",
```

## Usage

Provide a filled out `ExActivity.Log` struct and pass it to the log method:

```elixir
ExActivity.log(%ExActivity.Log{
  type: "api_call",
  action: "UserController/list" ,
  result: "user_count: 10"
})
```

## Documentation

The docs can be found at [https://hexdocs.pm/ex_activity](https://hexdocs.pm/ex_activity).

## Why?

We are new to the Phoenix/Elixir club, and were set in our ways when it comes to logging. We prefer to log important actions to a database, in a unified way. While we use the default Elixir logger to log general stuff to services like PaperTrail, we needed something more. We used ActivityLog in Laravel before, so we made ExActivity.

## TODO

  - [ ] improve documentation
  - [x] ip / user_agent from conn
  - [ ] run migrations when installing
  - [ ] extend docs with more information

## License

ExActivity is Copyright © 2017 Jack+Joe. It is free software, and may be
redistributed under the terms specified in the [LICENSE](/LICENSE) file.
