defmodule JukeLife.JukeController do
  use JukeLife.Web, :controller

  alias JukeLife.Juke

  plug :scrub_params, "juke" when action in [:create, :update]

  def index(conn, _params) do
    jukes = Repo.all(Juke)
    render(conn, "index.html", jukes: jukes)
  end

  def new(conn, _params) do
    changeset = Juke.changeset(%Juke{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"juke" => juke_params}) do
    changeset = Juke.changeset(%Juke{}, juke_params)

    case Repo.insert(changeset) do
      {:ok, _juke} ->
        conn
        |> put_flash(:info, "Juke created successfully.")
        |> redirect(to: juke_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    juke = Repo.get!(Juke, id)
    render(conn, "show.html", juke: juke)
  end

  def edit(conn, %{"id" => id}) do
    juke = Repo.get!(Juke, id)
    changeset = Juke.changeset(juke)
    render(conn, "edit.html", juke: juke, changeset: changeset)
  end

  def update(conn, %{"id" => id, "juke" => juke_params}) do
    juke = Repo.get!(Juke, id)
    changeset = Juke.changeset(juke, juke_params)

    case Repo.update(changeset) do
      {:ok, juke} ->
        conn
        |> put_flash(:info, "Juke updated successfully.")
        |> redirect(to: juke_path(conn, :show, juke))
      {:error, changeset} ->
        render(conn, "edit.html", juke: juke, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    juke = Repo.get!(Juke, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(juke)

    conn
    |> put_flash(:info, "Juke deleted successfully.")
    |> redirect(to: juke_path(conn, :index))
  end
end
