defmodule Dunkan.Contexts.Users.UpdateUserContext do
  @moduledoc """
  The update User context.
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo

  alias Dunkan.User
  alias Dunkan.OauthProvider

  def add_oauth_provider(%User{id: user_id}, %{name: _name, uid: _uid} = provider_attrs) do
    %OauthProvider{user_id: user_id}
    |> OauthProvider.changeset(provider_attrs)
    |> Repo.insert()
  end
end
