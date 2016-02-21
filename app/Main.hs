module Main where

import System.Environment (getArgs)
import Lib (processLines, (!!?))

main :: IO ()
main = do
  regexList <- getArgs
  processLines (head regexList) (regexList !!? 1)
