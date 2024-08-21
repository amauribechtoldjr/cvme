defmodule Cvme.Users.VerifyPwd do
  alias Cvme.Users

  def call(%{"email" => email, "password" => password}) do
    with {:ok, user} <- get_by_email(email),
         {:ok, :authorized} <- verify_pass(password, user.password_hash) do
      {:ok, user}
    end
  end

  def get_by_email(email) do
    case Users.get_by_email(email) do
      {:error, :not_found} -> {:error, :unauthorized}
      result -> result
    end
  end

  def verify_pass(pwd, pwd_hash) do
    case Argon2.verify_pass(pwd, pwd_hash) do
      true -> {:ok, :authorized}
      _ -> {:error, :unauthorized}
    end
  end
end
