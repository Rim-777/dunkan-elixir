defmodule Dunkan.Contexts.Users.AuthUserContext.PasswordUtility do
  @moduledoc """
   The utility for hashing and verifying passwords in Auth Users contexts
  """

  @doc """
  1) Accepts a sting and hashed sting and verified the match
  2) Returns true or false

   ## Examples
    iex> validate_password("password", "$2b$12$Gv./Vm593jfGVuWclPhEo.DI/3acqyX2i5ka.vE7XPW1n8xNOws3.")
    true
    iex> validate_password("password", "in_valid_hashed_password")
    false
  """

  def valid_password?(password, hashed_password) do
    Bcrypt.verify_pass(password, hashed_password)
  end

  @doc """
  1) Accepts a sting
  2) Hashed string

   ## Examples
    iex> hash_password("password")
    "$2b$12$Gv./Vm593jfGVuWclPhEo.DI/3acqyX2i5ka.vE7XPW1n8xNOws3."
  """

  def hash_password(password) do
    Bcrypt.hash_pwd_salt(password)
  end
end
