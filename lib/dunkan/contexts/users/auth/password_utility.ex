defmodule Dunkan.Contexts.Users.Auth.PasswordUtility do
  def validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  def hash_password(password) do
    Bcrypt.hash_pwd_salt(password)
  end
end
