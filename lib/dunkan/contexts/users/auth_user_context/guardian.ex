defmodule Dunkan.Contexts.Users.AuthUser.Guardian do
  use Guardian, otp_app: :dunkan
  alias Dunkan.Contexts.Users.GetUser

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = GetUser.by_id(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :no_subject_provided}
  end
end
