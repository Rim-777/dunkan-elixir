defmodule DunkanWeb.OauthController do
  use DunkanWeb, :controller

  alias DunkanWeb.Contracts.OauthContract
  alias Dunkan.Contexts.Users.AuthUserContext
  alias Dunkan.User

  action_fallback DunkanWeb.FallbackController

  def create(conn, oauth_params) do
    with {:ok, valid_params} <- OauthContract.validate(oauth_params) do
      with {:ok, %User{} = user, token} <-
             Useful.atomize_map_keys(valid_params)
             |> AuthUserContext.auth_with_oauth_provider() do
        conn
        |> put_status(:ok)
        |> Plug.Conn.put_resp_header("Access-Token", token)
        |> render(:show, user: user)
      end
    end
  end
end

# %{
#   "oauth_user" => %{
#     "email" => "timo.moss.123@gmail.co",
#     "oauth_provider" => %{"name" => "google", "uid" => "123"},
#     "password" => "qwepiuqwepiuqwe",
#     "profile" => %{
#       "displayed_name" => "Michele Jordan",
#       "photo_url" => "https//:somephoto"
#     }
#   }
# }
