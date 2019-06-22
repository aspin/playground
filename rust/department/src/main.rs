mod cli;
mod data;
mod command;

fn main() {
    let mut company = data::initialize();
    cli::welcome_user();
    cli::interact_loop(&mut |cmd| company.handle_command(cmd));
}
