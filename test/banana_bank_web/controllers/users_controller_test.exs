defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase, async: true

  import BananaBank.Factory
  import Mox

  alias BananaBank.ViaCep.ClientBehaviourMock

  setup :verify_on_exit!

  describe "create/2" do
    test "when given a valid params, returns :created", ctx do
      %{"name" => expected_name, "email" => expected_email, "cep" => expected_cep} =
        params = string_params_for(:user)

      expect(ClientBehaviourMock, :call, fn _ -> {:ok, %{}} end)

      response =
        ctx.conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "message" => "User created successfully",
               "data" => %{
                 "id" => _,
                 "name" => ^expected_name,
                 "email" => ^expected_email,
                 "cep" => ^expected_cep
               }
             } = response
    end

    test "when given an invalid params, returns :bad_request", ctx do
      params = %{}

      expect(ClientBehaviourMock, :call, fn _ -> {:ok, %{}} end)

      response =
        ctx.conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "cep" => ["can't be blank"],
          "email" => ["can't be blank"],
          "name" => ["can't be blank"],
          "password" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when given a valid params, returns :ok", ctx do
      user = insert(:user)

      response =
        ctx.conn
        |> authorize(user)
        |> delete(~p"/api/users/#{user.id}")
        |> json_response(:ok)

      expected_response = %{
        "message" => "User deleted successfully",
        "data" => %{
          "id" => user.id,
          "name" => user.name,
          "email" => user.email,
          "cep" => user.cep
        }
      }

      assert response == expected_response
    end

    test "when given an invalid params, returns :not_found", ctx do
      user = insert(:user)
      invalid_user_id = 999

      response =
        ctx.conn
        |> authorize(user)
        |> delete(~p"/api/users/#{invalid_user_id}")
        |> json_response(:not_found)

      expected_response = %{
        "errors" => %{"message" => "Resource not found", "data" => "not_found"}
      }

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when given a valid params, returns :ok", ctx do
      user = insert(:user)

      response =
        ctx.conn
        |> authorize(user)
        |> get(~p"/api/users/#{user.id}")
        |> json_response(:ok)

      expected_response = %{
        "message" => "User shown successfully",
        "data" => %{
          "id" => user.id,
          "name" => user.name,
          "email" => user.email,
          "cep" => user.cep
        }
      }

      assert response == expected_response
    end

    test "when given an invalid params, returns :not_found", ctx do
      user = insert(:user)
      invalid_user_id = 999

      response =
        ctx.conn
        |> authorize(user)
        |> get(~p"/api/users/#{invalid_user_id}")
        |> json_response(:not_found)

      expected_response = %{
        "errors" => %{"message" => "Resource not found", "data" => "not_found"}
      }

      assert response == expected_response
    end
  end

  describe "update/2" do
    test "when given a valid params, returns :ok", ctx do
      user = insert(:user)
      params = %{name: "Raul P"}

      response =
        ctx.conn
        |> authorize(user)
        |> put(~p"/api/users/#{user.id}", params)
        |> json_response(:ok)

      expected_response = %{
        "message" => "User updated successfully",
        "data" => %{
          "id" => user.id,
          "name" => "Raul P",
          "email" => user.email,
          "cep" => user.cep
        }
      }

      assert response == expected_response
    end

    test "when given an invalid params, returns :not_found", ctx do
      user = insert(:user)
      invalid_user_id = 999
      params = %{name: "Raul P"}

      response =
        ctx.conn
        |> authorize(user)
        |> put(~p"/api/users/#{invalid_user_id}", params)
        |> json_response(:not_found)

      expected_response = %{
        "errors" => %{"message" => "Resource not found", "data" => "not_found"}
      }

      assert response == expected_response
    end
  end

  defp authorize(conn, user) do
    put_req_header(conn, "authorization", "Bearer " <> BananaBankWeb.Token.sign(user))
  end
end
