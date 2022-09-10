-- This module errors in the language server:
-- "Loading static libraries is not supported in this configuration. Try using a dynamic library instead."
-- but building works and it doesn't actually stop anything from working as far as I can tell...
module Ext (
  doubleInput,
  printString,
  helloWorld,
) where

import Foreign.C.String
import Foreign.C.Types

foreign import ccall "double_input" doubleInput :: CInt -> CInt
foreign import ccall unsafe "print_string" printString :: CString -> IO ()
foreign import ccall unsafe "hello_world" helloWorld :: IO ()
