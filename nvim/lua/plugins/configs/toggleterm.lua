local shell = nil
if jit.os == 'Windows' then
    shell = 'powershell'
end

return {
    shell = shell,
    size = function(term)
        if term.direction == 'vertical' then
            return vim.o.columns * 0.5
        elseif term.direction == 'horizontal' then
            return vim.o.lines * 0.5
        end
    end
}
