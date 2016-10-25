### Project 1: bank account

##### This Bank Account program is to allow user to manage their account in the bank.

The assumption here is that “User A in Bank B has a checking account with a balance X”. One user
can only have one account in one bank. However, they can have multiple accounts in different banks.
One user is represented by their SSN. one account in one bank is represented by the accountID in
bank_name. user can access their account by their PIN attached to their accountID.
There are two main classes: Account and Bank.

The base class Account is used to deposit/withdraw money/check balance. Depending on the kind of
account User A has, the subclass (Student,Senior,Regular) will have different interest rates for overdraw and
minimum account balance.

The class Bank is used to manage account in the bank. Users can add, remove, and check the
account information in the bank. The balance information is not included in the class(Bank).
