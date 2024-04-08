defmodule DunkanWeb.OauthController do
  use DunkanWeb, :controller

  alias DunkanWeb.Contracts.OauthContract
  alias Dunkan.Contexts.Users.AuthUserContext
  alias Dunkan.User

  action_fallback DunkanWeb.FallbackController

  @doc """
  Accepts oauth params, validates params with json schema validation
  Invokes AuthUserContext

  renders  with user and a related profile attributes
  renders json with errors in cases of:
   400(invalid schema)
   401(invalid password)
   422(invalid db storing) 
  """
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
