(* open Printf *)

let command () = 

    let usage_msg = "model -d runs_directory -y years -r runs -c context.json -p project.json" in

    let validate directory years runs context project do_not =
        directory <> ""
        && years > 0 && years <= 100
        && runs > 0 && runs <= 1000
        && context <> ""
        && project <> ""
        && do_not = ""
    in

    let years = ref 25 in
    let runs = ref 10 in
    let directory = ref "" in
    let context_file = ref "" in
    let project_file = ref "" in

    let tmp = ref "" in
    let anon_fun bad = tmp := bad  in

    let speclist =
      [
        ("-d", Arg.Set_string directory, "Runs directory");
        ("-y", Arg.Set_int years, "Number of years");
        ("-r", Arg.Set_int runs, "Number of runs");
        ("-c", Arg.Set_string context_file, "Context file name");
        ("-p", Arg.Set_string project_file, "Project file name");
      ]
    in

    let () = Arg.parse speclist anon_fun usage_msg in

    if validate !directory !years !runs !context_file !project_file !tmp 
    then
        let context = Context_data.of_file !context_file in
        let project = Project_data.of_file !project_file in

        let model = Model.run !runs !years context project in 
        let path =  File_names.new_path !directory in
        Model.output path model 
    else
        Arg.usage speclist usage_msg




