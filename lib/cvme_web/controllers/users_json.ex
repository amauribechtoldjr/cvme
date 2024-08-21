defmodule CvmeWeb.UsersJSON do
  def create(%{user: user, token: token}), do: %{data: render(user, token)}
  def get(%{user: user}), do: %{data: render(user)}
  def delete(%{user: user}), do: %{data: render(user)}
  def update(%{user: user}), do: %{data: render(user)}
  def user_experiences(%{experiences: experiences}), do: %{data: experiences}
  def sign_in(%{token: token}), do: %{data: %{token: token}}

  defp render(user) do
    %{
      id: user.id,
      email: user.email,
      password_hash: user.password_hash
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
