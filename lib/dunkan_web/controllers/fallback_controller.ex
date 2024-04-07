defmodule DunkanWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use DunkanWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: DunkanWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: DunkanWeb.ErrorJSON)
    |> render(:"404")
  end

  # This clause is an example of how to handle unauthorized request.
  def call(conn, {:error, :invalid_password}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(json: DunkanWeb.ErrorJSON)
    |> render(:"401")
  end

  # This clause is an example of how to handle bad request.
  def call(conn, {:json_schema_error, errors}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: DunkanWeb.ErrorJSON)
    |> assign(:json_schema_error, errors)
    |> render(:"400")
  end
end
