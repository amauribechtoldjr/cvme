defmodule Cvme.Experiences.Create do
  alias Cvme.Experiences.Experience
  alias Cvme.Users
  alias Cvme.Repo

  def call(%{"user_id" => user_id} = params) do
    with {:ok, _user} <- Users.get(user_id) do
      params
      |> Experience.changeset()
      |> Repo.insert()
    end
  end
end
