defmodule Cvme.Users.VerifyPwd do
  alias Cvme.Users
  alias Users.User
  alias Cvme.Repo

  def call(%{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> verify_password(user, password)
      nil -> {:error, :not_found, entity: :user}
    end
  end

  defp verify_password(user, password) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized, message: "Invalid authentication data"}
    end
  end
end
