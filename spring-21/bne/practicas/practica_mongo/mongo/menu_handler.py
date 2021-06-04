import time
import pprint
from os import system, name
from users_menu_handler import UserMenuHandler

class MenuHandler:
    def __init__(self, client):
        self.client = client
        self.user_menu_handler = UserMenuHandler(self.client)
        self.menu = 0
        self.user_option = -1
        self.menus = [
            MenuItem(id=0, title='Main menu', options=['Exit', 'Add User', 'Add place', 'Nearest bike station', 'Trip planner']),
            MenuItem(id=1, title='New user', options=['Return', 'Add user details']),
            MenuItem(id=2, title='User details'),
            MenuItem(id=3, title='New place'),
            MenuItem(id=4, title='Nearest bike station'),
            MenuItem(id=5, title='Trip planner')
        ]
        self.pp = pprint.PrettyPrinter(indent=2)

    def handle_user_option(self):
        if self.menu == 0 and self.user_option == '0':
            exit(0)
        elif self.menu == 0 and self.user_option == '1':
            self.menu = 1
        elif self.menu == 0 and self.user_option == '2':
            self.menu = 3
        elif self.menu == 0 and self.user_option == '3':
            self.menu = 4
        elif self.menu == 0 and self.user_option == '4':
            self.menu = 5
        elif self.menu == 1 and self.user_option == '0':
            self.menu = 0
        elif self.menu == 1 and self.user_option == '1':
            self.menu = 2

    def __main_menu(self):
        self.menu = 0
        self.user_option = '-1'

    def __new_user_menu(self):
        self.menu = 0
        self.user_option = '1'

    def add_place(self):
        self.menus[self.menu].clear_screen()
        try:
            self.user_menu_handler.update_place()
        except:
            print("An error occurred while adding a new place")
        self.__main_menu()

    def add_user(self):
        self.menus[self.menu].clear_screen()
        try:
            user = self.user_menu_handler.ask_for_user_input()
            correct = input("\nIs data correct?\n0. No\n1. Yes\n-> ")
            if correct == '0':
                self.__new_user_menu()
            else:
                self.user_menu_handler.add_user_to_db(user)
                self.__main_menu()
        except:
            print("An error occurred while adding a new user")
            self.__main_menu()

    def nearest_station(self):
        self.menus[self.menu].clear_screen()
        try:
            self.user_menu_handler.nearest_station()
            self.__main_menu()
        except:
            print("An error occurred while looking for a nearest station")
            self.__main_menu()

    def trip_planner(self):
        self.menus[self.menu].clear_screen()
        try: 
            self.user_menu_handler.trip_planner()
            self.__main_menu()
        except:
            print("An error occurred while planning a trip")
            self.__main_menu()

    def show_menus(self):
        if self.menu == 2:
            self.add_user()
        elif self.menu == 3:
            self.add_place()
        elif self.menu == 4:
            self.nearest_station()
        elif self.menu == 5:
            self.trip_planner()
        else:
            self.user_option = self.menus[self.menu].show()
        self.handle_user_option()

class MenuItem:
    def __init__(self, id, title, options=None):
        self.id = id
        self.title = title
        self.options = options
        self.text_menu = ''
        self.__build_options()

    def __build_options(self):
        if self.options is None: pass
        else:
            str_ = 'Options:\n'
            counter = 0
            for option in self.options:
                str_ += f"{counter}. {option}\n"
                counter += 1
            str_ += '-> '
            self.text_menu = str_

    def clear_screen(self):
        # for windows
        if name == 'nt': _ = system('cls')
        # for mac and linux(here, os.name is 'posix')
        else: _ = system('clear')

    def show(self):
        self.clear_screen()
        return input(self.text_menu)