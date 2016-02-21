module Lib where

import System.IO (isEOF,
                  openFile,
                  IOMode(ReadMode),
                  stdin,
                  hIsEOF,
                  hGetLine,
                  hClose)
import Control.Monad (unless)

import Text.Regex (Regex, mkRegex, matchRegex)

processLines :: String -> Maybe String -> IO ()
processLines regex maybePath = do
  handle <- case maybePath of
    Just filename -> openFile filename ReadMode
    Nothing -> return stdin
  done <- hIsEOF handle
  if done then
    hClose handle
  else
    do
      line <- hGetLine handle
      processLine (mkRegex regex) line
      processLines regex maybePath

processLine :: Regex -> String -> IO ()
processLine regex line = do
  let resultMaybe = matchRegex regex line
  case resultMaybe of
    Just _ ->  putStrLn line
    Nothing -> return ()

(!!?) :: [a] -> Int -> Maybe a
(!!?) [] _ = Nothing
(!!?) (x:_) 0 = Just x
(!!?) (_:xs) n = (!!?) xs (n - 1)
