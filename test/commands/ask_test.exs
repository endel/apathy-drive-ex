defmodule Commands.AskTest do
  use ExUnit.Case
  use ShouldI
  import ApathyDrive.Matchers

  with "a spirit" do
    setup context do
      Dict.put(context, :spirit, %Spirit{socket: %Phoenix.Socket{transport_pid: self, joined: true}})
    end

    should_add_to_scroll "<p>You need a body to do that.</p>" do
      Commands.Ask.execute(context.spirit, [])
    end
  end

end
