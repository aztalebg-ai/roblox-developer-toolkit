
local TableUtils = {}

function TableUtils.copy(source)
    assert(type(source) == "table", "Expected a table")

    local result = {}

    for key, value in pairs(source) do
        result[key] = value
    end

    return result
end

function TableUtils.count(source)
    assert(type(source) == "table", "Expected a table")

    local total = 0

    for _ in pairs(source) do
        total += 1
    end

    return total
end

function TableUtils.contains(source, target)
    assert(type(source) == "table", "Expected a table")

    for _, value in pairs(source) do
        if value == target then
            return true
        end
    end

    return false
end

return TableUtils
