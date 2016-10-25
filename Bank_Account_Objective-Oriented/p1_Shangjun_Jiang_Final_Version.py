

#display images
from IPython.display import Image, display
#generate random numbers
from random import randint

import sys

#Global vairable
bank_account = {} #bank: accountID
bank_PIN = {} #bank: PIN
list_bank = [] # a list of bank   one SSN can have multiple banks
list_accountID = []
bank_balance ={} #bank: balance


##Class1: Account (base class)
##Class2&3&4:Student, Senior, Regular (subclass of Account)
##Class5: Bank

## There are three parts of the codes.
#1. Class Account(Student, Senior, Regular)
#2. Class Bank
#3. User Interface

"""
Assumption: User A in Bank B has a checking account with the balance X.

The base class **Account** is used to deposit/withdraw money.
Depending on the kind of account User A has,
    the subclass (Student,Family,Regular) will have different interest rates and fees for withdraw and deposit money.
"""

class Account:

    def __init__(self, user_name = "Jenny", bank_name = "Bank of America", balance = 0):
        self.user_name = user_name
        self.bank_name = bank_name
        self.balance = int(balance)
        self.interest = None
        self.min_balance = None
        self.account_type = None
        self.image_path = None

    def get_balance(self):
        print ('Dear {0},'.format(self.user_name))
        print("Your account balance in",self.bank_name,"is:",self.balance)

    #save the balance amount, user should not call on this one.
    def bbalance(self):
        print(self.balance)

        """
        The paramaters deposit_amount, withdraw_amount have to be
        integers and must satisfy the following equations:
        deposit_amount > 0
        withdraw_amount < self.balance
        """

    # if they want to see what kind of account that is.
    def display_image(self):
        if self.image_path is not None:
            display(Image(filename=self.image_path))

    def deposit(self, deposit_amount):
        if type(deposit_amount) == int and deposit_amount > 0:
            self.balance += deposit_amount
            print ('Dear {0},'.format(self.user_name))
            print ("You have successfully deposited:", deposit_amount, "to your account in", self.bank_name)
            print("Your account balance in", self.bank_name, "is:", self.balance)
            print("---------------------\nThank you for using\n", self.bank_name, "\n---------------------")
        else:
            raise ValueError ("Deposit amount has to be integers greater than 0.")

    def withdraw(self, withdraw_amount):

        """
        If withdraw within the amount of balance, then there is no loan fee.
            If withdraw over the amount of balance, then it depends on the type of account you have (Student, Senior, Regular).
            The interest rate is different.
        """

        if type(withdraw_amount) == int and (self.balance - self.min_balance) >= withdraw_amount:
            self.balance -= withdraw_amount
            print ('Dear {0},'.format(self.user_name))
            print ("You have successfully withdrawn:", withdraw_amount)
            print("Your account balance in", self.bank_name,"is:", self.balance)
            print("---------------------\nThank you for using\n", self.bank_name, "\n---------------------")

        #for overdraw situations
        elif type(withdraw_amount) == int and (self.balance - self.min_balance) < withdraw_amount and withdraw_amount - self.balance < 5000:
            print ("Since the amount of money you withdraw is greater than your minimum account balance, your account balance will be negative.")
            overdraw = input ("Please confirm your choice. Enter 'yes/no':  --> ")
            if overdraw == "yes":
                self.balance -= withdraw_amount

                # interest rates are different based on the account type.
                if self.interest is not None:
                    print ("Would you want to calculale the rate?")
                    ans = input("Please enter 'yes/no':  -->")
                    if ans == 'yes':
                        print("Please enter the duration of the loan.")
                        time = int(input("Please enter the year digit, such as 1 as 1 year, at max 5 years:  --> "))
                        if time > 5:
                            raise ValueError ("The duration of the loan must be an integer from 1 to 5.")
                        else:
                            rate = 1000 * pow((0.7 + self.interest), time)
                            print("Your loan fees in", time, "year(s) for", self.balance, "in", self.bank_name,"is:",rate,"dollar(s).")
                            print ("")
                            print ("Please make sure you pay the fee on time. Otherwise, you will be penalized.")
                            print ("If you would like to know more information, please enquire at the counter.")
                            print("---------------------\nThank you for using\n", self.bank_name,"\n---------------------")
                    else:
                        print ("You have successfully overdawn: ", withdraw_amount)
                        print("Your account balance in",self.bank_name, "is:",self.balance)
                        print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")
                        return None

                else:
                    print ("You have successfully overdawn: ", withdraw_amount)
                    print("Your account balance in",self.bank_name, "is:",self.balance)
                    print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")
                    return None

            else:
                print("Your account balance in",self.bank_name, "is:",self.balance)
                print ("If you would like to know more information, please enquire at the counter.")
                print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")
        else:
            raise ValueError ("Withdraw amount has to be integers less or equal to your balance. If you choose to overdraw, the amount must be less than 5000 dollars.")


    def MinimumAccountBalance(self):
        if self.min_balance is not None:
            print ('Dear {0},'.format(self.user_name))
            print("The minimum amount of balance in", self.bank_name, "for", self.account_type, "is:",self.min_balance)


