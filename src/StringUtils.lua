
local StringUtils = {}

function StringUtils.trim(value: string): string
    assert(type(value) == "string", "Expected a string")

    return value:match("^%s*(.-)%s*$")
end

function StringUtils.capitalize(value: string): string
    assert(type(value) == "string", "Expected a string")

    if value == "" then
        return value
    end

    return value:sub(1, 1):upper() .. value:sub(2)
end

function StringUtils.isEmpty(value: string): boolean
    assert(type(value) == "string", "Expected a string")

    return StringUtils.trim(value) == ""
end

return StringUtils
