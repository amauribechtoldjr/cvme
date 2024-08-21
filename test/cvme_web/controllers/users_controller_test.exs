defmodule CvmeWeb.UsersControllerTest do
  use CvmeWeb.ConnCase

  alias Cvme.Users
  alias Users.User

  setup do
    params = %{
      "email" => "usertest@cvme.com",
      "password" => "user-test-password-cvme"
    }

    {:ok, %{user_params: params}}
  end

  describe "create/2" do
    test "user created with success", %{conn: conn, user_params: params} do
      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "email" => "usertest@cvme.com",
                 "id" => _id
               },
               "message" => "User created with success."
             } = response
    end

    test "should not create user with invalid params", %{conn: conn} do
      params = %{
        email: "usertest@cvme.com"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      assert %{
               "errors" => %{
                 "password" => _pass
               }
             } = response
    end
  end

  describe "delete/1" do
    test "user deleted with success", %{conn: conn, user_params: params} do
      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}", params)
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "email" => "usertest@cvme.com",
                 "id" => ^id
               },
               "message" => "User deleted with success."
             } = response
    end
  end
end
