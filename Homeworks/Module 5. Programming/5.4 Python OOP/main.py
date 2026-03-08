from Alphabet import *

def main():
    
    #Створіть об’єкт класу EngAlphabet
    eng_a = EngAlphabet("en", "wertyuiopkjhgfnbv")
    
    #Виведіть літери алфавіту для цього об’єкта.
    eng_a.print()
    
    #Виведіть кількість літер у алфавіті.
    print(f"{eng_a.letters_num()}")
    
    #letters класса
    #Перевірте, чи належить літера 'F' англійському алфавіту.
    #print(eng_a.s_en_letter("F"))
    
    #Перевірте, чи належить літера 'F' англійському алфавіту.
    print(eng_a.s_en_letter1("F"))

    #letters класса
    #Перевірте, чи належить літера 'Щ' англійському алфавіту.
    #print(eng_a.s_en_letter("Щ"))
    
    #Перевірте, чи належить літера 'Щ' англійському алфавіту.
    print(eng_a.s_en_letter1("Щ"))
    
    #Виведіть приклад тексту англійською мовою.
    print(f"{eng_a.example()}")
    
    
main()
    

    
