defmodule FindYourHappyHourWeb.UserView do
  use FindYourHappyHourWeb, :view
  alias FindYourHappyHourWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      encrypted_password: user.encrypted_password}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{token: jwt}
  end
end
