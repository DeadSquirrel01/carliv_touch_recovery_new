**Carliv Touch Recovery**

- version 5.2 is for Lollipop (cm 12.1).
The version starting number is related to android version.

This is a CWM based recovery and I did put up some work to update it to lollipop (cm 12.1) after official cwm development stopped at kitkat. It works with *LOLLIPOP* kernels and it builds with cm 12.1. 
For gui I ported [PhilZ Recovery](http://forum.xda-developers.com/showthread.php?t=2201860) full touch module. 
Because the vold in cm 12.1 doesn't support cwm anymore I had to use the old *fstab1* type for functionality, although for building reason a valid recovery.fstab should be provided in device tree. In the last part there are some building hints to make it clear for those who want to try building it.

Features:
- EXT4 and F2FS by default, both built in.
- full touch menu ported by me from PhilZ touch Recovery. The old Napstar-xda touch module was good but it's quite old and to update that was too much work. Actually There is a version 4 with that touch module, all working, but the touch doesn't work with some input drivers and I had to give up on it for the new and improved version from PhilZ.
- all cwm functionalities are up and working (adb, sideload, backup, restore, install, mass storage...). There is no mtp and if your phone doesn't have an external sdcard you can't connect it to PC while is in recovery mode. But there is usb-otg support, of course if your phone was shipped with that.
- added new menu for backup and restore advanced, to use it for backing or restoring only a specific partition and I also ported from PhilZ the multizip flashing function.
- in *Carliv menu* there is now a new section for flashing boot and recovery images. It is in early stage but it works using the nandroid restore function (I'll improve this one later). All you need is to create a folder in your storage root or sdcard root and to place the images you want to flash in there: IMPORTANT use the name boot.img and recovery.img for them (in the future I'll rewrite this to use it with any name).
- for MTK phones (if the flag is used in Boardconfig) there is a new menu to backup and restore some important partitions like uboot, nvram an secro because they are involved in restoring a lost IMEI, and also the logo partition which may often get broken by bad ported ROMs.
- besides these all my old specific menus (aroma, rainbow...) are still in place.
- added support for dencrypting and mounting data partition using the builtin minivold from cyanogenmod with vdc commands - the ideea came from [this post of Lekensteyn](http://forum.xda-developers.com/showpost.php?p=47807114&postcount=2). Tested and working well with text ar hex passwords, and maybe will work with pin too but I don't think it will work with pattern (obviously).
- there is no included root solution. I choose to do it this way because there is no universal root solution now and someone may end up messing things with a non-working root option. You can flash a zip installer like [Chainfire's SuperSu](http://forum.xda-developers.com/showthread.php?t=1538053) or other solution that may work for your phone.

All screenshots are made with my old tool from *[here](http://forum.xda-developers.com/android/development/tool-carlivscreenshot-screenshots-t3075992)* -still working well.

CREDITS:

*The biggest thanks go to [AP756](http://forum.xda-developers.com/member.php?u=633509) and [DerTeufel1980](http://forum.xda-developers.com/member.php?u=4196889), two friends from Germany, who sent me a new phone each, with lollipop OS and that helped me a lot to do this.*

- [Phil3759](http://forum.xda-developers.com/member.php?u=4666971) for the touch code and many other things from his recovery;
- [TWRP developers](https://twrp.me/about/). I learned a lot from their work;
- [Clockworkmod Team](https://github.com/CyanogenMod/android_bootable_recovery/tree/cm-11.0) starting with Koushik Dutta and ending with all developers that made the CWM recovery what it was;
- [Cyanogenmod Developers](https://github.com/orgs/CyanogenMod/people);


In next post there are some links for built recoveries. I'll add more soon as I get a valid link (on a reliable webhost) from people who build it for other phones.

I worked alone on this, there is no team here, not because I don't want to :), but probably because there was no one interested in this, and so there may be some unspotted bugs. If you find any please do tell me to help on fixing it.

____

To build you need a local repo of cm-12.1 and a proper device tree. To see how a buildable  device tree looks check [this one from my github](https://github.com/carliv/device_mlais_mx)).

Some things to be considered:

For BoardConfig:
- the most common thing in all BoardConfig I saw (you need this to use power button to select if you use physical buttons in some situations)
- `BOARD_HAS_NO_SELECT_BUTTON`

- for the graphical interface
- `TARGET_RECOVERY_PIXEL_FORMAT`

- for mass storage if your phone has an external sdcard, to connect it to PC (this one can be specified in fstab too)
- `TARGET_USE_CUSTOM_LUN_FILE_PATH`

- with link to a valid recovery.fstab version 2 (it may work without it but it is better to be here)
- `TARGET_RECOVERY_FSTAB`

- for a better readability adapted to your screen (check the minui folder for more fonts)
- `BOARD_USE_CUSTOM_RECOVERY_FONT`

Carliv Touch Recovery specific flags:
- if you have the recovery on recovery-carliv folder under bootable directory in cm-12.1 source use this next flag. 
- `RECOVERY_VARIANT := carliv`

- with your phone resolution like this width x height
- `DEVICE_RESOLUTION := 720x1280`

- if you want to use it with encrypted phone (it work with a non encrypted phone too but it will be smaller if you don't need decrypting function)
- `BOARD_INCLUDE_CRYPTO := true`

- if your phone is MTK powered you need this for the MTK menu (it is not mandatory though with the mtk phones shipped with lollipop or marshmallow)
- `BOARD_HAS_MTK_CPU := true`
 
- for touch menu, if your phone has an input driver with PROTOCOL_TYPE_B (synaptic is an example, or many samsung devices); if you have access to, check your kernel input driver for something like this `#define PROTOCOL_TYPE_B` - google it if you want to know more about this
- `BOARD_USE_PROTOCOL_TYPE_B := true`

For system.prop from device tree:
```#
# system.prop for mx
#
ro.ctr.crypto.passwd="64656661756c745f70617373776f7264"
ro.ctr.forbid_format=/frp,/persistent,/lk,/uboot,/logo,/metadata,/nvdata,/nvram,/secro,/metadata
ro.ctr.forbid_mount=/frp,/persistent,/lk,/uboot,/logo,/metadata,/nvdata,/nvram,/secro,/metadata
ro.ctr.touch_accuracy=7```

- to use decrypt data specify here your password *(ro.ctr.crypto.passwd)*; I forgot to mention that if the phone uses encryption, the recovery will start with few seconds delay, because of the decrypting and mounting data process. If the message will tell you that couldn't be decrypted it is possible that your password was wrong or it uses an unsuported type of password. To be sure just restart the recovery from *Power menu* and if you still get the same message then you need to check your provided password from system.prop or to find a different solution (other recovery like twrp). If you want to decrypt your phone for good you need to format data and  data media from *Mount/Storage menu* but you will loose your data (settings, preferences).
- *ro.ctr.forbid_format* and *ro.ctr.forbid_mount* are for partitions from fstab that you don't want to be shown in *Mount/ Storage menu* with mount and format option (coma separated, no spaces and with leading slash), like in my example above.
- *ro.ctr.touch_accuracy* to improve the touch handling (bigger lsd_density = bigger accuracy); the initial value is 7, just like in PhilZ Recovery, and I reccomend you to try different numbers to see what is right for you, but don't go over 19.
All these system.prop lines are not mandatory.

Carliv Touch Recovery uses a fstab version 1 named *ctr.fstab* and you have to create a folder *recovery* in your device tree, in that recovery folder create a new folder named *root*, in root folder another folder named *etc* and in that one place the *ctr.fstab*. Like this:
`recovery/root/etc/ctr.fstab`
That will be enough since the compiler will add it in recovery ramdisk and the recovery module will find it in etc folder.

```#
# mount point	fstype    device    	[device2]    fs_options    [fs_options2]    lun

/boot			emmc	/dev/block/platform/mtk-msdc.0/by-name/boot
/cache			ext4	/dev/block/platform/mtk-msdc.0/by-name/cache
/recovery		emmc	/dev/block/platform/mtk-msdc.0/by-name/recovery
/system			ext4	/dev/block/platform/mtk-msdc.0/by-name/system
/data			ext4	/dev/block/platform/mtk-msdc.0/by-name/userdata
/internal_sd	datamedia	/dev/null
/sdcard			vfat	/dev/block/mmcblk1p1	/dev/block/mmcblk1   lun=sys/class/android_usb/android0/f_mass_storage/lun/file
```
Important here is how you define internal storage which is data media
`/internal_sd	   datamedia	/dev/null`
You can see it's  used the old way with *datamedia* fstype and */dev/null* device.
Important thing: if you have only internal storage define it as 
`/sdcard   datamedia	/dev/null`
If you have also an external sdcard, use either way:
`/internal_sd	   datamedia	/dev/null
/sdcard			vfat	/dev/block/mmcblk1p1	/dev/block/mmcblk1`
or
`/sdcard 	datamedia	/dev/null
/external_sd		vfat	/dev/block/mmcblk1p1	/dev/block/mmcblk1`
As you can see the internal storage can be sdcard or internal_sd and external sdcard can be sdcard or external_sd, but internal storage can't be external_sd or external sdcard internal_sd.
If your phone has OTG support you can use that too defining it like this
`/usb-otg		vfat	/dev/block/sda1	/dev/block/sda`
or this
`/usbdisk		vfat	/dev/block/sda1	/dev/block/sda`
-check with your phone booted up in Android and a OTG USB mounted to see in /sys/class/block how to set device for this (the dev/block/sdx part). The recovery has fat, fat32, exfat and ntfs support builtin - I only tested fat32. And even if I know it's common sense I have to mention it: it will work only with portable USB flash drives, not portables HDD (no spinning, got it?) - I couldn't test what is the top capacity in GB but for a 32 GB it works very well.
