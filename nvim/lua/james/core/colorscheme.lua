local status, _ = pcall(vim.cmd, "colorscheme edge")
if not status then
    print("Colorscheme not found")
    return
end
