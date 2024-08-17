defmodule Cvme.Experiences.Delete do
  alias Cvme.Experiences.Experience
  alias Cvme.Repo

  def call(id) do
    case Repo.get(Experience, id) do
      nil -> {:error, :not_found, entity: :experience}
      experience -> Repo.delete(experience)
    end
  end
end
