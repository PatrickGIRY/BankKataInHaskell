module Account(
  createAccount,
  Transaction(Deposit, Withdrawal, InvalidWithdrawal),
  deposit,
  withdraw,
  balance,
  printStatement
) where

import Text.Printf(printf)
  
type Amount = Integer
type Date = (Integer, Int, Int)

data Transaction = Deposit Amount Date
                 | Withdrawal Amount Date
                 | InvalidWithdrawal Amount Date
  deriving (Show, Eq)

type Account = [Transaction]

type Balance = Integer

type StatementLine = String

createAccount :: Account  
createAccount = []
deposit :: Amount -> Date -> Account -> Account
deposit a d tx = Deposit a d : tx

withdraw :: Amount -> Date -> Account -> Account
withdraw a d tx | balance tx - a >= 0 = Withdrawal a d : tx
                | otherwise           = InvalidWithdrawal a d : tx

balance :: Account -> Balance
balance []  = 0
balance tx = sum $ map amount tx

amount :: Transaction -> Amount
amount (Deposit a _)           =  a
amount (Withdrawal a _)        = -a
amount (InvalidWithdrawal _ _) = 0

printStatement :: Account -> [StatementLine]
printStatement tx = header : fst (foldr printStatementLine ([],0) (excludeInvalidWithdrawal tx))
    where printStatementLine :: Transaction -> ([StatementLine], Amount) -> ([StatementLine], Amount)
          printStatementLine t (ls,b) = (((formatStatementLine t b) : ls), (b + (amount t)))

          formatStatementLine :: Transaction -> Amount -> StatementLine         
          formatStatementLine t b = ((formatDate (dateTransaction t)) ++ " | " ++ (formatDecimal (amount t)) ++ " | " ++ (formatDecimal (b + (amount t))))

          dateTransaction :: Transaction -> Date
          dateTransaction (Deposit _ d)    = d 
          dateTransaction (Withdrawal _ d) = d 

          excludeInvalidWithdrawal :: Account -> Account
          excludeInvalidWithdrawal = filter isNotInvalidWithdrawal

          isNotInvalidWithdrawal :: Transaction -> Bool
          isNotInvalidWithdrawal (InvalidWithdrawal _ _) = False
          isNotInvalidWithdrawal _                       = True
   
          formatDate :: Date -> String
          formatDate (y, m, d) = printf "%4d/%02d/%02d" y m d

          formatDecimal :: Amount -> String
          formatDecimal d      = printf "%.2f" (asDouble d) 

          asDouble :: Amount -> Double
          asDouble d           = fromIntegral d

header :: StatementLine
header = "DATE | AMOUNT | BALANCE"

