defmodule Cvme.Users.Update do
  alias Cvme.Users.User
  alias Cvme.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> update(user, params)
    end
  end

  def update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
