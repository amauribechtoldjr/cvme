defmodule CvmeWeb.UsersJSON do
  def create(%{user: user}), do: %{message: "User created with success.", data: user}
  def get(%{user: user}), do: %{data: user}
  def delete(%{user: user}), do: %{message: "User deleted with success.", data: user}
  def update(%{user: user}), do: %{message: "User updated with success.", data: user}
end
