open Core

type t =
{
    capital : float;
} 
[@@deriving yojson]

let of_file filename =
    In_channel.read_all filename
    |> Yojson.Safe.from_string 
    |> t_of_yojson
