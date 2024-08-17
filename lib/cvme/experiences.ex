defmodule Cvme.Experiences do
  alias Cvme.Experiences.Create
  # alias Cvme.Experiences.Get
  alias Cvme.Experiences.Update
  # alias Cvme.Experiences.Delete

  defdelegate create(params), to: Create, as: :call
  # defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  # defdelegate delete(id), to: Delete, as: :call
end
