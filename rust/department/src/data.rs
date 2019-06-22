use std::collections::{HashMap, HashSet};
use std::io::ErrorKind;
use crate::command::Command;

#[derive(Debug)]
pub struct Company {
    departments: HashMap<String, Department>,
}

impl Company {
    pub fn handle_command(&mut self, command: Command) -> Result<(), ErrorKind> {
        match command {
            Command::Add(person, department) => {
                self.add_person(String::from(person), department)
            },
            Command::ListDepartment(department) => {
                self.print_department(department);
                Ok(())
            },
            Command::ListAll => {
                for (department_name, _department) in self.departments.iter() {
                    self.print_department(department_name);
                }
                Ok(())
            },
            _ => {
                Err(ErrorKind::NotFound)
            }
        }
    }

    fn print_department(&self, department_name: &str) {
        match self.departments.get(department_name) {
            Some(department) => {
                println!("Department of {}: \n{}\n\nMembers:", department.name, department.description);
                for person in department.people.iter() {
                    println!(" - {}", person);
                }

            }
            None => {
                println!("Department of {} does not exist!", department_name);
            }
        }
    }

    fn add_department(&mut self, name: String, department: Department) {
        self.departments.insert(name, department);
    }

    fn add_person(&mut self, person: String, department_name: &str) -> Result<(), ErrorKind> {
        match self.departments.get_mut(department_name) {
            Some(department) => {
                department.add_person_to_department(person);
                Ok(())
            },
            None => {
                println!("Can not add some to nonexistent department: {}", department_name);
                Err(ErrorKind::NotFound)
            }
        }
    }
}

#[derive(Debug)]
struct Department {
    name: String,
    description: String,
    people: HashSet<String>,
}

impl Department {
    fn add_person_to_department(&mut self, person: String) {
        self.people.insert(person);
    }
}

pub fn initialize() -> Company {
    let mut c = Company {
        departments: HashMap::new(),
    };
    c.add_department(
        String::from("Founders"),
        Department {
            name: String::from("Founders"),
            description: String::from("The people who founded the company"),
            people: HashSet::new()
        },
    );
    c
}
