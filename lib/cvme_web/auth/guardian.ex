defmodule CvmeWeb.Auth.Guardian do
  use Guardian, otp_app: :cvme

  alias Cvme.Users

  def subject_for_token(%{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Users.get(id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end


  def authenticate(email, password) do
    case Users.verify_pwd(%{"email" => email, "password" => password}) do
      {:error, :unauthorized, message: message} -> {:error, :unauthorized, message: message}
      {:ok, user} -> create_token(user)
    end
  end

  def validate_pwd(pwd, pwd_hash) do
    Argon2.verify_pass(pwd, pwd_hash)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, token, user}
  end
end
