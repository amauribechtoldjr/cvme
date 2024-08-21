defmodule CvmeWeb.UsersJSON do
  def create(%{user: user, token: token}), do: %{data: %{user: user, token: token}}
  def get(%{user: user}), do: %{data: user}
  def delete(%{user: user}), do: %{data: user}
  def update(%{user: user}), do: %{data: user}
  def user_experiences(%{experiences: experiences}), do: %{data: experiences}
  def sign_in(%{token: token}), do: %{data: %{token: token}}
end
