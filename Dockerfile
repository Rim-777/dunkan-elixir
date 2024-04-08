# Use the official Elixir image
FROM elixir:1.16.2

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set environment variables
ENV MIX_ENV=dev \
    PHOENIX_VERSION=1.7.11

# Install the latest version of Phoenix
RUN mix archive.install hex phx_new $PHOENIX_VERSION --force

# Set /app as the working directory
WORKDIR /app

# Copy and install dependencies
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Copy the rest of the application code
COPY . .

# Compile the project
RUN mix compile

# Expose port 4000
EXPOSE 4000

# Default command to run the Phoenix server
CMD ["mix", "phx.server"]
