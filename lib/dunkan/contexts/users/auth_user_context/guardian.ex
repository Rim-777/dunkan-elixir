defmodule Dunkan.Contexts.Users.AuthUserContext.Guardian do
  @moduledoc """
   Implements behaviour of Guardian - authentication library
   https://hexdocs.pm/guardian/Guardian.html

   Implements callbacks for GuardianDB - token tracking library 
   https://hexdocs.pm/guardian_db/Guardian.DB.html
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

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end
end
