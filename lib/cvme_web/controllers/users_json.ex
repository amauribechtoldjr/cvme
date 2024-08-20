defmodule CvmeWeb.UsersJSON do
  def create(%{user: user, token: token}), do: %{message: "User created with success.", data: render(user, token)}
  def get(%{user: user}), do: %{data: render(user)}
  def delete(%{user: user}), do: %{message: "User deleted with success.", data: render(user)}
  def update(%{user: user}), do: %{message: "User updated with success.", data: render(user)}
  def user_experiences(%{experiences: experiences}), do: %{data: experiences}
  def login(%{token: token}), do: %{message: "User successfully authenticated", token: token}

  defp render(user) do
    %{
      id: user.id,
      email: user.email,
      password_hash: user.password_hash,
    }
  end

  defp render(user, token) do
    %{
      id: user.id,
      email: user.email,
      password_hash: user.password_hash,
      token: token
    }
  end
end
