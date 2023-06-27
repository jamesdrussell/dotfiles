return {
    "rlane/pounce.nvim",
    keys = {
        {"s", function()
            require("pounce").pounce()
        end},
    },
    config = function()
        require("pounce").setup()
    end,
    enabled = false
}
