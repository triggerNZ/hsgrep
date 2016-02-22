module Lib where

import System.IO ( IOMode(ReadMode),
                   Handle,
                   stdin,
                   hIsEOF,
                   hGetLine,
                   openFile)
import Control.Monad (unless)

import Text.Regex (Regex, mkRegex, matchRegex)

openMaybeFile :: Maybe String -> IO Handle
openMaybeFile (Just filename) = openFile filename ReadMode
openMaybeFile Nothing = return stdin

processLines :: String -> Handle -> IO ()
processLines regex handle = do
  done <- hIsEOF handle
  unless done $
    do
      line <- hGetLine handle
      processLine (mkRegex regex) line
      processLines regex handle

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
