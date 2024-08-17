defmodule Cvme.Users.Create do
  alias Cvme.Users.User
  alias Cvme.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
