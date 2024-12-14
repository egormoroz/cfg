local harpoon = require("harpoon")
harpoon:setup()

local map = function (lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc, noremap = true })
end

map("<leader>a", function() harpoon:list():add() end, 'harpoon list add')
-- map('<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("<leader>j", function() harpoon:list():select(1) end)
map("<leader>k", function() harpoon:list():select(2) end)
map("<leader>u", function() harpoon:list():select(3) end)
map("<leader>;", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
map("<C-J>", function() harpoon:list():prev() end)
map("<C-K>", function() harpoon:list():next() end)

local function toggle_telescope(harpoon_files)
  local conf = require("telescope.config").values
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

map("<leader>fe", function() toggle_telescope(harpoon:list()) end,
    "Open harpoon window")
