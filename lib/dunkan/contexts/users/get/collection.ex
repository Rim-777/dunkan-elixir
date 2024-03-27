defmodule Dunkan.Contexts.Users.Get.Collections do
  @moduledoc """
  The Users Get collection context.
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo
  alias Dunkan.User

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%User{}, ...]

  """

  def list_users do
    Repo.all(User)
  end
end
