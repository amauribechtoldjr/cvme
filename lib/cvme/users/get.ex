defmodule Cvme.Users.Get do
  alias Cvme.Users.User
  alias Cvme.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
