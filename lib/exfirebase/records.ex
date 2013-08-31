defmodule ExFirebase.Records do
  @moduledoc """
  Provides Elixir's record-based operation for Firebase
  """
  alias ExFirebase.HTTP

  @doc """
  Get records from the specified path. The record_type indicates the record type.
  """
  def get(path // "", record_type) when is_atom(record_type) do
    record_tuples = ExFirebase.send_request(path, &HTTP.get/1)
    from_tuples(record_tuples, record_type)
  end

  @doc """
  Push records to the specified path.
  """
  def push(path // "", record_list) do
    tuples = to_tuples(record_list)
    ExFirebase.send_request(path, &HTTP.put/2, tuples)
  end

  @doc "convert from tuple list to record list"
  def from_tuples(tuples, record_type) do
    Enum.map(tuples, fn(tuple) -> from_tuple(tuple, record_type) end)
  end

  @doc "convert from record list to tuple list"
  def to_tuples(record_list) do
    Enum.map(record_list, fn(record) -> to_tuple(record) end)
  end

  defp from_tuple(tuple, record_type) do
    keywords = Enum.map(tuple, fn({a, b}) -> {binary_to_atom(a), b} end)
    record_type.new(keywords)
  end

  defp to_tuple(record) do
    keywords = record.to_keywords
    Enum.map(keywords, fn({a, b}) -> {atom_to_binary(a), b} end)
  end
end