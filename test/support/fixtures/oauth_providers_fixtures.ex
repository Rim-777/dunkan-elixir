defmodule Dunkan.OauthProvidersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dunkan.OauthProviders` context.
  """

  @doc """
  Generate a oauth_provider.
  """
  def oauth_provider_fixture(attrs \\ %{}) do
    {:ok, oauth_provider} =
      attrs
      |> Enum.into(%{
        name: "some name",
        provider_uid: "some provider_uid"
      })
      |> Dunkan.OauthProviders.create_oauth_provider()

    oauth_provider
  end
end
