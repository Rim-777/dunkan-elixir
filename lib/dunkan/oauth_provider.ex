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
    |> unique_constraint([:name, :user_id])
  end
end
