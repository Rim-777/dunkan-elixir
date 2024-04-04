defmodule DunkanWeb.Router do
  use DunkanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DunkanWeb do
    pipe_through :api
    post "/auth/create", OauthController, :create
  end
end
