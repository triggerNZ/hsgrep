module Main where

import System.Environment (getArgs)
import System.IO (isEOF)
import Control.Monad (unless)

import Text.Regex (Regex, mkRegex, matchRegex)

main :: IO ()
main = do
  regexList <- getArgs
  processLines (head regexList)

processLines :: String -> IO ()
processLines regex = do
  done <- isEOF
  unless done $
    do
      line <- getLine
      processLine (mkRegex regex) line
      processLines regex

processLine :: Regex -> String -> IO ()
processLine regex line = do
  let resultMaybe = matchRegex regex line
  case resultMaybe of
    Just _ ->  putStrLn line
    Nothing -> return ()
