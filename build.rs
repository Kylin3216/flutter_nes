use std::process::Command;

fn main() {
    println!("cargo:rerun-if-changed=src/api.rs");
    run_bridge_codegen();
    run_flutter_build_runner();
}

fn run_bridge_codegen() {
    let mut command = Command::new("flutter_rust_bridge_codegen");
    command.args(["-r", "--rust-input", "src/api.rs"]);
    command.args(["-d", "--dart-output", "lib/src/bridge.dart"]);
    command.args(["-c", "--rust-output", "src/bridge.rs"]);
    command.args(["-c", "--c-output", "ios/Classes/bridge.h"]);
    command.args(["-c", "--c-output", "macos/Classes/bridge.h"]);
    command.status().unwrap();
}

fn run_flutter_build_runner() {
    let mut command = Command::new("flutter");
    command.args(["pub", "run", "build_runner", "build"]);
    command.status().unwrap();
}