"""
Subclass (student, senior, regular)
Based on different account types, people get different interest rate and minmum account balance.
"""

class Student(Account):

    def __init__(self, user_name, bank_name, balance):
        super().__init__(user_name, bank_name, balance)
        self.interest = 0.005
        self.min_balance = 0
        self.account_type = "student account"
        self.image_path = "student.jpg"

class Senior(Account):

    def __init__(self, user_name, bank_name, balance):
        super().__init__(user_name, bank_name, balance)
        self.interest = 0.01
        self.min_balance = 10
        self.account_type = "senior account"
        self.image_path = "senior.jpg"

class Regular(Account):

    def __init__(self, user_name, bank_name, balance):
        super().__init__(user_name, bank_name, balance)
        self.interest = 0.02
        self.min_balance = 30
        self.account_type = "regular account"
        self.image_path = "regular.jpg"



"""
Assumption: One user can only have one account in one bank.
            However, one user can have multiple accounts in different banks.

The class Bank is used to manage account in the bank.
Users can add, remove, and check the account information in the bank.

one user is represented by their SSN.
one account in one bank is represented by the accountID in bank_name.
user can access their account by their PIN attached to their accountID.

However, if they want to see the balance, deposit or withdraw money from the account.
They need to use the class(Account).
The balance information is not included in the class(Bank).

"""


class Bank(object):


    """
    The paramaters SSN, PIN have to be integers and must satisfy the following requirements:
    The length of the SSN must be 9.
    The length of the PIN must be 6.

    """

    def __init__(self, user_name, SSN):

        self.check_SSN(user_name,SSN)
        self.bank_name = None
        self.PIN = None
        self.accountID = None



    def check_SSN(self, user_name, SSN):
        """
        The paramaters SSN has to be integers
        and the length of the SSN must be 9.
        """

        if len(SSN) == 9:
            self.SSN = int(SSN)
            self.user_name = user_name
        else:
            raise ValueError("SSN has to be composed of a 9-digit integer.")


    def Add_Account(self, bank_name):
        self.bank_name = bank_name
        print ('Dear {0},'.format(self.user_name))
        print("---------------------\n" +self.bank_name+"\nWelcomes you\n---------------------")

        if self.bank_name not in list_bank:   #check if the user has created an account in the bank.
            print('Confirmed...')
            print("")
            accountID = randint(100000, 900000)   #randomly generate an 6-digit accountID
            while accountID in list_accountID:  #check if the accountID exists in the existing accountID
                accountID = randint(100000, 900000)
            self.accountID = accountID
            print("Account created.")
            print ("Your account ID is:", self.accountID)
            list_accountID.append(accountID)  #add the accountID to the list of account under one user(SSN)
            bank_account.update({self.bank_name:self.accountID})  #one bank, one account.

            PIN = input("Please enter your 6-digit PIN:  --> ")
            if len(PIN) == 6:
                self.PIN = int(PIN)
                bank_PIN.update({self.bank_name: self.PIN})  #one account, one pin.
                list_bank.append(self.bank_name)  #add the bank name to the list of bank under one user(SSN)
                print ("PIN attaches with your account.")
                print("Account created. Remember your ID to login next time")
                print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")
            else:
                raise ValueError ("Invalid PIN.")

        else:
            print ("Sorry, you have created an account with", self.bank_name)
            print ("Your accountID is:", bank_account[bank_name])
            print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")


    def Get_Account(self, bank_name):
        self.bank_name = bank_name
        print ('Dear {0},'.format(self.user_name))
        print("---------------------\n" +str(self.bank_name)+"\nWelcomes you\n---------------------")

        if self.bank_name in list_bank:
            print('Confirmed...')
            print("")

            PIN = int(input("Please enter your 6-digit PIN:  --> "))
            if bank_PIN[self.bank_name] == PIN:
                print("Your account ID in", self.bank_name, "is:", self.accountID)
                print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")
            else:
                raise ValueError ("Invalid PIN.")

        else:
            print ("Sorry, we are unable to find your information in our system.")
            print ("If you would like to know more information, please enquire at the counter.")
            print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")


    def Remove_Account(self, bank_name):
        self.bank_name = bank_name
        print ('Dear {0},'.format(self.user_name))
        print("---------------------\n" +self.bank_name+"\nWelcomes you\n---------------------")

        if self.bank_name in list_bank:
            print('Confirmed...')
            print("")

            PIN = int(input("Please enter your 6-digit PIN:  --> "))
            if bank_PIN[self.bank_name] == PIN:
                print("Your account ID in", self.bank_name, "is:", self.accountID)
                print ("Are you sure you want to delete your account with us?")
                ans = input ("Please enter 'yes/no':  --> ")
                if ans == 'yes':
                    bank_account.pop(self.bank_name)
                    bank_PIN.pop(self.accountID)
                    list_bank.remove(self.bank_name)
                    list_accountID.remove(self.accountID)
                    print ('Dear {0},'.format(self.user_name))
                    print("You have successfully deleted your account in", self.bank_name)
                    print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")
                elif ans == "no":
                    print ('Dear {0},'.format(self.user_name))
                    print("We are glad that you choose to stay with us.")
                    print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")
                else:
                    raise ValueError ("Invalid Input!")

            else:
                raise ValueError ("Invalid PIN.")

        else:
            print ("Sorry, we are unable to find your information in our system.")
            print ("If you would like to know more information, please enquire at the counter.")
            print("---------------------\nThank you for using\n"+ self.bank_name+"\n---------------------")


    def Num_Account(self):
        print ('Dear {0},'.format(self.user_name))
        print ("You have", len(list_bank), "bank account(s) in", list_bank)



