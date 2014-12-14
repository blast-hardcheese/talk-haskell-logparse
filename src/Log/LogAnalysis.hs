module Log.LogAnalysis where

import Control.Applicative ((<$>))

import Log.Log

parseMessage :: String -> Either String LogMessage
parseMessage = work . words
--             I 1418592417 This is an informative message
    where work ("I" :        ts' : xs) | (     ts) <- (           read ts') = Right $ LogMessage Info        ts $ unwords xs
--             W 1418592417 This is a warning, watch out!
          work ("W" :        ts' : xs) | (     ts) <- (           read ts') = Right $ LogMessage Warning     ts $ unwords xs
--              E 10 1418592417 This is an error with a severity of 10
          work ("E" : lvl' : ts' : xs) | (lvl, ts) <- (read lvl', read ts') = Right $ LogMessage (Error lvl) ts $ unwords xs
          work xs = Left $ unwords xs
