{
  ...
}:
{
  imports = [
    ./termfilechooser.nix
  ];

  programs.yazi = {
    enable = true;
    plugins = {
      ucp = ./plugins/ucp.yazi;
    };
    settings = {
      yazi = {
        mgr = {
          ratio = [
            2
            3
            5
          ];
          sort_by = "natural";
          sort_sensitive = false;
          show_hidden = true;
          mouse_events = [
            "click"
            "scroll"
            "touch"
            "move"
            "drag"
          ];
        };
        input = {
          cursor_blink = true;
        };
      };
      keymap = {
        mgr = {
          keymap = [
            {
              on = "<Esc>";
              run = "escape";
              desc = "Очистить выделенное / отменить поиск";
            }
            {
              on = "<Tab>";
              run = "spot";
              desc = "Показать информацию о файле";
            }
            {
              on = "w";
              run = "tasks:show";
              desc = "Показать список задач";
            }

            # перемещение
            {
              on = "<Up>";
              run = "arrow prev";
              desc = "Предыдущий файл";
            }
            {
              on = "<Down>";
              run = "arrow next";
              desc = "Следующий файл";
            }
            {
              on = "<PageUp>";
              run = "arrow -100%";
              desc = "Переместить курсор на страницу выше";
            }
            {
              on = "<PageDown>";
              run = "arrow 100%";
              desc = "Переместить курсор на страницу ниже";
            }
            {
              on = "<Left>";
              run = "leave";
              desc = "Вернуться в родительскую директорию";
            }
            {
              on = "<Right>";
              run = "enter";
              desc = "Войти в директорию под курсором";
            }

            # выделение файлов
            {
              on = "z";
              run = "visual_mode";
              desc = "Режим выделения";
            }
            {
              on = "<Space>";
              run = "toggle";
              desc = "Выделить";
            }
            {
              on = "<C-a>";
              run = "toggle_all --state=on";
              desc = "Выделить все";
            }

            # операции с файлами
            {
              on = "<Enter>";
              run = "open";
              desc = "Открыть выбранные файлы";
            }
            {
              on = "<S-Enter>";
              run = "open --interactive";
              desc = "Открыть выбранные файлы интерактивно";
            }
            {
              on = "<C-c>";
              run = "plugin ucp copy notify";
              desc = "Скопировать";
            }
            # { on = "<C-x>"; run = ""; desc = "Вырезать"; }
            {
              on = "<C-v>";
              run = "plugin ucp paste notify";
              desc = "Вставить";
            }
            {
              on = "<Delete>";
              run = "remove";
              desc = "В корзину";
            }
            {
              on = "<S-Delete>";
              run = "remove --permanently";
              desc = "Удалить навсегда";
            }
            {
              on = "<F2>";
              run = "rename --hovered --cursor=before_ext";
              desc = "Переименовать";
            }

            # вкладки
            {
              on = [
                "t"
                "t"
              ];
              run = "tab_create --current";
              desc = "Создать вкладку";
            }
            {
              on = [
                "t"
                "q"
              ];
              run = "close";
              desc = "Закрыть текущую вкладку";
            }
            {
              on = "1";
              run = "tab_switch 0";
              desc = "Вкладка 1";
            }
            {
              on = "2";
              run = "tab_switch 1";
              desc = "Вкладка 2";
            }
            {
              on = "3";
              run = "tab_switch 2";
              desc = "Вкладка 3";
            }
            {
              on = "4";
              run = "tab_switch 3";
              desc = "Вкладка 4";
            }
            {
              on = "5";
              run = "tab_switch 4";
              desc = "Вкладка 5";
            }
            {
              on = "6";
              run = "tab_switch 5";
              desc = "Вкладка 6";
            }
            {
              on = "7";
              run = "tab_switch 6";
              desc = "Вкладка 7";
            }
            {
              on = "8";
              run = "tab_switch 7";
              desc = "Вкладка 8";
            }
            {
              on = "9";
              run = "tab_switch 8";
              desc = "Вкладка 9";
            }

            # помощь
            {
              on = "<F1>";
              run = "help";
              desc = "Помощь";
            }
          ];
        };
        input = {
          keymap = [
            # отменить / принять
            {
              on = "<Esc>";
              run = "close";
            }
            {
              on = "<Enter>";
              run = "close --submit";
            }

            # перемещение
            {
              on = "<Left>";
              run = "move -1";
            }
            {
              on = "<Right>";
              run = "move 1";
            }
            {
              on = "<C-Left>";
              run = "backward";
            }
            {
              on = "<C-Right>";
              run = "forward --end-of-word";
            }

            # выделение символов
            {
              on = "<F3>";
              run = "visual_mode";
              desc = "Режим выделения";
            }
            {
              on = "<C-a>";
              run = [
                "move eol"
                "visual"
                "move bol"
              ];
              desc = "Выделить все";
            }

            # удаление символов
            {
              on = "<Backspace>";
              run = "backspace";
            }
            {
              on = "<Delete>";
              run = "backspace --under";
            }
            {
              on = "<C-Backspace>";
              run = "kill backward";
            }
            {
              on = "<C-Delete>";
              run = "kill forward";
            }

            # скопировать / вырезать / вставить
            {
              on = "<C-c>";
              run = "yank";
            }
            {
              on = "<C-x>";
              run = "delete --cut";
            }
            {
              on = "<C-v>";
              run = "paste";
            }

            # undo / redo
            {
              on = "<C-z>";
              run = "undo";
            }
            {
              on = "<C-Z>";
              run = "redo";
            }

            # помощь
            {
              on = "<F1>";
              run = "help";
              desc = "Помощь";
            }
          ];
        };
      };
    };
  };
}
