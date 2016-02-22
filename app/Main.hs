module Main where

import System.IO (hClose)
import System.Environment (getArgs)
import Lib (processLines, (!!?), openMaybeFile)

main :: IO ()
main = do
  regexList <- getArgs
  handle <- openMaybeFile (regexList !!? 1)
  processLines (head regexList) handle
  hClose handle
