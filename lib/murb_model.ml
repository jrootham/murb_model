open Format

let command () = 

    let usage_msg = "model -y years -r runs -c context.json -p project.json -o output.csv" in

    let years = ref 25 in
    let runs = ref 10 in
    let context_file = ref "" in
    let project_file = ref "" in
    let output_file = ref "" in

    let tmp = ref "" in
    let anon_fun bad = tmp := bad  in

    let validate years runs context project output do_not =
        years > 0 && years <= 100
        && runs > 0 && runs <= 1000
        && context <> ""
        && project <> ""
        && output <> ""
        && do_not = ""
    in

    let speclist =
      [
        ("-y", Arg.Set_int years, "Number of years");
        ("-r", Arg.Set_int runs, "Number of runs");
        ("-c", Arg.Set_string context_file, "Context file name");
        ("-p", Arg.Set_string project_file, "Project file name");
        ("-o", Arg.Set_string output_file, "Output file name");
      ]
    in

    let () = Arg.parse speclist anon_fun usage_msg in

    if validate !years !runs !context_file !project_file !output_file !tmp 
    then
        let project = Project.of_file !project_file in
        printf "Years=%d runs=%d Context=%s capital=%f output=%s\n" !years !runs !context_file project.capital !output_file
    else
        Arg.usage speclist usage_msg




