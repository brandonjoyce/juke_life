defmodule JukeLife.JukeControllerTest do
  use JukeLife.ConnCase

  alias JukeLife.Juke
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, juke_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing jukes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, juke_path(conn, :new)
    assert html_response(conn, 200) =~ "New juke"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, juke_path(conn, :create), juke: @valid_attrs
    assert redirected_to(conn) == juke_path(conn, :index)
    assert Repo.get_by(Juke, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, juke_path(conn, :create), juke: @invalid_attrs
    assert html_response(conn, 200) =~ "New juke"
  end

  test "shows chosen resource", %{conn: conn} do
    juke = Repo.insert! %Juke{}
    conn = get conn, juke_path(conn, :show, juke)
    assert html_response(conn, 200) =~ "Show juke"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, juke_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    juke = Repo.insert! %Juke{}
    conn = get conn, juke_path(conn, :edit, juke)
    assert html_response(conn, 200) =~ "Edit juke"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    juke = Repo.insert! %Juke{}
    conn = put conn, juke_path(conn, :update, juke), juke: @valid_attrs
    assert redirected_to(conn) == juke_path(conn, :show, juke)
    assert Repo.get_by(Juke, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    juke = Repo.insert! %Juke{}
    conn = put conn, juke_path(conn, :update, juke), juke: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit juke"
  end

  test "deletes chosen resource", %{conn: conn} do
    juke = Repo.insert! %Juke{}
    conn = delete conn, juke_path(conn, :delete, juke)
    assert redirected_to(conn) == juke_path(conn, :index)
    refute Repo.get(Juke, juke.id)
  end
end
