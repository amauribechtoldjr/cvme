defmodule CvmeWeb.UsersJSON do
  def create(%{user: user}), do: %{data: %{user: user}}
  def get(%{user: user}), do: %{data: user}
  def delete(%{user: user}), do: %{data: user}
  def update(%{user: user}), do: %{data: user}
  def user_experiences(%{experiences: experiences}), do: %{data: experiences}
end
