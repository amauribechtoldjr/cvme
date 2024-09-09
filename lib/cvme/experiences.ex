defmodule Cvme.Experiences do
  alias Cvme.Experiences.Create
  alias Cvme.Experiences.Update
  alias Cvme.Experiences.Delete
  alias Cvme.Experiences.Experiences

  defdelegate create(params), to: Create, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate index(user_id), to: Experiences, as: :call
end
