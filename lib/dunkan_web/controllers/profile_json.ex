defmodule DunkanWeb.ProfileJSON do
  alias Dunkan.Profile

  @doc """
  Renders a single user.
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
        displayed_name: profile.displayed_name,
        type: profile.type
      }
    }
  end
end
