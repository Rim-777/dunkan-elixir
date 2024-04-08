defmodule Dunkan.OauthProvider do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dunkan.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "oauth_providers" do
    field :name, Ecto.Enum, values: [:google, :apple_id, :facebook]
    field :uid, :string

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(oauth_provider, attrs) do
    oauth_provider
    |> cast(attrs, [:name, :uid])
    |> validate_required([:name, :uid])
    |> unsafe_validate_unique([:name, :uid], Dunkan.Repo,
      message: "Combination of Provider name and UID must be unique"
    )
    |> unique_constraint([:name, :uid])
  end
end
