
(* type mortgage =
{
	term : int;
	amortization : int;
	interest : float;
}
 *)
type parameters =
{
	years : int;
	runs : int;
	context : Context_data.t;
	project : Project_data.t;
}
[@@deriving yojson]

type model =
{
	parameters : parameters;
	periods : int;
(* 	inflation : float;
	mortgage : mortgage;
 *)
 }
[@@deriving yojson]


let run runs years context project =
	let parameters = 
	{
		years = years;
		runs = runs;
		context = context;
		project = project;
	} 
	in 
	{
		parameters = parameters;
		periods = years * 12;
	}
	
let output path model =
	let out = open_out_bin path in
	output_string out (Yojson.Safe.to_string (yojson_of_model model));
	close_out out
