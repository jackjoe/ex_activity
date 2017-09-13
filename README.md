[![Build Status](https://travis-ci.org/jackjoe/ex_activity.svg)](https://travis-ci.org/jackjoe/ex_activity)

# ExActivity

Logs activity to your database - using Ecto. You have control what you log, in a structured way.

## Installation

Add `ex_activity` and your Ecto database adapter to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_activity, "~> 0.1.4"},
    {:mariaex, "~> 0.8.2"}
  ]
end
```
Then run mix deps.get to fetch the dependencies.

Next provide configuration for the repo ExActivity will use:

```elixir
config :ex_activity,
  adapter: Ecto.Adapters.MySQL,
  username: "sqluser",
  password: "",
  database: "app_db",
  hostname: "localhost",
  charset: "utf8mb4",
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

## License

MIT License. Copyright 2017 Jack+Joe.
