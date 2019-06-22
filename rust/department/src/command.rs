#[derive(Debug)]
pub enum Command<'a> {
    Help,
    Add(&'a str, &'a str),
    ListDepartment(&'a str),
    ListAll,
    Quit
}

pub fn parse_from_string(input: &str) -> Option<Command> {
    let tokens: Vec<&str> = input.split(" ").collect();
    match tokens[0].to_lowercase().as_ref() {
        "add" => build_add(tokens),
        "list_department" => build_list_department(tokens),
        "list" => Some(Command::ListAll),
        "help" => Some(Command::Help),
        "quit" => Some(Command::Quit),
        result => {
            println!("Could not parse: <{}>", result);
            None
        },
    }
}

fn build_add(tokens: Vec<&str>) -> Option<Command> {
    if tokens.len() == 3 {
        Some(Command::Add(tokens[1], tokens[2]))
    } else {
        None
    }
}

fn build_list_department(tokens: Vec<&str>) -> Option<Command> {
    if tokens.len() == 2 {
        Some(Command::ListDepartment("1"))
    } else {
        None
    }
}
