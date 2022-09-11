use std::ffi::CStr;
use std::os::raw::c_char;

/// The classical omen of great beginnings.
#[no_mangle]
pub extern "C" fn hello_world() {
    println!("Hello from Rust!");
}

/// Shamelessly stolen from https://blog.mgattozzi.dev/haskell-rust/
#[no_mangle]
pub extern "C" fn double_input(x: i32) -> i32 {
    2 * x
}

/// Shamelessly stolen from https://blog.mgattozzi.dev/haskell-rust/ with modifications.
///
/// # Safety
///
/// Null pointer? Much UB 👻
#[no_mangle]
pub unsafe extern "C" fn print_string(x: *const c_char) {
    let cstring = CStr::from_ptr(x);
    if let Ok(input) = cstring.to_str() {
        println!("{}", input);
    } else {
        panic!("Unable to print input");
    }
}
