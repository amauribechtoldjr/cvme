defmodule Cvme.Users.Delete do
  alias Cvme.Users.User
  alias Cvme.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user ->
        user
        |> Ecto.Changeset.change
        |> Ecto.Changeset.no_assoc_constraint(:experiences)
        |> Repo.delete()
    end
  end
end
