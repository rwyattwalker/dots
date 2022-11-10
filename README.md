<div align="center">
    <h1>Awesome Dotfiles</h1>
</div>

<div align="center">
    <h3>Screenshots</h3>
</div>

![](/screenshots/Desktop.png)

<a name="details"></a>
## Details ##
+ **Shell**: ZSH
+ **WM**: Awesome (git version)
+ **File Manager**: Nemo
+ **Theme**: Adwaita Dark
+ **Icons**: Papirus Dark
+ **Terminal**: Alacritty

<a name="features"></a>
## Features ##
+ Extremely lightweight
+ Easy installation / configuration
+ Very few dependencies
+ Exit screen
+ Lock screen
+ Multi monitor friendly
  + The top bar appears on every monitor, each monitor has it's own set of tags

<a name="dependencies"></a>
## Dependencies ##

|Dependency|Description|
|:----------:|:-------------:|
|`awesome`|Window manager - must use the git version or the setup will not work|
|`feh`|Fastsed as wallpaper setting utility|
|`picom-jonaburg-git`|Window compositor|
|`rofi`|Application launcher|

### Recommended Dependencies ###
|Dependency|Description|
|:----------:|:-------------:|
|`spicetify`|For customizing spotify (install details below)|
|`ZSH`| You want this bro (install details below)|
|`nvim`|Highly Desirable|

### Recomended Tools ###
+ `i3lock`: Screen locking
+ `scrot`: Screenshot tool
+ `feh`: Wallpaper setting utility

<a name="installation"></a>
### Installation ###
1. Ensure all dependencies and desired recommended dependencies are met
2. Clone this repository and place the alacritty, awesome, nvim, and spicetify directories into your `.config` folder
3. Replace your ~/.p10k.zsh file with the one from this repo.
4. CD into your ~/.config/awesome directory and run this command: ``` git clone https://github.com/streetturtle/awesome-buttons ```
4. Figure out why it doesn't work 😳 (jk...but some tinkering may be required to make everything work with your setup)

### Spotify ###
1. Make sure you have spotify installed
2. [Install `Spicetify`](https://github.com/khanhas/spicetify-cli)
3. chown spotify directory: `sudo chown $USER -R /opt/spotify`
4. run `spicetify` once to generate config
5. `spicetify backup apply enable-devtool` to enable devtools
6. Copy my spicetify folder to `~/.config`
7. run `spicetify update restart`

### Zsh ###
1. Install oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
2. Change the zsh theme to powerlevel10k
  + Download [this font](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf), and move it into your `/usr/share/fonts` directory
  + Install powerlevel10k with the command below:
  ```
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
  ```
  + Open `~/.zshrc` with your fave text editor
  + Set `ZSH_THEME="powerlevel10k/powerlevel10k"` and save the file
3. Install Plugins (Note that the ~/.zshrc edits are already done in this repo)
  + Syntax highlighting (copy and paste the below command to install)
    ```
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    ```
    + Edit `~/.zshrc`, add `zsh-syntax-highlighting` to the plugins section
  + Autosuggestions (copy and paste the below command to install)
    ```
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```
    + Edit `~/.zshrc`, add `zsh-autosuggestions` to the plugins section

<a name="keybinds"></a>
## Keybinds ##
### Keyboard ###
+ `mod + enter`: Spawn terminal
+ `mod + d`: Spawn rofi (an application menu)
+ `mod + f`: Make client fullscreen
+ `mod + m`: Maximize client
+ `mod + n`: Minimize client
+ `mod + shift + n`: Unminimize client
+ `mod + [1-9]`: Switch to tag [1-9]
+ `mod + shift + [1-9]`: Move client to tag [1-9]
+ `mod + space`: Change the tag layout, alternating between tiled, floating, and maximized
+ `mod + [up / down / left / right / h / j / k / l]`: Change client by direction
+ `mod + Shift + [up / down / left / right / h / j / k / l]`: Move client by direction
+ `mod + Control + [up / down / left / right / h / j / k / l]`: Resize client by direction
+ `mod + Escape`: Show exit screen

### Mouse ###
+ `mod + drag with left click`: Move client
+ `mod + drag with right click`: Resize client

<a name="notes"></a>
## Notes ##
+ The Wibar is hard coded using negative margins for the placement, this is specific to my screen so you will probably need to change the margins in `components/top-bar`
+ If you have issues during the install or if I missed anything in the instructions, feel free to open an issue and let me know, I will do my best to investagte and update instructions accordingly
+ If you find these dots useful, please consider leaving a star, it costs nothing and helps me look cool! 😎 
