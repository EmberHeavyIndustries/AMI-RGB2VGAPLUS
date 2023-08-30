# AMI-RGB2VGAPLUS
Double buffered, impedance matched, no vertical lines VGA adapter for all Amigas


**If you like this project and want to contribute to its further development, please consider donate some $ or € (paypal friends & family, please or DO NOT select "Buying something" from money transfer frontpage).** 

| [![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/mrkbrr)||[![Email, Contacts & Requests](https://github.com/EmberHeavyIndustries/Depot/blob/master/Pics/EmailSticker.jpg?raw=true)](mailto:EmberHEavyIndustries@gmail.com)|
| ------------------------------ | ---------------------------------------------- | --------------------------- |


[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)


# AMI-RGB2VGAPLUS is a **"revised" RGB to VGA adapter** for the Amiga A500-A600-A2000 and A1200-A4000, with unique improvements:

- Fully buffered Composite HSync and VSync signals
- Impedance matched inputs and outputs
- Fully high quality buffered video signals
- Fully filtered spurious input frequencies: no more vertical bars on LCD screens !
- Smaller than the original 390682-01/03 VGA dongle by commodore

# NOTE for makers:

The pcb can be fitted with either TI7316 (as in the BOM) or with TI7314 (or any other else 1:1 pin compatible video filter/amplifier chip, there are plenty of them on the market)

Both the 7314 and 7316 are virtually identical, except for the analog video “low-pass” filter. 

7316 has a low pas filter with 36Mhz rolloff, which makes it best fitting for resolutions as up to 720p/1080i and AGA machines (if speaking of Commodore Amiga)

7314 has a low pas filter with 7,5Mhz rolloff, which makes it best fitting for lower resolutions and best fits OCS/ECS machines (but of course with some loss in details on higher resolutions)

![Image of RGB2VGA2-01](https://github.com/EmberHeavyIndustries/AMI-RGB2VGAPLUS/blob/main/Docs/RGB2VGAPLUS_small,jpg.jpg)

# SCHEMATICS

Full schematics can be found here

[RGB2VGAPLUS Schematics](https://github.com/EmberHeavyIndustries/AMI-RGB2VGAPLUS/blob/main/Hardware/Schematic_RGB2VGA_V2_2023-01-26.pdf)

# MAKER's FILES

[Full RGB2VGAPLUS BOM](https://github.com/EmberHeavyIndustries/AMI-RGB2VGAPLUS/blob/main/Hardware/BOM_PCB_RGB2VGA_V2_2023-01-01.csv) and [GERBER files](https://github.com/EmberHeavyIndustries/AMI-RGB2VGAPLUS/blob/main/Hardware/Gerber_PCB_RGB2VGA_V2_2023-01-01.zip) can be freely downloaded.
Also check PIck&Place report inside the Hardware directory, if needed

