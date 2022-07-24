open Format

let file_name n = sprintf "MM_run_v0_1_%d.json" n

let test s =  Str.string_match (Str.regexp "MM_run_v0_1_*[0-9]\\.json") s 0

let copy a = a
let scan s = Scanf.sscanf s "MM_run_v0_1_%d.json" copy

let all_file_names dir =
	Sys.readdir dir 
	|> Array.to_list
	|> List.filter test


let max_run_number dir =
	all_file_names dir
	|> List.map scan
	|> List.fold_left max 0

let new_path dir =
	Filename.concat dir (file_name (1 + (max_run_number dir)))

let last_path dir =
	Filename.concat dir (file_name (max_run_number dir))

