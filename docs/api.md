# YOXI-UI API

## Section:NewKeybind(title, default, callback)
- **Описание**: Создаёт перепривязываемую клавишу.
- **Параметры**:
  - `title`: (string) Название.
  - `default`: (Enum.KeyCode) Начальная клавиша.
  - `callback`: (function) Функция при изменении.
- **Пример**:
  ```lua
  Sec:NewKeybind("Keybind", Enum.KeyCode.RightControl, function(key) print("New Key:", key.Name) end)
