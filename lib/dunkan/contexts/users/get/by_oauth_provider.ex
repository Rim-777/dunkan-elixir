defmodule Dunkan.Contexts.Users.Get.ByOauthProvider do
  @moduledoc """
  The Users Get by oauth provider context.
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo

  alias Dunkan.OauthProvider

  def get_user(%{name: provider_name, uid: user_uid}) do
    query =
      from oauth_provider in OauthProvider,
        preload: [:user],
        where: oauth_provider.name == ^provider_name and oauth_provider.uid == ^user_uid,
        select: oauth_provider.user

    Repo.one(query)
  end
end
