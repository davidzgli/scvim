# 🚀 Simple Vim Configuration for System Administrators

A carefully curated, minimal vim configuration designed for system administrators who need efficiency without complexity. This configuration focuses on essential plugins and sensible defaults that enhance productivity while maintaining vim's core philosophy.

## 📦 Installation

Clone this repository to your home directory as `.vim`:

```bash
git clone https://github.com/davidzgli/scvim.git ~/.vim
```

Open vim and install the plugins:

```bash
vim
:PlugInstall
```

## ⚙️ Basic Configuration

This configuration includes the following essential settings:

### Appearance & Colors
- **Syntax highlighting** enabled
- **Line numbers** with relative numbering for easier navigation
- **Current line highlighting** to track cursor position
- **24-bit RGB color support** for better color schemes
- **Visual command completion** in command-line mode

### Editor Behavior
- **Mouse support** enabled in all modes
- **Smart search**: incremental search with case-insensitive matching (unless capitals are used)
- **Tab settings**: 4-space tabs, spaces instead of tabs, smart indentation
- **Extended history**: remembers 1000 commands and search patterns
- **Filetype detection** with automatic indentation
- **Leader key**: spacebar for easy access to custom commands
- **Quick mode switching**: `jj` to exit insert mode

## 🔌 Installed Plugins

### Color Schemes

