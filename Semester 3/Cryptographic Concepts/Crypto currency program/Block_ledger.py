import string
import random

def transadd():
    send = ""
    while (send.isalpha() is False):
        send = input("From (max 10, letters only): ")
        if send == "":
            send = randomvalue("c")
    send = send.strip()
    send = send.casefold()
    send = send[0:10]
    print("Sending from: " + send)
    receiver = ""
    while (receiver.isalpha() is False):
        receiver = input("To (max 10, letters only): ")
        if receiver == "":
            receiver = randomvalue("c")
    receiver = receiver.strip()
    receiver = receiver.casefold()
    receiver = receiver[0:10]
    print("Sending to: " + receiver)
    amount = ""
    while (amount.isdigit() is False) or (int(amount) < 1):
        amount = input("Amount (max 10, digits only): ")
        if amount == "":
            amount = randomvalue("n")
    receiver = receiver.strip()
    amount = amount[0:10]
    print("Amount is: " + amount)
    try:
        filename = "ledger.txt"
        ledger = open(filename, mode='a+')
        send10 = send.ljust(10)
        ledger.write("|FROM:| " + send10)
        receiver10 = receiver.ljust(10)
        ledger.write(" |TO:| " + receiver10)
        ledger.write(" |AMOUNT:| " + amount + "\n")
    except (FileNotFoundError, PermissionError) as e:
        print("Unable to open " + filename + " for writing purpose. Quitting the program!")
        quit()

# To generate 10 random values if user don't enter the any
def randomvalue(category):
    number = 10
    letters = string.ascii_lowercase
    numbers = string.digits
    if category == "c":
        result = ""
        count = 0
        while count < number:
            result += random.choice(letters)
            count += 1
        return result
    if category == "n":
        result = ""
        count = 0
        while count < number:
            result += random.choice(numbers)
            count += 1
        return result

try:
    print("Press CTRL+C to quit any time.")
    while True:
        choice = ""
        while (choice != "yes") and (choice != "no"):
            choice = input("New transaction? \"yes\" to add: ")
            choice = choice.strip()
            choice = choice.casefold()
        if (choice == "yes"):
            transadd()
        if (choice == "no"):
            quit()
except KeyboardInterrupt:
    quit()
