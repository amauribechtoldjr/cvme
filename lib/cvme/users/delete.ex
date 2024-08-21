defmodule Cvme.Users.Delete do
  alias Cvme.Users.User
  alias Cvme.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> Repo.delete(user)
    end
  end
end
