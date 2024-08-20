defmodule Cvme.Users.GetByEmail do
  alias Cvme.Users.User
  alias Cvme.Repo

  def call(email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :not_found, entity: :user}
    end
  end
end
