defmodule DunkanWeb.OauthController do
  use DunkanWeb, :controller

  alias DunkanWeb.Contracts.OauthContract
  alias Dunkan.Contexts.Users.AuthUserContext
  alias Dunkan.User

  action_fallback DunkanWeb.FallbackController

  def create(conn, oauth_params) do
    with {:ok, valid_params} <- OauthContract.validate(oauth_params),
         {:ok, %User{} = user, token} <- oauth_with_valid_params(valid_params) do
      conn
      |> put_status(:ok)
      |> Plug.Conn.put_session(:user_id, user.id)
      |> Plug.Conn.put_resp_header("x-access-token", token)
      |> render(:show, user: user)
    end
  end

  defp oauth_with_valid_params(valid_params) do
    valid_params
    |> Useful.atomize_map_keys()
    |> AuthUserContext.auth_with_oauth_provider()
  end
end
