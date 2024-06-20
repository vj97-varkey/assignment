class BankAccount:
    def __init__(self, account_number, password, balance=0):
        self.account_number = account_number
        self.password = password
        self.balance = balance

    def deposit(self, amount):
        if amount > 0:
            self.balance += amount
            print(f"Deposited {amount}. New balance is {self.balance}.")
        else:
            print("Invalid deposit amount.")

    def withdraw(self, amount):
        if 0 < amount <= self.balance:
            self.balance -= amount
            print(f"Withdrew {amount}. New balance is {self.balance}.")
        else:
            print("Invalid or insufficient funds for withdrawal.")

    def check_balance(self):
        print(f"Current balance is {self.balance}.")


class BankSystem:
    def __init__(self):
        self.accounts = {}

    def create_account(self, account_number, password):
        if account_number in self.accounts:
            print("Account already exists.")
        else:
            self.accounts[account_number] = BankAccount(account_number, password)
            print("Account created successfully.")

    def login(self, account_number, password):
        if account_number in self.accounts and self.accounts[account_number].password == password:
            print("Login successful.")
            return self.accounts[account_number]
        else:
            print("Invalid account number or password.")
            return None

    def main_menu(self):
        while True:
            print("\n--- Welcome to the Bank System ---")
            print("1. Create Account")
            print("2. Login")
            print("3. Exit")
            choice = input("Choose an option: ")

            if choice == '1':
                account_number = input("Enter new account number: ")
                password = input("Enter new password: ")
                self.create_account(account_number, password)
            elif choice == '2':
                account_number = input("Enter account number: ")
                password = input("Enter password: ")
                account = self.login(account_number, password)
                if account:
                    self.account_menu(account)
            elif choice == '3':
                print("Exiting the system. Goodbye!")
                break
            else:
                print("Invalid choice. Please try again.")

    def account_menu(self, account):
        while True:
            print("\n--- Account Menu ---")
            print("1. Deposit")
            print("2. Withdraw")
            print("3. Check Balance")
            print("4. Logout")
            choice = input("Choose an option: ")

            if choice == '1':
                amount = float(input("Enter amount to deposit: "))
                account.deposit(amount)
            elif choice == '2':
                amount = float(input("Enter amount to withdraw: "))
                account.withdraw(amount)
            elif choice == '3':
                account.check_balance()
            elif choice == '4':
                print("Logging out...")
                break
            else:
                print("Invalid choice. Please try again.")


if __name__ == "__main__":
    bank_system = BankSystem()
    bank_system.main_menu()