"""
User Interface.

The user input their name and SSN. They choose which bank they want to access to.
Then they can choose either access the account information or account balance.

"""


name = input("Please enter your name:  --> ")
SSN = input("Please enter your SSN:  --> ")
user = Bank(name,SSN)

print ("Are you a student, senior, or other?")
print ("1. Student")
print ("2. Senior")
print ("3. Regular")
user_type = int(input ("Please enter '1/2/3':  --> "))
#check if the input is valid or not.
if user_type != 1 and user_type != 2 and user_type != 3 :
    raise ValueError ("Please enter the valid option!")


## bank information level
bank = input("Which bank would you like to access?  --> ")
if bank not in bank_balance:
    amount = 0
else:
    amount = bank_balance[bank]

# set up different account type.
if user_type == 1:
    bank_type = Student(name, bank, amount)
elif user_type == 2:
    bank_type = Senior(name, bank, amount)
elif user_type == 3:
    bank_type = Regular (name, bank, amount)



#allow user to choose to the account info OR account balance.
option = 0

while option != 3:

    #allow user to choose to the account info OR account balance.
    print ("")  #leave some space between lines
    print ("Dear", name, ": What would you like to do now?")
    print ("1. Account Balance: withdraw/deposit/get balance")
    print ("2. Account Management: add/remove/access account")
    print ("3. Exit")
    option = int(input ("Please enter the number '1/2/3':  --> "))


    if option == 1:
        print ("")
        print ("Dear", name, ": You are on the account balance level.")
        #check if the user has an account with the bank
        if bank in bank_account:
            PIN = int(input("Please enter your 6-digit PIN:  --> "))
            if bank_PIN[bank] != PIN:
                raise ValueError ("Invalid PIN.")
            else:
                print ("What would you like to do now with your account in", bank, "?")
                print ("1. Withdraw")
                print ("2. Deposit")
                print ("3. Get Balance")
                print ("4. Check Minimun Account Balance")
                ans = int(input("Please enter '1/2/3/4':  --> "))
                if ans == 1:
                    amount = int(input("How much would you like to withdraw your account?  --> "))
                    bank_type.withdraw(amount)
                elif ans == 2:
                    amount = int(input("How much would you like to deposit into your account?  --> "))
                    bank_type.deposit(amount)
                elif ans == 3:
                    bank_type.get_balance()
                elif ans == 4:
                    bank_type.MinimumAccountBalance()
                else:
                    raise ValueError ("Please enter a valid option!")
        else:
            raise ValueError ("Sorry, it seems that you do not have an account with us.")


    elif option == 2:
        print ("")
        print ("Dear", name, ": You are on the account information level.")
        print ("What would you like to do?")
        print ("1. Add Account")
        print ("2. Remove Account")
        print ("3. Get Account")
        to_do = int(input ("Please enter the number '1/2/3':  --> "))
        if to_do == 1:
            user.Add_Account(bank)
            #check if the user has an account with the bank
            if bank not in bank_account:
                amount = int(input("How much would you like to deposit into your account?  --> "))
                bank_type.deposit(amount)
        elif to_do == 2:
            user.Remove_Account(bank)
        elif to_do == 3:
            user.Get_Account(bank)
        else:
            raise ValueError ("Please enter a valid option!")

    elif option == 3:
        ("---------------------\nThank you for using\n"+ bank +"\n---------------------")
        sys.exit()

    else:
        raise ValueError ("Invalid input!")
