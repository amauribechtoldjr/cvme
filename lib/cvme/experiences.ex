defmodule Cvme.Experiences do
  alias Cvme.Experiences.Create
  alias Cvme.Experiences.Update
  alias Cvme.Experiences.Delete
  alias Cvme.Experiences.UserExperiences

  defdelegate create(params), to: Create, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate user_experiences(user_id), to: UserExperiences, as: :call
end
