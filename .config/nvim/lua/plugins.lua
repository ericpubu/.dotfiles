local execute = vim.api.nvim_command
local fn = vim.fn

-- Installs packer if is the first time loading
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

-- Installs parser if is the first time
local treesitter_path = fn.stdpath("data") .. "/site/pack/packer/start/nvim-treesitter"
local treesitter_hook = ':TSUpdate'
if fn.empty(fn.glob(treesitter_path)) > 0 then
    treesitter_hook = ':TSInstall lua go rust typescript python yaml toml comment'
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require('packer').startup {
    function(use)
        use 'wbthomason/packer.nvim'
        -- Icons
        use 'kyazdani42/nvim-web-devicons'
        -- Status line
        use {
            'glepnir/galaxyline.nvim', branch = 'main',
            requires = {'kyazdani42/nvim-web-devicons'}
        }
        use 'machakann/vim-highlightedyank'
        use 'andymass/vim-matchup'
        use 'justinmk/vim-sneak'
        use 'szw/vim-maximizer'
        use 'airblade/vim-rooter'
        use 'terrortylor/nvim-comment'
        -- File Explorer
        use 'kyazdani42/nvim-tree.lua'

        -- LSP
        use 'neovim/nvim-lspconfig'
        use 'nvim-lua/lsp_extensions.nvim'
        use {'kabouzeid/nvim-lspinstall'}
        use 'nvim-lua/lsp-status.nvim'

        -- Telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

        -- Autocomplete
        use 'hrsh7th/nvim-compe'
        use 'hrsh7th/vim-vsnip'
        use "rafamadriz/friendly-snippets"

        -- Treesitter
        use {'nvim-treesitter/nvim-treesitter', run = treesitter_hook}
        use 'nvim-treesitter/playground'
        use 'nvim-treesitter/nvim-treesitter-textobjects'

        -- Debugger
        use 'mfussenegger/nvim-dap'
        use 'nvim-telescope/telescope-dap.nvim'
        use 'theHamsta/nvim-dap-virtual-text'

        -- Syntax
        use 'godlygeek/tabular'
        use 'plasticboy/vim-markdown'

        -- Git
        use {
            'lewis6991/gitsigns.nvim',
            requires = { 'nvim-lua/plenary.nvim'},
            config = function()
                require('gitsigns').setup()
            end
        }
        use 'tpope/vim-fugitive'
        use 'sindrets/diffview.nvim'

        -- Colors
        use 'gruvbox-community/gruvbox'
        use 'ayu-theme/ayu-vim'
        use 'marko-cerovac/material.nvim'

    end
}
