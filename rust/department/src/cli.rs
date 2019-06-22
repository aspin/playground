use crate::command;
use crate::command::Command;
use std::io::{self, ErrorKind, Write};

pub fn welcome_user() {
    println!(
        "
------------------------------------------------------------

 Welcome to the Kevin Tech's department management interface.

 Type HELP for a list of commands.

------------------------------------------------------------

 "
    );
}

pub fn interact_loop(component_handler: &mut impl FnMut(Command) -> Result<(), ErrorKind>) {
    loop {
        print!(">> ");
        io::stdout()
            .flush()
            .expect("Failed to flush command prompt");

        let mut input = String::new();
        io::stdin()
            .read_line(&mut input)
            .expect("Failed to read line");

        match command::parse_from_string(input.trim()) {
            Some(cmd) => match root_handler(cmd, component_handler) {
                Ok(_) => (),
                Err(ErrorKind::Interrupted) => break,
                // Err(error) => println!("Could not execute command {}, because: {}", input, error.)
                Err(_error) => println!("Could not execute command \"{}\", because: <reason>", input.trim()),
            },
            None => println!("Could not parse provided command: {}", input.trim()),
        }
    }
}

pub fn root_handler(
    cmd: Command,
    component_handler: &mut impl FnMut(Command) -> Result<(), ErrorKind>,
) -> Result<(), ErrorKind> {
    match cmd {
        Command::Help => {
            println!(
                "
Available commands: 
    - add <person> <department_name>: adds an employee to the department
    - list: list all department
    - list_department <departnment_name>: lists details of single department
    - quit: exit thee program
            "
            );
            Ok(())
        }
        Command::Quit => Err(ErrorKind::Interrupted),
        other => component_handler(other),
    }
}
