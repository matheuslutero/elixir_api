defmodule Restfid.Database.Reader do
  @moduledoc """
  This module is the base module for all the readers on Restfid.Database. A reader is
  the responsible to handle all reading action in any resource, as well as the
  authorization to do it or not. That's why nothing should be red in restfid
  without a reader.

  To implement a reader to a resource you can just:

      use Restfid.Database.Reader, schema: Restfid.Database.MyResource

  ## IMPORTANT

  Don't forget to call super in all the methods you override! It's very
  important so if the default implementation changes, it will spread to your
  writers.
  """

  defmacro __using__(opts) do
    opts = Keyword.merge([repo: Restfid.Database.Repo], opts)

    quote do
      alias Restfid.Database.Repo
      alias Restfid.Database.User

      import Ecto.Query

      def scope() do
        unquote(opts[:schema])
      end

      def all(queryable \\ scope()) do
        queryable
        |> unquote(opts[:repo]).all
      end

      def one(queryable \\ scope()) do
        queryable
        |> unquote(opts[:repo]).one
      end

      def get(queryable \\ scope(), id) do
        queryable
        |> where([x], x.id == ^id)
        |> unquote(opts[:repo]).one
      end

      def get!(queryable \\ scope(), id) do
        if struct = get(queryable, id) do
          struct
        else
          raise Ecto.NoResultsError, queryable: queryable
        end
      end

      def get_by(queryable \\ scope(), clauses) do
        queryable
        |> where([], ^Enum.to_list(clauses))
        |> unquote(opts[:repo]).one
      end

      def get_by!(queryable \\ scope(), by) do
        if struct = get_by(queryable, by) do
          struct
        else
          raise Ecto.NoResultsError, queryable: queryable
        end
      end

      def order(query \\ scope(), args) do
        from query, order_by: ^args
      end

      def count(queryable \\ scope()) do
        q in queryable
        |> from(select: count(q.id))
        |> unquote(opts[:repo]).one
      end

      def for_select(query \\ scope(), field) do
        from(x in query,
             select: {field(x, ^field), x.id},
             order_by: field(x, ^field))
      end
    end
  end
end
