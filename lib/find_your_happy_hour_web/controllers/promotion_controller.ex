defmodule FindYourHappyHourWeb.PromotionController do
  use FindYourHappyHourWeb, :controller

  alias FindYourHappyHour.Promotions
  alias FindYourHappyHour.Promotions.Promotion

  action_fallback FindYourHappyHourWeb.FallbackController

  def index(conn, _params) do
    promotions = Promotions.list_promotions()
    render(conn, "index.json", promotions: promotions)
  end

  def create(conn, %{"promotion" => promotion_params}) do
    with {:ok, %Promotion{} = promotion} <- Promotions.create_promotion(promotion_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.promotion_path(conn, :show, promotion))
      |> render("show.json", promotion: promotion)
    end
  end

  def show(conn, %{"id" => id}) do
    promotion = Promotions.get_promotion!(id)
    render(conn, "show.json", promotion: promotion)
  end

  def update(conn, %{"id" => id, "promotion" => promotion_params}) do
    promotion = Promotions.get_promotion!(id)

    with {:ok, %Promotion{} = promotion} <- Promotions.update_promotion(promotion, promotion_params) do
      render(conn, "show.json", promotion: promotion)
    end
  end

  def delete(conn, %{"id" => id}) do
    promotion = Promotions.get_promotion!(id)

    with {:ok, %Promotion{}} <- Promotions.delete_promotion(promotion) do
      send_resp(conn, :no_content, "")
    end
  end
end
