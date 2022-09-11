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
