module Main (main) where

import Lib qualified

main :: IO ()
main = do
  putStrLn "Hello, Haskell"
  Lib.sayHello
  Lib.printStdout "Hello through Rust"
  Lib.printStdout . ("3 doubled is: " <>) . show $ Lib.doubleInput 3
