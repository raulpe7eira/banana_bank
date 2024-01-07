defmodule BananaBank.Factory do
  use ExMachina.Ecto, repo: BananaBank.Repo

  use BananaBank.UserFactory
end
