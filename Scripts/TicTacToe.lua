-- Tic Tac Toe
local game_board = { " ", " ", " ", " ", " ", " ", " ", " ", " " }
local running = true
local errors = {
    ["exist"] = "Already drawn!",
    ["invalid"] = "Invalid input!\n",
}
local error_message = nil
local computer_turn = false
local available_box = 9

local function print_game_board(board)
    print("-------------")
    for i = 1, #board do
        io.write("| " .. board[i] .. " ")
        if i % 3 == 0 then
            print("|")
            print("-------------")
        end
    end
    if error_message then
        print(errors[error_message])
    end
end

local function player_move(player_sign, pos)
    if game_board[pos] == " " then
        game_board[pos] = player_sign
        return true
    end
    return false
end

local function computer_move(computer_sign)
    while true do
        local rand_number = math.random(1, 9)
        if game_board[rand_number] == " " then
            game_board[rand_number] = computer_sign
            return true
        end
    end
end

local function check_winner()
    local wins = {
        { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 }, -- horizontal
        { 1, 4, 7 }, { 2, 5, 8 }, { 3, 6, 9 }, -- vertical
        { 1, 5, 9 }, { 3, 5, 7 }               -- diagonal
    }
    for _, win in ipairs(wins) do
        if game_board[win[1]] == game_board[win[2]] and game_board[win[2]] == game_board[win[3]] and game_board[win[1]] ~= " " then
            print("Player " .. game_board[win[1]] .. " wins!")
            return true
        end
    end
    return false
end

while running do
    os.execute("clear")
    print_game_board(game_board)
    if check_winner() then break end

    if not computer_turn then
        io.write("Enter your move (1-9): ")
        local p_input = tonumber(io.read())
        local p_sign = "X"

        if p_input and p_input <= #game_board and p_input > 0 and available_box >= 1 then
            local p_move = player_move(p_sign, p_input)
            if not p_move then
                error_message = "exist"
            else
                available_box = available_box - 1
                error_message = nil
                computer_turn = true
            end
        else
            error_message = "invalid"
        end
    else
        if available_box > 0 then
            computer_move("O")
            computer_turn = false
            available_box = available_box - 1
        end
    end
end
