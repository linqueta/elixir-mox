defmodule CorreiosApiBehaviour do
  @callback fetch_zipcode(String.t()) :: {:ok, map()} | {:error, String.t()}
end
