defmodule Restfid.Database.Repo do
  use Ecto.Repo, otp_app: :database
  use Scrivener, page_size: 50

  import Ecto.Query, only: [from: 2]

  @batch_size 500

  def batch_size, do: @batch_size

  @doc """
  Returns a stream where each element is a batch of the given `batch_size` of
  the given `query` results.
  """
  def batch_stream(query, batch_size \\ batch_size()) do
    Stream.unfold 0, fn
      :done ->
        nil
      offset ->
        results = all(from(query, offset: ^offset, limit: ^batch_size))

        if length(results) < batch_size do
          {results, :done}
        else
          {results, offset + batch_size}
        end
    end
  end
end
