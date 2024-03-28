defmodule Dunkan.Contexts.Users.CreateUser do
  @moduledoc """
  The Users create with relations context.
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo

  alias Dunkan.User

  def with_relations(attrs \\ %{}) do
    attrs = build_attrs(attrs)

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  defp build_attrs(attrs) do
    {auth_provider, rest_attrs} = Map.pop(attrs, :oauth_provider)

    rest_attrs
    |> Map.put(:oauth_providers, [auth_provider])
  end
end
