defmodule ApathyDrive.Exits.Alignment do
  use ApathyDrive.Exit

  def move(%Room{} = room, %Spirit{} = spirit, room_exit),  do: super(room, spirit, room_exit)

  def move(%Room{} = room, %Monster{alignment: "good"} = monster, %{"min" => _min}) do
    Monster.send_scroll(monster, "<p>You are not evil enough to use this exit.</p>")
  end

  def move(%Room{} = room, %Monster{alignment: "evil"} = monster, %{"max" => _max}) do
    Monster.send_scroll(monster, "<p>You are too evil to use this exit.</p>")
  end

  def move(%Room{} = room, %Monster{} = monster, room_exit), do: super(room, monster, room_exit)
end