defmodule Cvme.Users do
  alias Cvme.Users.Create
  alias Cvme.Users.Get
  alias Cvme.Users.Update
  alias Cvme.Users.Delete
  alias Cvme.Users.VerifyPwd

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate verify_pwd(params), to: VerifyPwd, as: :call
end
