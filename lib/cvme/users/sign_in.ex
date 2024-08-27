defmodule Cvme.Users.SignIn do
  alias Cvme.Users
  alias Users.User
  alias Cvme.Repo

  def call(%{"email" => email} = params) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> sign_up(params)
    end
  end

  defp sign_up(params) do
    Users.create(params)
  end
end
