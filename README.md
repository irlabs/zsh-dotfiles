# the ZSH .dotfiles

These are my extremely useful dotfiles for the **zsh** shell.
(Dotfiles are hidden files, whose filenames start with a `.` dot. The dotfiles are sourced whenever you start a command line session. And these dotfiles are really useful, containing a lot of smart things, shortscuts and nice colors.)

These instructions can be applied to both the **Terminal** app or the **iTerm** app.

## Step 1: install **zsh** as your default shell

### option A: in macOS's **Terminal** app

- Start the **Terminal** app
- open the **Preferences** window,
- the **General** tab.
- There where it says "**Shells open with:**",
- select "**Command (complete path)**"
- and type: `/bin/zsh`

### option B: in **iTerm2** app

- Start the **iTerm** app
- open the **Preferences** window,
- go to the **Profiles** tab,
- select the Profile that you want to modify (or create a new Profile, and *Set as Default*)
- the **General** tab.
- Under the "**Command**" haeder,
- select "**Command:**"
- and type: `/bin/zsh --login`

From then on, every new Terminal or iTerm window or tab you'll open, will be starting the zsh shell. Hurray!

## Step 2: install the *dot files* in your root folder

Then you'll need to install these dotfiles in your root folder in order to use them:

- Go to your root directory if you weren't there yet:
	- `cd ~`
- Download the dotfiles by:
	- `curl -sL https://github.com/irlabs/zsh-dotfiles/raw/master/zsh_dotfiles.tar > zsh_dotfiles.tar`
- Unpack and install the dotfiles:
	- `tar -xzf zsh_dotfiles.tar`
	
Then, from then on, every time you start a zsh shell, these dotfiles will be loaded and you can enjoy the nice colored prompt, handy shortcuts like `l` and `ll` and colored outputs for file lists, and, and ...

## Step 3: Set up the **Alt + .** key

### option A: in macOS's **Terminal**: Use the Alt key as Meta key

- In the **Terminal** app
- open the **Preferences** window,
- go to the **Profiles** tab.
- Select the **Keyboard** section.
- Make sure that all the profiles that you are using have:
- the checkbox **Use Option as Meta key** enabled.

### option B: in the **iTerm2** app

- In the **iTerm** app
- open the **Preferences** window,
- go to the **Keys** tab,
- click the **+** button to create a new *Key Mapping*
	- As *Keyboard Shortcut* set **Alt + .**
	- As *Action* choose **Send Escape Sequence** 
	- As *Esc+* set **.**

![iTerm Key Mapping Settings](images/iTermAltDotSettings.png)

Once you changed these settings for the Alt key, (or specifically for Alt + . ) you can use **Alt + .** to repeat the *last part* of your *previous* commands. E.g. If you type

```zsh
touch my_new_test_file.txt
```

(This command creates a new empty file, called _my_new_test_file.txt_ or if that one already exists, updates the modification date.)

Then as the next command you might want to open it in the default app with `open`. To do this you can type

```zsh
open 
```

, followed by **Alt + .**

The **Alt + .** will repeat the last part of the previous command, in this case the file name `my_new_test_file.txt` so your command becomes

```zsh
open my_new_test_file.txt
```

Repeat **Alt + .** to browse through your whole history of commands.

Useful!
