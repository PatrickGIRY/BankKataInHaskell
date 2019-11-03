# BankKata in Haskell

* Given an account with no transaction
      
### Scenario: Show account statement containing no transaction
        
* When the account holder want to show the account statement
* Then the statement should have the following format:

| DATE | AMOUNT | BALANCE |
| ---- | ------ | ------- |

### Scenario: Show account statement containing one deposit transactioA

* Given a deposit transaction of 1000 on 2014-04-01
* When the account holder want to show the account statement
* Then the statement should have the following format:

| DATE       | AMOUNT  | BALANCE |
| ---------- | ------- | ------- |
| 2014/04/01 | 1000.00 | 1000.00 |

### Scenario: Show account statement containing several different transactions
        
* Given a deposit transaction of 1000 on 2014-04-01
* And a withdrawal transaction of 100 on 2014-04-02
* And a deposit transaction of 500 on 2014-04-10
* When the account holder want to show the account statement
* Then the statement should have the following format:

| DATE       | AMOUNT  | BALANCE |
| ---------- | ------- | ------- |
| 2014/04/10 | 500.00  | 1400.00 |
| 2014/04/02 | -100.00 | 900.00  |
| 2014/04/01 | 1000.00 | 1000.00 |

### Scenario: Show account statement containing only allow transactions

You can't make a withdrawal higher the account balance.

* Given a withdrawal transaction of 100 on 2014-0r54-0r72
* And a deposit transaction of 1000 on 2014-06-02
* When the account holder want to show the account statement
* Then the statement should have the following format:

| DATE       | AMOUNT  | BALANCE |
| ---------- | ------- | ------- |
| 2014/06/02 | 1000.00 | 1000.00 |

