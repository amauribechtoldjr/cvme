defmodule Cvme.Users do
  alias Cvme.Users.Create
  alias Cvme.Users.Get
  alias Cvme.Users.Update
  alias Cvme.Users.Delete
  alias Cvme.Users.GetByEmail
  alias Cvme.Users.Verify

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate get_by_email(email), to: GetByEmail, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate login(params), to: Verify, as: :call
end
