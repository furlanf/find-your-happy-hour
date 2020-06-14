defmodule FindYourHappyHourWeb.UserControllerTest do
  use FindYourHappyHourWeb.ConnCase

  alias FindYourHappyHour.Accounts
  alias FindYourHappyHour.Accounts.User
  alias FindYourHappyHour.Accounts.Encryption

  @create_attrs %{
    email: "some.email@mail",
    encrypted_password: "some encrypted_password",
    password: "some encrypted_password",
    password_confirmation: "some encrypted_password",
    name: "some name"
  }
  @update_attrs %{
    email: "some.updated@mail",
    password: "some updated encrypted_password",
    password_confirmation: "some updated encrypted_password",
    name: "some updated name"
  }
  @invalid_attrs %{email: nil, encrypted_password: nil, name: nil}


  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      _encrypted_password = Encryption.hash_password("some encrypted_password")

      assert %{
               "id" => id,
               "email" => "some.email@mail",
               "encrypted_password" => _encrypted_password,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      _encrypted_password = Encryption.hash_password("some updated encrypted_password")
      
      assert %{
               "id" => id,
               "email" => "some.updated@mail",
               "encrypted_password" => _encrypted_password,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
