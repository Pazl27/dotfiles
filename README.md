[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&size=30&letterSpacing=tiny&duration=2000&pause=3000&color=F7F7F7&center=true&vCenter=true&width=435&lines=Pazl's+Dotfiles)](https://git.io/typing-svg)

# Description
This repository contains my personal dotfiles. The hole configuration is based around the colortheme **gruvbox**.
This is my first attempt on a linux rice. I'm using Hyprland as my window manager.
This repostory contains configurations for the applications I use on a daily basis.
It also contains a `.ideavimrc` file for the Vim emulation in IntelliJ IDEA.
This configuration is used on my school laptop. I'm mostly using it for programming and browsing the web.
It also conations my neovim configuration which is set up to work with go, python, rust and c++.

# Preview
![Screenshot](./screenshots/main.png)
![Screenshot](./screenshots/secound.png)
![Screenshot](./screenshots/nvim.png)
![Screenshot](./screenshots/yazi.png)

# Applications

<details>
  
  <summary>Waybar</summary>
   <img src="./screenshots/waybar.png" alt="Waybar Screenshot">

   ## Overview
   This is my Waybar setup for Hyprland, designed to be clean and efficient. It includes all the essential features I wanted in Waybar. For additional needs like volume control, I use swaync, which can be     triggered from Waybar. It is possible to take screenshot, use a color picker or mute the microphone. 

   ## Workspaces

   ## Expanding Widgets 

   ## Wifi and Bluetooth

</details>

<details>
  
  <summary>Rofi</summary>
  
   ## Overview
   This is my roif setup. It is mainly used for launching apps and ssh connections. 
   <img src="./screenshots/rofi.png" alt="Rofi Screenshot">

  ### *How To Install*
  
1. **Install `Rofi`:**

   ```
    sudo pacman -S rofi-wayland
   ```
   
2. Copy the `Dotfiles/.config/rofi` folder into `~/.config`
3. **Launching Rofi**
    - I launch rofi like this:
   
      ```config
      rofi -show drun 
      ```

</details>

<details>
  
  <summary>Swaync</summary>
   <img src="./screenshots/swaync.png" alt="Swaync Screenshot">

</details>

<details>
  
  <summary>Neovim</summary>
   <img src="./screenshots/nvim.png" alt="Nvim Screenshot">

</details>

<details>
  
  <summary>Wlogout</summary>
   <img src="./screenshots/wlogout.png" alt="Wlogout Screenshot">

</details>


<details>
  
  <summary>Wallpapers</summary>
  
  ## Overview
  
  I use swww to manage and display all my wallpapers seamlessly.

  Most of my Gruvbox wallpapers come from this excellent [repo](https://github.com/AngelJumbo/gruvbox-wallpapers).
  To easily switch between these wallpapers, I utilize a Rofi script bound to the shortcut `Super + G`. This launches a menu listing all available wallpapers, allowing quick and convenient selection.
  

  ### Dependencies
  Make sure you have the following installed:
  ```
  rofi-wayland
  swww
  ```

</details>

# Installation
1. Clone the repository
```bash
cd ~
git clone https://github.com/Pazl27/dotfiles.git
```
2. Make shure you have the application installed that you want to use.
3. Copy the configuration files to the `.config` directory
```bash
cd dotfiles
cp -r -f .config/[dir_you_want_to_copy] ~/.config/
```
If you have existing configuration files you want to keep, make a backup of them before copying the new ones.
