module Main where

import System.Environment
import System.IO

import Text.Regex

import Lib

main :: IO ()
main = do
  regexList <- getArgs
  processLines (head regexList)

processLines :: String -> IO ()
processLines regex = do
  done <- isEOF
  if done then
    return ()
  else do
    line <- getLine
    processLine regex line
    processLines regex

processLine :: String -> String -> IO ()
processLine r line = do
  let regex = mkRegex r
  let resultMaybe = matchRegex regex line
  case resultMaybe of
    Just _ ->  putStrLn line
    Nothing -> return ()
