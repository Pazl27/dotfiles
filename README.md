[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&size=30&letterSpacing=tiny&duration=2000&pause=3000&color=F7F7F7&center=true&vCenter=true&width=435&lines=Pazl's+Dotfiles)](https://git.io/typing-svg)

# Description
This repository contains my personal dotfiles. The hole configuration is based around the colortheme **gruvbox**.
This is my first attempt on a linux rice. I'm using Hyprland as my window manager.
This repostory contains configurations for the applications I use on a daily basis.
It also contains a `.ideavimrc` file for the Vim emulation in IntelliJ IDEA.
This configuration is used on my school laptop. I'm mostly using it for programming and browsing the web.
It also conations my neovim configuration which is set up to work with go, rust and c++.

# Preview
![Screenshot](./screenshots/main.png)
![Screenshot](./screenshots/secound.png)
![Screenshot](./screenshots/nvim.png)
![Screenshot](./screenshots/yazi.png)

# Applications

<details>
  
  <summary>Waybar</summary>
   <img src="./screenshots/waybar.png" alt="Waybar Screenshot">

   ### Overview
   This is my Waybar setup for Hyprland, designed to be clean and efficient. It includes all the essential features I wanted in Waybar. For additional needs like volume control, I use swaync, which can be     triggered from Waybar. It is possible to take screenshot, use a color picker or mute the microphone. 

  ### Workspaces
  I've configured the workspaces so that if a workspace contains any open content, its indicator dot appears in a lighter shade of red. This makes it easier to keep track of active workspaces. Initially, only 7         workspaces are displayed, but more are added dynamically as needed when you go beyond 7.
  
   <img src="./screenshots/workspaces.png" alt="Workspace Screenshot">

  ### Expanding Widgets 
  On the right side of the Waybar, you'll find the notification module (which opens SwayNC), the battery level, the music display, and the expanding widget.
  Inside the expanding widget, there are several useful tools and statistics. You can monitor key system stats such as temperature, disk space, and CPU usage.
  In addition, there are icons for taking screenshots and using a color picker. You can also adjust the screen brightness directly from this widget.
  
  <img src="./screenshots/expand.png" alt="Expanding Widget Screenshot">

  ### Wifi and Bluetooth
  On the left side of the Waybar, you'll find the following modules: power, clock, sound, Wi-Fi, and Bluetooth.
  Both the Bluetooth and Wi-Fi modules launch a Rofi script when clicked. These scripts make it easy to connect to devices or select and log into Wi-Fi networks.
  The sound module allows you to mute the microphone, and a right-click opens pulsemixer in a floating terminal window.
  The power module opens wlogout. 
  
  <img src="./screenshots/wifi-bluethooth.png" alt="Left Side Screenshot">

   ### *How To Install*
1. **Install `Waybar`:**

   ```
    sudo pacman -S waybar
   ```
   
2. Copy the `Dotfiles/.config/waybar` folder into `~/.config`


  ## Dependencies
  ```plaintext
  swaync
  grimblast
  hyprpicker
  wl-copy
  wlogout
  rofi
  pulsmixer
  kitty
  ```
   
</details>

<details>
  
  <summary>Rofi</summary>
  
   ### Overview
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

   ### *How To Install*
  
1. **Install `swaync`:**
   
    ```bash
    sudo pacman -S swaync
    ```
2. Copy the `Dotfiles/.config/swaync` folder into `~/.config`

  ### Dependencies for `Swaync`
  ```
  swaync
  rofi
  libnotify
  ```

</details>

<details>
  
  <summary>Neovim</summary>
   <img src="./screenshots/nvim.png" alt="Nvim Screenshot">

</details>

<details>
  
  <summary>Wlogout</summary>
   <img src="./screenshots/wlogout.png" alt="Wlogout Screenshot">
   
   ### *How To Install*
1. **Install `wlogout`:**
   
    ```bash
    yay -S wlogout
    ```
2. Copy `Dotfiles/.config/wlogout` into `~/.config/`
3. If not already set make sure you set a key bind in hyprland.conf to launch wlogout.

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

# Keyboard

I use a **Corne (crkbd) v4** keyboard — a split, column-staggered 40% layout with 3 layers. Mine is the **wired version**, and I got it from [KeebArt](https://www.keebart.com/de/produkte/corne). It's compact, ergonomic, and a joy to type on once you get used to the layering system.  

I use **Vial** to configure and flash my keymap. Vial makes it easy to customize layers, remap keys on the fly, and store changes directly in the keyboard’s memory.


## My Layer Setup

I use a total of **three layers**:

### Layer 0 – Typing Layer (QWERTZ)
This is my main typing layer, customized for the German QWERTZ layout. It includes standard alphanumeric keys and a few custom modifiers.

**Visual:**
![Layer 0 – Numbers & Symbols](screenshots/keyboard/layer0.png)

---

### Layer 1 – Numbers & Symbols  
This layer gives quick access to:
- Numbers (0–9)
- Common symbols like `!`, `=`, `#`, `*`, `&` etc.
- Brackets and mathematical operators

**Visual:**
![Layer 1 – Numbers & Symbols](screenshots/keyboard/layer1.png)

---

### Layer 2 – German Letters, Arrows & Media  
This layer adds:
- German-specific characters like `ä`, `ö`, `ü`, `ß`
- Symbols like `@`, `€`, etc.
- Arrow keys
- Media controls (volume, play/pause, etc.)

**Visual:**
![Layer 2 – Numbers & Symbols](screenshots/keyboard/layer2.png)

---


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
