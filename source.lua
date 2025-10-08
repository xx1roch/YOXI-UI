-- Минимальный ModuleScript для теста с инжектором
local YOXI = {}
function YOXI.new()
    print("YOXI.new вызван через инжектор")
    return {}
end
return YOXI
