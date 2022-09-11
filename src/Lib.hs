module Lib (
  sayHello,
  doubleInput,
  printStdout,
) where

import Extlib qualified

sayHello :: IO ()
sayHello = Extlib.helloWorld

printStdout :: String -> IO ()
printStdout = Extlib.printString

doubleInput :: Int -> Int
doubleInput = Extlib.doubleInput
