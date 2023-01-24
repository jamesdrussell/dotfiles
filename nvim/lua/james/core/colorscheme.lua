local status, _ = pcall(vim.cmd, "colorscheme vscode")
if not status then
    print("Colorscheme not found")
    return
end
