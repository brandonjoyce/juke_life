defmodule JukeLife.JukeChannel do
  use Phoenix.Channel

  def join("jukes:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("jukes:" <> _juke_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
end
