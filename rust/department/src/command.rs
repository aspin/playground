#[derive(Debug, PartialEq)]
pub enum Command<'a> {
    Help,
    Add(&'a str, &'a str),
    AddDepartment(&'a str),
    ListDepartment(&'a str),
    ListAll,
    Quit
}

pub fn parse_from_string(input: &str) -> Option<Command> {
    let tokens: Vec<&str> = input.split(" ").collect();
    match tokens[0].to_lowercase().as_ref() {
        "add" => build_add(tokens),
        "add_department" => build_add_department(tokens),
        "list_department" => build_list_department(tokens),
        "list" => Some(Command::ListAll),
        "help" => Some(Command::Help),
        "quit" | "exit" => Some(Command::Quit),
        _ => None,
    }
}

fn build_add(tokens: Vec<&str>) -> Option<Command> {
    if tokens.len() == 3 {
        Some(Command::Add(tokens[1], tokens[2]))
    } else {
        None
    }
}

fn build_add_department(tokens: Vec<&str>) -> Option<Command> {
    if tokens.len() == 2 {
        Some(Command::AddDepartment(tokens[1]))
    } else {
        None
    }
}

fn build_list_department(tokens: Vec<&str>) -> Option<Command> {
    if tokens.len() == 2 {
        Some(Command::ListDepartment(tokens[1]))
    } else {
        None
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_build_add() {
        assert_eq!(build_add(vec!["add", "foo", "department"]), Some(Command::Add("foo", "department")));
        assert_eq!(build_add(vec!["add", "kevin", "computer science"]), Some(Command::Add("kevin", "computer science")));
        assert!(build_add(vec!["add", "kevin"]).is_none());
    }

    #[test]
    fn test_build_add_department() {
        assert_eq!(build_add_department(vec!["add_department", "computer science"]), Some(Command::AddDepartment("computer science")));
        assert!(build_add_department(vec!["add_department", "computer science", "extra"]).is_none());
    }
}
