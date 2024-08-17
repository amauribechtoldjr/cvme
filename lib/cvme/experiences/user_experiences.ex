defmodule Cvme.Experiences.UserExperiences do
  import Ecto.Query

  alias Cvme.Experiences.Experience
  alias Cvme.Users.User
  alias Cvme.Repo

  def call(id) do
    user_experiences_query =
      from e in Experience,
      where: e.user_id == 1,
      select: struct(e, [:id, :user_id, :company, :description, :start_date, :end_date])

    case Repo.get(User, id) do
      nil -> {:error, :not_found, entity: :user}
      _user -> Repo.all(user_experiences_query)
    end
  end
end
