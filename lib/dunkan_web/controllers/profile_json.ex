defmodule DunkanWeb.ProfileJSON do
  alias Dunkan.Profile

  @doc """
  Renders a associated profile.
  """
  def show(%{profile: profile}) do
    %{data: data(profile)}
  end

  defp data(%Profile{} = profile) do
    %{
      id: profile.id,
      type: "profile",
      attributes: %{
        first_name: profile.first_name,
        last_name: profile.last_name,
        middle_name: profile.middle_name,
        gender: profile.gender,
        date_of_birth: profile.date_of_birth,
        displayed_name: profile.displayed_name,
        profile_type: profile.profile_type,
        photo_url: profile.photo_url
      }
    }
  end
end
