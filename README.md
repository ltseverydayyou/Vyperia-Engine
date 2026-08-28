# Friday Night Funkin' - Vyperia Engine

Vyperia Engine is a performance-focused fork of **OS Engine**, which itself is based on **Psych Engine**. The original OS Engine and Psych Engine credits are preserved below.

## Vyperia Engine

- Maintained by [ltseverydayyou](https://github.com/ltseverydayyou)
- Focused on dense-chart performance, memory cleanup, gameplay-side control, HUD customization, and chart-editor reliability.
- Repository: [ltseverydayyou/Vyperia-Engine](https://github.com/ltseverydayyou/Vyperia-Engine)

### Vyperia additions

- Fixed judgement/combo popup objects accumulating in the gameplay state after note hits.
- Player, Opponent, and Both play modes.
- Pause-menu play-mode switching.
- Judgement popup, combo popup, note splash, and miss-SFX controls.
- HUD scale and opacity controls.
- Safer chart section copy/paste behavior across BPM and section-length changes.

---

![](https://media.discordapp.net/attachments/969211146412363828/980124443164672000/23336ff517a80f27.png?width=1101&height=701)
# Friday Night Funkin' - OS Engine - Modded Psych Engine 
![](https://img.shields.io/github/issues/notweuz/FNF-OSEngine) ![](https://img.shields.io/github/forks/notweuz/FNF-OSEngine) ![](https://img.shields.io/github/stars/notweuz/FNF-OSEngine) ![](https://img.shields.io/github/license/notweuz/FNF-OSEngine) ![GitHub all releases](https://img.shields.io/github/downloads/notweuz/FNF-OSEngine/total) ![GitHub repo size](https://img.shields.io/github/repo-size/notweuz/FNF-OSEngine) ![](https://img.shields.io/github/contributors/notweuz/FNF-OSEngine) ![GitHub release (latest by date)](https://img.shields.io/github/downloads/notweuz/FNF-OSEngine/latest/total)

## Installation and using mods

There are two different ways to use Vyperia Engine. Pick the one that matches what you downloaded:

- a finished build, usually a ZIP containing an EXE
- the engine source code, which is this GitHub repository

### If you only want to play a finished mod

If a mod creator gave you a ZIP or a folder containing an EXE, the mod is already compiled. You do not need Haxe, LuaJIT, Visual Studio, or the Vyperia source code just to play it.

1. Download the mod from the creator's official download page.
2. Extract the entire ZIP. Right-click it, choose **Extract All**, and pick a normal folder such as your Desktop. Do not run the game directly from inside the ZIP.
3. Open the extracted folder and run the EXE. If there is more than one EXE, use the one mentioned by the mod's own README.
4. Keep the EXE and its folders together. Folders such as `assets`, `mods`, `songs`, or `data` are often required for the game to start.

If Windows asks for permission or shows a SmartScreen warning, only continue when you trust where the file came from. If the game closes immediately, check the mod's included README first; the build may require a specific engine version or extra files.

A finished mod build should normally be played by itself. Do not copy its EXE into another Psych Engine installation and expect that installation to become Vyperia.

### Using an existing Psych Engine mod with Vyperia

Vyperia is an engine fork, so you run the mod with the Vyperia build. You do not install Vyperia inside a Psych Engine EXE.

This method is for a mod's source/assets, not for a finished EXE-only download:

1. Close the game and make a backup of both the mod and your Vyperia folder.
2. Open the mod's folder and look at its layout. Depending on the Psych Engine version, it may contain an `assets` folder, a `mods` folder, or folders such as `songs`, `data`, `images`, `characters`, `stages`, `scripts`, `sounds`, `music`, `videos`, and `weeks`.
3. Copy the mod's files into the matching folders used by Vyperia. If the mod contains an `assets` folder, open both `assets` folders and merge their contents. Do not accidentally create `assets/assets`.
4. If Windows asks whether to merge folders, allow the merge. Only replace files when they belong to the mod you are installing.
5. Start the Vyperia build and test the mod. If it loads but a song, character, or stage is missing, the files are usually in the wrong folder or the names do not match the chart exactly.

For example, a mod folder may look like this:

```text
MyMod/
├── characters/
├── data/
├── images/
├── music/
├── scripts/
├── songs/
├── sounds/
├── stages/
├── videos/
└── weeks/
```

Keep the mod's folder structure intact. A file from `songs` should stay in the corresponding `songs` folder, a character file should stay with the character files, and so on.

### Replacing an installed Psych Engine mod

If you already have a Psych Engine mod installed and want to try it with Vyperia:

- Start with a clean copy of Vyperia.
- Move or merge the mod's content into the matching Vyperia folders as described above.
- Run the Vyperia EXE, not the old Psych Engine EXE.
- Do not replace Vyperia's entire `source` folder, `Project.xml`, or `assets` folder with the ones from another engine. Those contain engine files and replacing them can break the build.
- If the mod includes custom Haxe `.hx` source changes, it is a source-code port rather than a simple file copy. Those changes may need to be added manually before compiling Vyperia.

Some older OS Engine builds use a Polymod layout with `assets/MODS`, a `pack.json`, and a `modList.txt` file. If the build you are using includes that loader, follow the mod's layout and add the mod folder name to `modList.txt`, then restart the game. The mod loader is still a work in progress, so a mod that depends on a different loader or engine version may need to be ported manually.

### Building Vyperia Engine from source

You only need this section if you want to compile the engine yourself or edit its source code.

1. Install [Haxe 4.2.4](https://haxe.org/download/). Other Haxe versions may cause library or build errors.
2. Download or clone this repository, then open Command Prompt or PowerShell in the repository folder.
3. Install the LuaJIT library:

```text
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit
```

4. Build and run the Windows version:

```text
haxelib run lime test windows
```

LuaJIT is needed for mods that use Lua scripts. If you intentionally do not want Lua support, remove the `LUA_ALLOWED` line from `Project.xml`.

For video support, install hxCodec before building:

```text
haxelib install hxCodec
```

If you get a `StatePointer` error while using Lua, remove and reinstall LuaJIT:

```text
haxelib remove linc_luajit
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit
```

### Common problems

- **The game cannot find songs, images, or characters:** make sure you extracted the complete mod and merged the inner folders instead of creating an extra folder level.
- **The mod crashes or closes immediately:** it may require a different Psych Engine/OS Engine version, a missing library, or custom source changes.
- **Lua errors appear:** reinstall `linc_luajit` and make sure Lua support is enabled in `Project.xml`.
- **Videos do not play:** install `hxCodec` and rebuild the engine when working from source.
- **You only received an EXE:** you cannot reliably port that build by copying random files. Look for the mod's source code or use the finished build as provided.

## OS Engine Credits:
* [weuz_](https://github.com/notweuz) - Coding
* [nelifs](https://github.com/nelifs) - Coding and Design
* [Cooljer](https://github.com/cooljer) - Arts

### OS Engine Special Thanks
* [jonnycat](https://github.com/McJonnycat) - Fixing bugs in Engine <3.
* [Kade Engine](https://gamebanana.com/mods/44291) - Circle Note Skin

## Psych Engine Credits:
* Shadow Mario - Programmer
* RiverOaken - Artist
* Yoshubs - Assistant Programmer

### Psych Engine Special Thanks
* bbpanzu - Ex-Programmer
* shubs - New Input System
* SqirraRNG - Crash Handler and Base code for Chart Editor's Waveform
* KadeDev - Fixed some cool stuff on Chart Editor and other PRs
* iFlicky - Composer of Psync and Tea Time, also made the Dialogue Sounds
* PolybiusProxy - .MP4 Video Loader Library (hxCodec)
* Keoiki - Note Splash Animations
* Smokey - Sprite Atlas Support
* Nebula the Zorua - LUA JIT Fork and some Lua reworks & VCR Shader code
_____________________________________

# Features

## Psych Engine Features

OS Engine is a fork of Psych Engine, so you can use almost every feature from Psych Engine in OS Engine!

## OS Engine Features

### Psych Engine mods compability
Yes, almost every mod for Psych Engine runs on OS Engine.

### Note Skins
OS Engine adds a note skins system! There's only Default and Circle skins by default.

![](https://media.discordapp.net/attachments/969211146412363828/969211181728399420/unknown.png)

### Showcase Mode
This feature hides HUD and enables botplay. So you can showcase any mod without any problems.

![](https://media.discordapp.net/attachments/969211146412363828/969211657307951104/unknown.png)

### Hide Score Text
This feature hides score text under health bar. Idk why you need to use it.

![](https://media.discordapp.net/attachments/969211146412363828/969211797993299979/unknown.png)

### Perfect!! Judgement
Adds Perfect!! Judgement. It's better than sick. Btw you can disable it in settings if you want.

![](https://media.discordapp.net/attachments/969211146412363828/969213039230455838/unknown.png)
![](https://media.discordapp.net/attachments/969211146412363828/969212313410351134/unknown.png?width=1440&height=190)

### Lane Underlay
You can set lane underlay transparency under arrows by using that functions.

![](https://media.discordapp.net/attachments/969211146412363828/969212761605296198/unknown.png?width=465&height=676)
![](https://media.discordapp.net/attachments/969211146412363828/969212421887635546/unknown.png?width=1440&height=326)

### Custom Settings in Chart Editor.
There's multiple new functions in chart editor. Like player/opponent trail, camera move and etc.

![](https://media.discordapp.net/attachments/969211146412363828/969213936924774430/unknown.png)

### Literally Useless Exit Game State
Now you can press ESC at title state. And game will ask you do you want to close game or no

![](https://media.discordapp.net/attachments/969211146412363828/969214715702177812/unknown.png?width=1202&height=676)

### Bit Changed Main Menu State

![](https://media.discordapp.net/attachments/969211146412363828/969214974369099807/unknown.png)

### Winning icons 
Instead of 2 icons, there'll be three icons (losing, normal, winning). And yes, you can use double icons (without winning).

![](https://github.com/weuz-github/FNF-OSEngine/blob/main/assets/preload/images/icons/icon-bf.png?raw=true)

*thanks Cooljer for remaking original fnf icons*

### Shaders
Returned shaders from old psych engine versions. Now you can make your bambi mods.

### Custom Title State
Bit changed Title State. Now it looks way more better.

![](https://media.discordapp.net/attachments/969211146412363828/969215626126196797/unknown.png?width=1202&height=676)

### Striped Health Bar
Cassette Girl vibes?

![](https://media.discordapp.net/attachments/969211146412363828/969218236950397038/unknown.png)
