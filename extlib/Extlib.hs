-- This module errors in the language server:
-- "Loading static libraries is not supported in this configuration. Try using a dynamic library instead."
-- but building works and it doesn't actually stop anything from working as far as I can tell...
module Extlib (
  doubleInput,
  printString,
  helloWorld,
) where

import Foreign.C.String (newCString)

import Extlib.Internal qualified as Internal

doubleInput :: Int -> Int
doubleInput = fromIntegral . Internal.doubleInput . fromIntegral

printString :: String -> IO ()
printString s = Internal.printString =<< newCString s

helloWorld :: IO ()
helloWorld = Internal.helloWorld
