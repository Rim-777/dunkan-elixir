defmodule Dunkan.UsersFixtures do
  use ExMachina.Ecto, repo: Dunkan.Repo
  alias Dunkan.Contexts.Users.CreateUserContext

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dunkan.Contexts.Users.Create` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: Map.get(attrs, :email) || sequence(:email, &"dummy-#{&1}@test-mail.com"),
        password: "#Test1234567",
        profile: %{profile_type: "player", displayed_name: "Michael Jordan"},
        oauth_provider: %{name: "facebook", uid: "75cc3264-7c27-4877-a8bf-29605d98f762"}
      })
      |> CreateUserContext.create_with_relations()

    user
  end
end
