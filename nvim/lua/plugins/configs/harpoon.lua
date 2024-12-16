local harpoon = require("harpoon")
harpoon:setup()

local map = function (lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc, noremap = true })
end

map("<leader>a", function() harpoon:list():add() end, 'harpoon add')
map("<leader>A", function() harpoon:list():prepend() end, 'harpoon prepend')

map("<leader>j", function() harpoon:list():select(1) end)
map("<leader>k", function() harpoon:list():select(2) end)
map("<leader>l", function() harpoon:list():select(3) end)
map("<leader>;", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
map("<C-J>", function() harpoon:list():prev() end)
map("<C-K>", function() harpoon:list():next() end)

local function toggle_telescope(harpoon_list)
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")

  local make_finder = function ()
    local paths = {}
    for _, item in ipairs(harpoon_list.items) do
      table.insert(paths, item.value)
    end
    return require('telescope.finders').new_table({
      results = paths,
    })
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = make_finder(),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
    attach_mappings = function (bufnr, _)
      actions.delete_buffer:replace(function ()
        local state = require("telescope.actions.state")
        local selected_entry = state.get_selected_entry()
        local current_picker = state.get_current_picker(bufnr)

        table.remove(harpoon_list.items, selected_entry.index)
        current_picker:refresh(make_finder())
      end)
      return true
    end
  }):find()
end

map("<leader>fe", function() toggle_telescope(harpoon:list()) end,
  "Open harpoon window")
