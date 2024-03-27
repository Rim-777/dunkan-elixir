defmodule Dunkan.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dunkan.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(_attrs \\ %{}) do
    # {:ok, user} =
    #   attrs
    #   |> Enum.into(%{
    #     user: %{
    #       email: Map.get(attrs, :email) || sequence(:email, &"dummy-#{&1}@test-mail.com"),
    #       hash_password: "#Test1234567"
    #     },
    #     type: :player,
    #     first_name: "some first_name",
    #     middle_name: "some full_name",
    #     last_name: "some sure_name",
    #     gender: "some gender"
    #   })
    #   |> Dunkan.Users.create_user()

    # user
  end
end
