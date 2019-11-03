
import Account (
    createAccount, 
    Transaction(Deposit, Withdrawal, InvalidWithdrawal),
    deposit,
    withdraw,
    balance,
    printStatement)

import Data.Function
import Test.Hspec

main = hspec $ do
  describe "Bank kata" $ do
    describe "createAccount" $ do
      it "should create an account without transactions" $ do
        createAccount `shouldBe` []
    
    describe "deposit" $ do
      it "should deposit an amount at a given date on the account" $ do
        (createAccount & 
         deposit 1000 (2014, 4, 1)) `shouldBe`[Deposit 1000 (2014, 4, 1)]

        (createAccount & 
         deposit 500 (2019, 10, 30)) `shouldBe` [Deposit 500 (2019, 10, 30)]
    
      it "should deposit an other time on the account" $ do
        (createAccount & 
         deposit 1000 (2014, 4, 1) &
         deposit 900 (2014, 5, 12)) `shouldBe` [Deposit 900 (2014, 5, 12),
                                                Deposit 1000 (2014, 4, 1)]
    
    describe "withdraw" $ do
      it "should withdraw an amount at a given date from an account" $ do
        (createAccount &
         deposit 1000 (2014, 4, 1) &
         withdraw 500 (2014, 6, 10)) `shouldBe`[Withdrawal 500 (2014, 6, 10),
                                                Deposit 1000 (2014, 4, 1)]
      
      it "should not withdraw an amount bigger than the account balance " $ do
        (createAccount &
         deposit 1000 (2014, 4, 1) &
         withdraw 1001 (2014, 6, 10)) `shouldBe`[InvalidWithdrawal 1001 (2014, 6, 10),
                                                 Deposit 1000 (2014, 4, 1)]

    describe "balance" $ do
      it "should return zero as current balance when the account contains no transaction" $ do
        (createAccount & balance) `shouldBe` 0 

      it "should return the amount as current balance when the account contains only one deposit" $ do
        (createAccount &
         deposit 1000 (2014, 4, 1) &
         balance) `shouldBe` 1000

      it "should return the sum of amounts of deposit as current balance" $ do
        (createAccount &
         deposit 1000 (2014, 4, 1) &
         deposit 900 (2014, 6, 12) &
         balance) `shouldBe` 1900

      it "should return the sum of amounts of deposit and oposite withdrawal as current balance" $ do
        (createAccount &
         deposit 1000 (2014, 4, 1) &
         withdraw 900 (2014, 6, 12) &
         balance) `shouldBe` 100

      it "should return the sum of amounts of deposit and oposite withdrawal and ignore invalid withdeawalas current balance" $ do
        (createAccount &
         deposit 1000 (2014, 4, 1) &
         withdraw 900 (2014, 6, 12) &
         withdraw 200 (2014, 6, 28) &
         balance) `shouldBe` 100

    describe "printStatement" $ do
      it "should print the header line when there is no transaction" $ do
        (createAccount &
         printStatement) `shouldBe` ["DATE | AMOUNT | BALANCE"]

      it "should print the header line and the deposit when there is a deposit" $ do
        (createAccount &
         deposit 1000 (2014, 6, 2) &
         printStatement) `shouldBe` ["DATE | AMOUNT | BALANCE",
                                     "2014/06/02 | 1000.00 | 1000.00"]

      it "should ignore the invalid withdrawal" $ do
        (createAccount &
         withdraw 100 (2014, 5, 7) &
         deposit 1000 (2014, 6, 2) &
         printStatement) `shouldBe` ["DATE | AMOUNT | BALANCE",
                                     "2014/06/02 | 1000.00 | 1000.00"]

      it "should print the header line and transactions in reverse chronological order" $ do
        (createAccount &
         deposit 1000 (2014, 4, 1) &
         withdraw 100 (2014, 4, 2) &
         deposit 500 (2014, 4, 10) &
         printStatement) `shouldBe` ["DATE | AMOUNT | BALANCE",
                                     "2014/04/10 | 500.00 | 1400.00",
                                     "2014/04/02 | -100.00 | 900.00",
                                     "2014/04/01 | 1000.00 | 1000.00"]

