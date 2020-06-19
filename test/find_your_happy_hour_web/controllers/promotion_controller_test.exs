defmodule FindYourHappyHourWeb.PromotionControllerTest do
  use FindYourHappyHourWeb.ConnCase

  alias FindYourHappyHour.Promotions
  alias FindYourHappyHour.Promotions.Promotion

  @create_attrs %{
    description: "some description",
    end_hour: ~T[14:00:00],
    picture: "some picture",
    start_hour: ~T[14:00:00],
    title: "some title",
    week_day: 42
  }
  @update_attrs %{
    description: "some updated description",
    end_hour: ~T[15:01:01],
    picture: "some updated picture",
    start_hour: ~T[15:01:01],
    title: "some updated title",
    week_day: 43
  }
  @invalid_attrs %{description: nil, end_hour: nil, picture: nil, start_hour: nil, title: nil, week_day: nil}

  def fixture(:promotion) do
    {:ok, promotion} = Promotions.create_promotion(@create_attrs)
    promotion
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all promotions", %{conn: conn} do
      conn = get(conn, Routes.promotion_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create promotion" do
    test "renders promotion when data is valid", %{conn: conn} do
      conn = post(conn, Routes.promotion_path(conn, :create), promotion: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.promotion_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "end_hour" => "14:00:00",
               "picture" => "some picture",
               "start_hour" => "14:00:00",
               "title" => "some title",
               "week_day" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.promotion_path(conn, :create), promotion: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promotion" do
    setup [:create_promotion]

    test "renders promotion when data is valid", %{conn: conn, promotion: %Promotion{id: id} = promotion} do
      conn = put(conn, Routes.promotion_path(conn, :update, promotion), promotion: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.promotion_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "end_hour" => "15:01:01",
               "picture" => "some updated picture",
               "start_hour" => "15:01:01",
               "title" => "some updated title",
               "week_day" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, promotion: promotion} do
      conn = put(conn, Routes.promotion_path(conn, :update, promotion), promotion: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promotion" do
    setup [:create_promotion]

    test "deletes chosen promotion", %{conn: conn, promotion: promotion} do
      conn = delete(conn, Routes.promotion_path(conn, :delete, promotion))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.promotion_path(conn, :show, promotion))
      end
    end
  end

  defp create_promotion(_) do
    promotion = fixture(:promotion)
    %{promotion: promotion}
  end
end
