defmodule FindYourHappyHourWeb.PromotionView do
  use FindYourHappyHourWeb, :view
  alias FindYourHappyHourWeb.PromotionView

  def render("index.json", %{promotions: promotions}) do
    %{data: render_many(promotions, PromotionView, "promotion.json")}
  end

  def render("show.json", %{promotion: promotion}) do
    %{data: render_one(promotion, PromotionView, "promotion.json")}
  end

  def render("promotion.json", %{promotion: promotion}) do
    %{id: promotion.id,
      title: promotion.title,
      description: promotion.description,
      week_day: promotion.week_day,
      start_hour: promotion.start_hour,
      end_hour: promotion.end_hour,
      picture: promotion.picture}
  end
end
