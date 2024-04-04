defmodule DunkanWeb.OauthJSON do
  alias Dunkan.User
  alias Dunkan.Profile
  alias DunkanWeb.ProfileJSON

  @doc """
  Renders a user account.
  """

  def show(%{user: user}) do
    %{
      data: data(user)
    }
  end

  defp data(%User{
         id: user_id,
         email: email,
         phone_number: phone_number,
         profile: %Profile{} = profile
       }) do
    %{
      id: user_id,
      type: "user",
      attributes: %{
        email: email,
        phone_number: phone_number
      },
      relationships: %{
        profile: ProfileJSON.show(%{profile: profile})
      }
    }
  end
end
