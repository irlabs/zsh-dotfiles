# the ZSH .dotfiles

These are my extremely useful dotfiles for the **zsh** shell.
(Dotfiles are hidden files, whose filenames start with a `.` dot. The dotfiles are sourced whenever you start a command line session. And these dotfiles are really useful, containing a lot of smart things, shortscuts and nice colors.)

## Installing zsh as your default shell

(On Mac OS X)

- Start the **Terminal** app
- open the **Preferences** window,
- the **General** tab.
- There where it says "**Shells open with:**",
- select "**Command (complete path)**"
- and type: `/bin/zsh`

From then on, every Terminal window or tab you'll open, will be starting the zsh shell. Hurray!

## Installing the dot files in your root folder

Then you'll need to install these dotfiles in your root folder in order to use them:

- Go to your root directory if you weren't there yet:
	- `cd ~`
- Download the dotfiles by:
	- `curl .... > zsh_dotfiles.tar`
- Unpack and install the dotfiles:
	- `tar -xzf zsh_dotfiles.tar`
	
Then, from then on, every time you start a zsh shell, these dotfiles will be loaded and you can enjoy the nice colored prompt, handy shortcuts like `l` and `ll` and colored outputs for file lists, and, and ...