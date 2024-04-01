defmodule DunkanWeb.OauthController do
  use DunkanWeb, :controller

  action_fallback DunkanWeb.FallbackController

  # def auth_with_oauth_provider!(conn, %{"user" => oauth_params}) do
  # end
end
