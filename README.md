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
- `<Leader><Leader>w` - Jump to any word
- `<Leader><Leader>f{char}` - Jump to any character
- `<Leader><Leader>s{char}` - Bidirectional search for character
- `<Leader><Leader>j` - Jump to any line below
- `<Leader><Leader>k` - Jump to any line above

**Examples**:
```vim
" Jump to the word 'function'
<Leader><Leader>wf  " Then press the highlighted letter

" Find all occurrences of 'a'
<Leader><Leader>fa  " Then press the highlighted letter to jump

" Search for 'th' in both directions
<Leader><Leader>sth  " Then press the highlighted letter
```

**Command Mode**:
```vim
" Enable smartcase (match 'v' and 'V' when typing 'v')
let g:EasyMotion_smartcase = 1

" Change the default leader from <Leader><Leader> to <Leader>
map <Leader> <Plug>(easymotion-prefix)
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
   <Leader><Leader>w    " Jump to any word
   sth                  " Jump to next 'th'
   ```

2. **Quick Commenting**:
   ```vim
   gcc                  " Comment/uncomment line
   gcap                 " Comment/uncomment paragraph
   ```

3. **Efficient Editing**:
   ```vim
   ci"                  " Change inside quotes
   di(                  " Delete inside parentheses
   ```

### Tips for Productivity

- Use relative line numbers: `5j` jumps down 5 lines, `3k` jumps up 3 lines
- Combine motions: `d2w` deletes 2 words, `c3j` changes 3 lines down
- Use EasyMotion for long jumps, Sneak for short precise movements
- Remember that `<Leader>` is typically `\` (backslash)

## 🔧 Customization

### Changing the Leader Key

By default, `<Leader>` is `\`. You can change it by adding this to the top of your vimrc:

```vim
let mapleader = ","  " Use comma as leader
" or
let mapleader = " "  " Use space as leader
```

### Plugin-specific Configurations

Add these to your vimrc for enhanced functionality:

```vim
" EasyMotion: Use single leader instead of double
map <Leader> <Plug>(easymotion-prefix)

" Sneak: Enable label mode
let g:sneak#label = 1

" EasyMotion: Enable smartcase
let g:EasyMotion_smartcase = 1
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