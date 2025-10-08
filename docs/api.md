# YOXI-UI API

## YOXILibrary.new(destroyOnUnload, title, description, keybind, logo)
- **Описание**: Создаёт окно с вертикальными вкладками.
- **Параметры**: См. предыдущий `api.md`.

## Section:NewProgressBar(title, min, max, default, callback)
- **Описание**: Создаёт полосу прогресса.
- **Параметры**:
  - `title`: (string) Название.
  - `min`: (number) Минимальное значение.
  - `max`: (number) Максимальное значение.
  - `default`: (number) Начальное значение.
  - `callback`: (function) Функция при изменении.
- **Методы**:
  - `SetValue(newValue)`: Устанавливает новое значение.
- **Пример**:
  ```lua
  local progress = Sec:NewProgressBar("Progress", 0, 100, 0, function(value) print(value) end)
  progress:SetValue(50)
