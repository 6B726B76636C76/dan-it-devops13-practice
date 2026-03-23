
import string
from typing import List


class Alphabet:
    lang: str
    letters: List[str]
    
    def __init__(self, lang: str, letters: str):
        self.lang=lang
        self.letters = list(letters)
        
    def print(self):
        #for x in self.letters: print(f"{x}")
        print(" ".join(self.letters))  
        
    def letters_num(self) -> int:
        return len(self.letters)
            
    
    
class EngAlphabet(Alphabet):
    _letters_num: int
    def __init__(self, lang, letters):
        super().__init__(lang, letters)
        self._letters_num = super().letters_num()
        
    #не совсем понял "чи належить ця літера англійському алфавіту.". речь об обьекте класса или самом алфавите? сделал два метода        
    def s_en_letter(self, char: str) -> bool:
        return char in self.letters
    
    def s_en_letter1(self, char: str): 
        en_alphabet = list(string.ascii_letters)
        return char in en_alphabet
    
    def letters_num(self) -> int:
        return self._letters_num
    
    @staticmethod
    def example() -> str:
        text = "Create the is_en_letter() method, which will take a letter as a parameter and determine whether this letter belongs to the English alphabet."
        return text