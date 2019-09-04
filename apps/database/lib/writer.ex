defmodule Restfid.Database.Writer do
  @moduledoc """
  A behaviour module for implementing a writer for a restfid resource.

  A writer is the responsible to handle all writing action in any resource, as
  well as the authorization to do it or not. That's why nothing should be
  written in restfid without a writer.

  ## Example

  The Writer behaviour abstracts the common actions like insert, update and
  delete. You only need to implement the callbacks you are interested in.

  Let's start with an example of a debug log on the resource insertion:

      defmodule Restfid.Database.ResWriter do
        use Restfid.Database.Writer, schema: Restfid.Database.MyResource

        def insert(params) do
          IO.inspect(params)
          super(params)
        end
      end

  For a more detailed list of callbacks you can override see the documented
  callbacks on this behaviour module.
  """

  @doc """
  Returns a changeset for the given action to be executed in the given struct
  putting the params as the changes. This can be useful if you need to add
  custom validations for given actions.
  """
  @callback changeset(struct, map, atom) :: Ecto.Changeset.t

  @doc """
  Inserts a resource with the given params. It uses `changeset/3` to build a
  proper changeset for inserting.

  It must return {:ok, struct} if no error happened, and {:error, changeset}
  otherwise.
  """
  @callback insert(map) :: {:ok, struct} | {:error, Ecto.Changeset.t}

  @doc """
  Updates a resource with the given params. It uses `changeset/3` to build a
  proper changeset for updating.

  It must return {:ok, struct} if no error happened, and {:error, changeset}
  otherwise.
  """
  @callback update(struct, map) :: {:ok, struct} | {:error, Ecto.Changeset.t}

  @doc """
  Deletes a resource with the given params. It uses `changeset/3` to build a
  proper changeset for deleting.

  It must return {:ok, struct} if no error happened, and {:error, changeset}
  otherwise.
  """
  @callback delete(struct) :: {:ok, struct} | {:error, Ecto.Changeset.t}

  defmacro __using__(opts) do
    quote do
      @behaviour Restfid.Database.Writer

      alias Restfid.Database.Repo
      alias Restfid.Database.{Auth, User}

      import Ecto.Changeset, except: [validate_length: 3]
      import Restfid.Database.FieldLengthValidator

      def schema do
        unquote(opts[:schema])
      end

      def schema_struct do
        %unquote(opts[:schema]){}
      end

      def insert(params) do
        params
        |> form_data(:insert)
        |> Repo.insert
      end

      def insert!(params) do
        case insert(params) do
          {:ok, struct} -> struct
          {:error, cs} ->
            raise Ecto.InvalidChangesetError, action: :insert, changeset: cs
        end
      end

      def update(struct, params) do
        struct
        |> form_data(params, :update)
        |> Repo.update
      end

      def update!(struct, params) do
        case update(struct, params) do
          {:ok, struct} -> struct
          {:error, cs} ->
            raise Ecto.InvalidChangesetError, action: :update, changeset: cs
        end
      end

      def delete(struct) do
        struct
        |> form_data(:delete)
        |> Repo.delete
      end

      def delete!(struct) do
        case delete(struct) do
          {:ok, struct} -> struct
          {:error, cs} ->
            raise Ecto.InvalidChangesetError, action: :delete, changeset: cs
        end
      end

      def form_data(action), do: form_data(schema_struct(), %{}, action)
      def form_data(%{__struct__: _} = struct, action) do
        form_data(struct, %{}, action)
      end
      def form_data(params, action) do
        form_data(schema_struct(), params, action)
      end
      def form_data(struct, params, action) do
        struct
        |> changeset(params, action)
      end

      def changeset(action), do: changeset(schema_struct(), %{}, action)
      def changeset(%{__struct__: _} = struct, action) do
        changeset(struct, %{}, action)
      end
      def changeset(params, action) do
        changeset(schema_struct(), params, action)
      end
      def changeset(struct, params, action) do
        schema().changeset(struct, params)
      end
    end
  end
end
