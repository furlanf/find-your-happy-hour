defmodule FindYourHappyHour.AccountsTest do
  use FindYourHappyHour.DataCase

  alias FindYourHappyHour.Accounts

  describe "users" do
    alias FindYourHappyHour.Accounts.User

    @valid_attrs %{email: "some.email@mail", password: "some password", password_confirmation: "some password", name: "some name"}
    @update_attrs %{email: "some.updated@mail", password: "some updated password",  password_confirmation: "some updated password", name: "some updated name"}
    @invalid_attrs %{email: nil, password: nil, name: nil}

    def user_fixture() do
      {:ok, user} = Accounts.create_user(@valid_attrs)

      user
    end

    test "list_users/0 returns all users" do
      _ = user_fixture()
      users = Accounts.list_users()

      assert length(users) == 1
    end

    test "get_user!/1 returns the user with given id" do
      user_fixtured = user_fixture()
      user = Accounts.get_user!(user_fixtured.id)

      assert user.email == "some.email@mail"
      assert user.name == "some name"
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
    
      assert user.email == "some.email@mail"
      assert user.password == "some password"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some.updated@mail"
      assert user.password == "some updated password"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user_fixtured = user_fixture()

      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user_fixtured, @invalid_attrs)
      user = Accounts.get_user!(user_fixtured.id)
      assert user.email == "some.email@mail"
      assert user.name == "some name"
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
