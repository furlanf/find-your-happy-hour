defmodule FindYourHappyHour.PromotionsTest do
  use FindYourHappyHour.DataCase

  alias FindYourHappyHour.Promotions

  describe "promotions" do
    alias FindYourHappyHour.Promotions.Promotion

    @valid_attrs %{description: "some description", end_hour: ~T[14:00:00], picture: "some picture", start_hour: ~T[14:00:00], title: "some title", week_day: 42}
    @update_attrs %{description: "some updated description", end_hour: ~T[15:01:01], picture: "some updated picture", start_hour: ~T[15:01:01], title: "some updated title", week_day: 43}
    @invalid_attrs %{description: nil, end_hour: nil, picture: nil, start_hour: nil, title: nil, week_day: nil}

    def promotion_fixture(attrs \\ %{}) do
      {:ok, promotion} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Promotions.create_promotion()

      promotion
    end

    test "list_promotions/0 returns all promotions" do
      promotion = promotion_fixture()
      assert Promotions.list_promotions() == [promotion]
    end

    test "get_promotion!/1 returns the promotion with given id" do
      promotion = promotion_fixture()
      assert Promotions.get_promotion!(promotion.id) == promotion
    end

    test "create_promotion/1 with valid data creates a promotion" do
      assert {:ok, %Promotion{} = promotion} = Promotions.create_promotion(@valid_attrs)
      assert promotion.description == "some description"
      assert promotion.end_hour == ~T[14:00:00]
      assert promotion.picture == "some picture"
      assert promotion.start_hour == ~T[14:00:00]
      assert promotion.title == "some title"
      assert promotion.week_day == 42
    end

    test "create_promotion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Promotions.create_promotion(@invalid_attrs)
    end

    test "update_promotion/2 with valid data updates the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{} = promotion} = Promotions.update_promotion(promotion, @update_attrs)
      assert promotion.description == "some updated description"
      assert promotion.end_hour == ~T[15:01:01]
      assert promotion.picture == "some updated picture"
      assert promotion.start_hour == ~T[15:01:01]
      assert promotion.title == "some updated title"
      assert promotion.week_day == 43
    end

    test "update_promotion/2 with invalid data returns error changeset" do
      promotion = promotion_fixture()
      assert {:error, %Ecto.Changeset{}} = Promotions.update_promotion(promotion, @invalid_attrs)
      assert promotion == Promotions.get_promotion!(promotion.id)
    end

    test "delete_promotion/1 deletes the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{}} = Promotions.delete_promotion(promotion)
      assert_raise Ecto.NoResultsError, fn -> Promotions.get_promotion!(promotion.id) end
    end

    test "change_promotion/1 returns a promotion changeset" do
      promotion = promotion_fixture()
      assert %Ecto.Changeset{} = Promotions.change_promotion(promotion)
    end
  end
end
