defmodule Cvme.Users.Verify do
  alias Cvme.Users

  def call(%{"email" => email, "password" => password}) do
    IO.inspect("CHEGOU AQUI")
    case Users.get_by_email(email) do
      {:ok, user} -> verify(password, user)
      _error -> {:error, :unauthorized}
    end
  end

  defp verify(password, user) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end
end