#### 🎨 OneDark
**Repository**: [joshdick/onedark.vim](https://github.com/joshdick/onedark.vim)

A modern, readable color scheme with pleasant contrast, inspired by Atom's One Dark theme.

#### 🎨 Gruvbox (Currently Active)
**Repository**: [morhetz/gruvbox](https://github.com/morhetz/gruvbox)

A retro groove color scheme with warm colors and excellent contrast. Perfect for long coding sessions.

**Switch color schemes**:
```vim
:colorscheme onedark
:colorscheme gruvbox
```

---

### Navigation & Movement

#### ⚡ EasyMotion
**Repository**: [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion)

Lightning-fast navigation with just a few keystrokes. EasyMotion highlights all possible destinations and allows you to jump directly to any location.

**Basic Usage**:
- `<space><space>w` - Jump to any word
- `<space><space>f{char}` - Jump to any character
- `<space><space>s{char}` - Bidirectional search for character
- `<space><space>j` - Jump to any line below
- `<space><space>k` - Jump to any line above

**Examples**:
```vim
" Jump to the word 'function'
<space><space>wf  " Then press the highlighted letter

" Find all occurrences of 'a'
<space><space>fa  " Then press the highlighted letter to jump

" Search for 'th' in both directions
<space><space>sth  " Then press the highlighted letter
```

**Command Mode**:
```vim
" Enable smartcase (match 'v' and 'V' when typing 'v')
let g:EasyMotion_smartcase = 1

" Change the default leader from <space><space> to <space>
map <space> <Plug>(easymotion-prefix)
```

#### 👟 Sneak
**Repository**: [justinmk/vim-sneak](https://github.com/justinmk/vim-sneak)

Jump to any location specified by two characters. More precise than `f` and works across multiple lines.

**Basic Usage**:
- `s{char}{char}` - Jump to next occurrence of two characters
- `S{char}{char}` - Jump to previous occurrence
- `;` - Repeat last sneak forward
- `,` - Repeat last sneak backward
- `s<Enter>` - Repeat last search

**Examples**:
```vim
" Jump to next 'th'
sth

" Jump to next 'function' by typing 'fu'
sfu

" Delete up to the third occurrence of 'ab'
3dzab

" Search backwards for 'en'
Sen
```

**Command Mode**:
```vim
" Enable label mode (like EasyMotion)
let g:sneak#label = 1

" Replace f with sneak
map f <Plug>Sneak_s
map F <Plug>Sneak_S
```

---

### Editing & Text Manipulation

#### 💬 Commentary
**Repository**: [tpope/vim-commentary](https://github.com/tpope/vim-commentary)

Easy commenting and uncommenting with simple keystrokes.

**Basic Usage**:
- `gcc` - Toggle comment for current line
- `gc{motion}` - Toggle comment for motion (e.g., `gcap` for paragraph)
- `gc` - Toggle comment for selection (visual mode)

**Examples**:
```vim
" Comment/uncomment current line
gcc

" Comment next 3 lines
gc3j

" Comment a paragraph
gcap

" Comment inside parentheses
gci)

" Comment from cursor to end of line
gc$
```

**Command Mode**:
```vim
" Comment lines 5-10
:5,10Commentary

" Comment all TODO lines
:g/TODO/Commentary
```

**Uncomment**: All the same commands work for uncommenting - they toggle the comment state.

#### 🔧 DelimitMate
**Repository**: [Raimondi/delimitMate](https://github.com/Raimondi/delimitMate)

Automatically adds closing brackets, parentheses, quotes, and other delimiters as you type.

**Features**:
- Auto-closes `()`, `[]`, `{}`, `""`, `''`
- Smart deletion of delimiter pairs
- Works with various filetypes

---

### Terminal & Session Management

#### 🖥️ Vimux
**Repository**: [preservim/vimux](https://github.com/preservim/vimux)

Seamlessly interact with tmux from vim. Perfect for system administrators who need to run commands without losing focus in their editor.

**Features**:
- Creates a 20% tall horizontal tmux pane for command execution
- Runs commands without losing vim focus
- Easy re-running of previous commands
- Ideal for testing scripts, running builds, or monitoring logs

**Basic Usage**:
- `:VimuxRunCommand "command"` - Run any shell command in tmux pane
- `:VimuxRunLastCommand` - Re-execute the most recent command
- `:VimuxCloseRunner` - Close the tmux runner pane
- `:VimuxInspectRunner` - Move cursor to tmux runner pane

**Key Mappings** (using spacebar as leader):
- `<space>vl` - Run current line in tmux pane
- `[count]<space>vj` - Run current line + count lines below (default: 3)
- `[count]<space>vk` - Run current line + count lines above (default: 3)
- `[count]<space>va` - Run current line + count lines above and below (default: 3)
- `<space>vp` - Run current paragraph (blank line separated)
- `<space>vv` - Run visual selection (visual mode)
- `<space>vr` - Re-run last command
- `<space>vc` - Close tmux runner pane
- `<space>vi` - Inspect tmux runner pane

**Examples**:
```vim
" Run a system command
:VimuxRunCommand "systemctl status nginx"

" Monitor log files
:VimuxRunCommand "tail -f /var/log/syslog"

" Run a script and keep it visible
:VimuxRunCommand "./deploy.sh"

" Re-run the last command
:VimuxRunLastCommand

" Interactive usage examples:
" 1. Place cursor on 'ls -la' and press <space>vl
" 2. Select multiple commands and press <space>vv
" 3. Use 4<space>vj to run current line + 4 below
" 4. Use 2<space>va to run current line + 2 above and below
" 5. Use <space>vp to run entire script block
```

**Useful for System Administrators**:
- Running diagnostic commands while editing configs
- Monitoring services during configuration changes
- Testing scripts without leaving the editor
- Quick access to system logs and status

**Requirements**: Requires tmux to be installed and running.

---

### Status & Interface

#### ✈️ Airline
**Repository**: [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)

A nice, informative status line that shows:
- Current mode (NORMAL, INSERT, VISUAL, etc.)
- File name and modification status
- File type and encoding
- Current line and column position
- Git branch (if in a git repository)

#### 🎨 Airline Themes
**Repository**: [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)

Theme collection for vim-airline. The theme automatically matches your color scheme.

---

## 🎯 Quick Start Guide

### Most Useful Commands for New Users

1. **Fast Navigation**:
   ```vim
   <space><space>w      " Jump to any word
   sth                  " Jump to next 'th'
   ```

2. **Quick Commenting**:
   ```vim
   gcc                  " Comment/uncomment line
   gcap                 " Comment/uncomment paragraph
   ```

3. **Terminal Integration**:
   ```vim
   <space>vl            " Run current line in tmux
   4<space>vj           " Run current + 4 lines below
   <space>vp            " Run current paragraph in tmux
   <space>vr            " Re-run last command
   ```

4. **Efficient Editing**:
   ```vim
   ci"                  " Change inside quotes
   di(                  " Delete inside parentheses
   ```

### Tips for Productivity

- Use relative line numbers: `5j` jumps down 5 lines, `3k` jumps up 3 lines
- Combine motions: `d2w` deletes 2 words, `c3j` changes 3 lines down
- Use EasyMotion for long jumps, Sneak for short precise movements
- `<Leader>` is set to spacebar for easy access

## 🔧 Customization

### Leader Key Configuration

The leader key is set to spacebar for easy access. This configuration is already included in the vimrc:

```vim
let mapleader = " "  " Spacebar as leader key
```

You can change it to other keys if preferred:

```vim
let mapleader = ","  " Use comma as leader
let mapleader = ";"  " Use semicolon as leader
```

### Plugin-specific Configurations

Add these to your vimrc for enhanced functionality:

```vim
" EasyMotion: Use single leader instead of double
map <space> <Plug>(easymotion-prefix)

" Sneak: Enable label mode
let g:sneak#label = 1

" EasyMotion: Enable smartcase
let g:EasyMotion_smartcase = 1

" Additional key mappings
inoremap jk <Esc>    " Alternative to jj for exiting insert mode
```

## 📋 Plugin Management

This configuration uses [vim-plug](https://github.com/junegunn/vim-plug) for plugin management.

**Common Commands**:
- `:PlugInstall` - Install plugins
- `:PlugUpdate` - Update all plugins
- `:PlugClean` - Remove unused plugins
- `:PlugStatus` - Check plugin status

## 🆘 Getting Help

- `:help easymotion` - EasyMotion documentation
- `:help sneak` - Sneak documentation
- `:help commentary` - Commentary documentation
- `:help airline` - Airline documentation

## 🤝 Contributing

Feel free to fork this configuration and customize it to your needs. This setup prioritizes simplicity and essential functionality - perfect for getting productive with vim quickly while maintaining the power to grow your configuration over time.

---

**Happy Vimming!** 🚀