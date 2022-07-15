type t =
{
    capital : float
} [@@deriving of_yojson]

val of_file : string -> t

