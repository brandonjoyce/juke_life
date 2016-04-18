defmodule JukeLife.SelectionControllerTest do
  use JukeLife.ConnCase

  alias JukeLife.Selection
  @valid_attrs %{played: true, url: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, selection_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing selections"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, selection_path(conn, :new)
    assert html_response(conn, 200) =~ "New selection"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, selection_path(conn, :create), selection: @valid_attrs
    assert redirected_to(conn) == selection_path(conn, :index)
    assert Repo.get_by(Selection, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, selection_path(conn, :create), selection: @invalid_attrs
    assert html_response(conn, 200) =~ "New selection"
  end

  test "shows chosen resource", %{conn: conn} do
    selection = Repo.insert! %Selection{}
    conn = get conn, selection_path(conn, :show, selection)
    assert html_response(conn, 200) =~ "Show selection"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, selection_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    selection = Repo.insert! %Selection{}
    conn = get conn, selection_path(conn, :edit, selection)
    assert html_response(conn, 200) =~ "Edit selection"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    selection = Repo.insert! %Selection{}
    conn = put conn, selection_path(conn, :update, selection), selection: @valid_attrs
    assert redirected_to(conn) == selection_path(conn, :show, selection)
    assert Repo.get_by(Selection, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    selection = Repo.insert! %Selection{}
    conn = put conn, selection_path(conn, :update, selection), selection: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit selection"
  end

  test "deletes chosen resource", %{conn: conn} do
    selection = Repo.insert! %Selection{}
    conn = delete conn, selection_path(conn, :delete, selection)
    assert redirected_to(conn) == selection_path(conn, :index)
    refute Repo.get(Selection, selection.id)
  end
end
