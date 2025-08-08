require('neotest').setup({
  adapters = {
    require('neotest-phpunit')({
      phpunit_cmd = function()
        return "vendor/bin/phpunit"
      end
    }),
  },
  discovery = {
    enabled = true,
  },
  running = {
    concurrent = true,
  },
  summary = {
    open = "botright vsplit | vertical resize 50"
  },
})
