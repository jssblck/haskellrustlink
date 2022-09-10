module Main where

import Ext
import Foreign.C.String (newCString)

main :: IO ()
main = do
  helloWorld
  printString =<< newCString "Hello from Haskell via Rust!\0"
  printString =<< newCString "3 doubled is: \0"
  print (doubleInput 3)
