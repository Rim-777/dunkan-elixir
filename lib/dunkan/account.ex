defmodule Dunkan.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dunkan.User
  alias Dunkan.OauthProvider

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :email, :string
    field :hash_password, :string
    belongs_to :user, User
    has_many :oauth_providers, OauthProvider

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :hash_password])
    |> validate_required([:email, :hash_password])
    |> unique_constraint(:email)
    |> unique_constraint(:user_id)
  end
end
