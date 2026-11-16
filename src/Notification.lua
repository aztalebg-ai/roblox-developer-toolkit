
local Notification = {}

export type NotificationData = {
    Title: string,
    Message: string,
    CreatedAt: number
}

function Notification.create(title: string, message: string): NotificationData
    assert(type(title) == "string", "Title must be a string")
    assert(type(message) == "string", "Message must be a string")

    assert(title ~= "", "Title cannot be empty")
    assert(message ~= "", "Message cannot be empty")

    return {
        Title = title,
        Message = message,
        CreatedAt = os.time()
    }
end

function Notification.format(data: NotificationData): string
    assert(type(data) == "table", "Expected a notification table")

    return string.format(
        "[%s] %s",
        data.Title,
        data.Message
    )
end

return Notification
