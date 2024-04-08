# Dunkan

Scout digital API platform for the promotion of talented juniors basketball players

Depends on:
Elixir 1.16.2 and newer
Postgresql database

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Docker version:

1. Clone this repository to you local computer
2. ```markdown
   cd ./dunkan-elixir `
   ```

3. ```markdown
   docker-compose build
   ```

4. ```markdown
   docker-compose run --rm -p 4000:4000 api
   ```

The top level domain is [`localhost:4000`](http://localhost:4000) .

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
