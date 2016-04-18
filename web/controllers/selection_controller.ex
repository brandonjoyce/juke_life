defmodule JukeLife.SelectionController do
  use JukeLife.Web, :controller

  alias JukeLife.Selection

  plug :scrub_params, "selection" when action in [:create, :update]

  def index(conn, _params) do
    selections = Repo.all(Selection)
    render(conn, "index.html", selections: selections)
  end

  def new(conn, _params) do
    changeset = Selection.changeset(%Selection{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"selection" => selection_params}) do
    changeset = Selection.changeset(%Selection{}, selection_params)

    case Repo.insert(changeset) do
      {:ok, _selection} ->
        conn
        |> put_flash(:info, "Selection created successfully.")
        |> redirect(to: selection_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    selection = Repo.get!(Selection, id)
    render(conn, "show.html", selection: selection)
  end

  def edit(conn, %{"id" => id}) do
    selection = Repo.get!(Selection, id)
    changeset = Selection.changeset(selection)
    render(conn, "edit.html", selection: selection, changeset: changeset)
  end

  def update(conn, %{"id" => id, "selection" => selection_params}) do
    selection = Repo.get!(Selection, id)
    changeset = Selection.changeset(selection, selection_params)

    case Repo.update(changeset) do
      {:ok, selection} ->
        conn
        |> put_flash(:info, "Selection updated successfully.")
        |> redirect(to: selection_path(conn, :show, selection))
      {:error, changeset} ->
        render(conn, "edit.html", selection: selection, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    selection = Repo.get!(Selection, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(selection)

    conn
    |> put_flash(:info, "Selection deleted successfully.")
    |> redirect(to: selection_path(conn, :index))
  end
end
