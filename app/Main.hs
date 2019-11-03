module Main where

import Data.Function
import Account

main :: IO ()
main = do
    mapM_ putStrLn (createAccount &
         deposit 1000 (2014, 4, 1) &
         withdraw 100 (2014, 4, 2) &
         deposit 500 (2014, 4, 10) &
         printStatement) 
