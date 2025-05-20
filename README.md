[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&size=30&letterSpacing=tiny&duration=2000&pause=3000&color=F7F7F7&center=true&vCenter=true&width=435&lines=Pazl's+Dotfiles)](https://git.io/typing-svg)

# Description
This repository contains my personal dotfiles. The hole configuration is based around the colortheme **gruvbox**.
This is my first attempt on a linux rice. I'm using Hyprland as my window manager.
This repostory contains configurations for the applications I use on a daily basis.
It also contains a `.ideavimrc` file for the Vim emulation in IntelliJ IDEA.
This configuration is used on my school laptop. I'm mostly using it for programming and browsing the web.
It also conations my neovim configuration which is set up to work with go, python, rust and c++.

# Preview
![Screenshot](./screenshots/snapshot_2025-05-20_02-30-26.png)
![Screenshot](./screenshots/snapshot_2025-05-20_02-38-14.png)
![Screenshot](./screenshots/snapshot_2025-05-20_02-47-28.png)

![Screenshot](./screenshots/snapshot_2025-05-20_02-23-44.png)

# Applications

<details>
  
  <summary>Waybar</summary>
   <img src="./screenshots/snapshot_2025-05-20_02-21-30.png" alt="Waybar Screenshot">

</details>

<details>
  
  <summary>Rofi</summary>
   <img src="./screenshots/snapshot_2025-05-20_02-26-01.png" alt="Rofi Screenshot">

   ## Configuration

  ### *How To Install*
  
1. **Install `Rofi`:**

   ```
    sudo pacman -S rofi-wayland
   ```
   
2. Copy the `Dotfiles/.config/wofi` folder into `~/.config`
3. **Launching Rofi**
    - I launch rofi like this:
   
      ```config
      rofi -show drun 
      ```

</details>

<details>
  
  <summary>Swaync</summary>
   <img src="./screenshots/snapshot_2025-05-20_02-21-30.png" alt="Waybar Screenshot">

</details>

<details>
  
  <summary>Neovim</summary>
   <img src="./screenshots/snapshot_2025-05-20_02-21-30.png" alt="Waybar Screenshot">

</details>

<details>
  
  <summary>Wlogout</summary>
   <img src="./screenshots/snapshot_2025-05-20_02-21-30.png" alt="Waybar Screenshot">

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
