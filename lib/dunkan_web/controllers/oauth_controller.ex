defmodule DunkanWeb.OauthController do
  use DunkanWeb, :controller

  action_fallback DunkanWeb.FallbackController

  # def authenticate!(conn, %{"account" => account_params}) do
  # end
end
