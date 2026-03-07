import random

def main():
    random_value = random.randint(1, 100)
    try:
        for i in range(5):
            print(f"\nAttempt №{i+1}")
            user_input = int(input("Your number: "))
            if user_input == random_value:
                print("You win! Congratulations!")
                break
            elif user_input > random_value:
                print("Too high")
            else:
                print("Too small")
        else:
            print(f"Sorry, you've used all attempts. The correct number was {random_value}.")
    except ValueError:
        print("Error! Incorrect value!")
        exit(1)

if __name__ == "__main__":
    main()