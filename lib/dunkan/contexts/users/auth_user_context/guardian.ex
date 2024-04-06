defmodule Dunkan.Contexts.Users.AuthUserContext.Guardian do
  @moduledoc """
   implements behaviour of Guardian - authentication library
   https://hexdocs.pm/guardian/Guardian.html
  """

  use Guardian, otp_app: :dunkan
  alias Dunkan.Contexts.Users.GetUserContext

  def subject_for_token(%{id: id}, _claims) when is_binary(id) do
    {:ok, id}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = GetUserContext.by_id(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :no_subject_provided}
  end
end
