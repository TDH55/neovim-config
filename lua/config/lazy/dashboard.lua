return {
  -- A dashboard if nvim is opened without any file/path arguments
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup()
  end,
  dependencies = {
    'nvim-web-devicons'
  }
}
