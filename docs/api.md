# YOXI-UI API

## YOXILibrary.new(destroyOnUnload, title, description, keybind, logo)
- **Описание**: Создаёт окно GUI.
- **Параметры**:
  - `destroyOnUnload`: (boolean) Уничтожать ли GUI при выгрузке.
  - `title`: (string) Заголовок окна.
  - `description`: (string) Описание.
  - `keybind`: (Enum.KeyCode) Клавиша для открытия/закрытия.
  - `logo`: (string) Asset ID иконки.
- **Пример**:
  ```lua
  local Win = YOXI.new(true, "Моя GUI", "Тест", Enum.KeyCode.RightShift, "rbxassetid://4483345998")
