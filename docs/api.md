# YOXI-UI API

## YOXILibrary.new(destroyOnUnload, title, description, keybind, logo)
Создаёт новое окно GUI.
- `destroyOnUnload`: (boolean) Уничтожать GUI при выгрузке.
- `title`: (string) Заголовок окна.
- `description`: (string) Описание.
- `keybind`: (Enum.KeyCode) Клавиша для показа/скрытия.
- `logo`: (string) Asset ID для иконки.

## Window:NewTab(title, desc, icon)
Создаёт новую вкладку.
- `title`: (string) Название вкладки.
- `desc`: (string) Описание.
- `icon`: (string) Asset ID иконки.

## Section:NewToggle(title, default, callback)
Создаёт переключатель.
- `title`: (string) Название.
- `default`: (boolean) Начальное состояние.
- `callback`: (function) Функция при переключении.

## Section:NewColorPicker(title, default, callback)
Создаёт выбор цвета.
- `title`: (string) Название.
- `default`: (Color3) Начальный цвет.
- `callback`: (function) Функция при выборе цвета.
