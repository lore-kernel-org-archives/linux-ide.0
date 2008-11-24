From: Alexander Clausen <alex@gc-web.de>
Subject: Re: Suspend w/ sata_promise
Date: Mon, 24 Nov 2008 23:27:21 +0100
Message-ID: <492B2A49.4060904@gc-web.de>
References: <49202CB0.60507@gc-web.de>	<18720.18615.938839.921189@harpo.it.uu.se>	<492060D9.20808@gc-web.de>	<18723.52001.559166.255589@harpo.it.uu.se>	<18728.13696.418178.143954@harpo.it.uu.se>	<4928569C.9080805@gc-web.de>	<18729.54297.692199.41534@harpo.it.uu.se> <18730.39324.527421.503774@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040702020309020103040108"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server2.gc-web.de ([88.198.38.110]:51725 "EHLO mail.gc-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985AbYKXW1d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 17:27:33 -0500
In-Reply-To: <18730.39324.527421.503774@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040702020309020103040108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mikael Pettersson wrote:
> Mikael Pettersson writes:
>  > 
>  > Are you absolutely certain both patches were applied and the driver rebuilt?
>  > I'm asking because I would have expected to see
>  > 

Yes, pretty sure.

>  > [...] sata_promise 0000:00:0d.0: restoring config space at offset 0x1 (...)
>  > 
>  > but your kernel log does not contain anything like that. Both machines
>  > I tested on today consistently included this message after the patch was
>  > applied, but did not when the patch wasn't applied.

Ok, that is strange.

>  > 
>  > I did note some temporary errors (that sata_promise recovered from) on
>  > one machine after resuming from suspend to ram that did not occur when
>  > using standby. I'll update the patch to include a controller reinit in
>  > the ->resume op, which should hopefully fix that.
> 
> Here's an updated suspend patch for sata_promise. It will now
> do a HW re-init of the controller and its ports on resume,
> which should help e.g. S2R when all state may have been lost.
> 
> Depending on machine, suspend type (standby or mem), and disk
> I do get different results, some cases come up very cleanly
> while others have some transient failures; however in my tests
> libata EH always recovers.
> 
> Only tested on 2nd gen controllers as my 1st gen is at another site.
> 
> If this still doesn't work, try changing the #if 0 in pdc_pci_device_resume()
> to #if 1, that will make it issue a HW reset to all ATA engines before
> reinitialising them (shouldn't be needed, which is why it's disabled).

Ok, I tried this patch (with and without the HW reset). Also, I disabled the NVidia driver, and
indeed, I did have APIC disabled (in the .config, no idea why, really), so I enabled it.
Same failure, still happens on second suspend, updated dmesgs attached.

Note that there was this:

[  173.379285] sd 1:0:0:0: legacy resume
[  173.379288] sd 1:0:0:0: [sda] Starting disk
[  174.518083] ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x180000 action 0xe frozen
[  176.551848] ata2.00: hotplug_status 0x20
[  177.602899] ata2: SError: { 10B8B Dispar }
[  178.712237] ata2.00: cmd 40/00:01:00:00:00/00:00:00:00:00/e0 tag 0
[  178.712239]          res 50/00:01:00:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
[  182.525313] ata2.00: status: { DRDY }

in the old dmesg, on the first suspend, which is gone now. That seems to be the effect of the
ata_pci_device_suspend/ata_pci_device_resume functions, as it was gone after that patch, too (see my
message from 11/22/2008)
Also attached is the current .config, in case theres something else strange/stupid in there ;)

Btw. if it helps, I got suspend to disk working just fine, dmesg also attached.

Alex

--------------040702020309020103040108
Content-Type: text/plain;
 name="second-suspend-with-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="second-suspend-with-patch"

o for usb:usb3
[    4.144706] usb usb3: configuration #1 chosen from 1 choice
[    4.144767] PM: Adding info for usb:3-0:1.0
[    4.144789] hub 3-0:1.0: USB hub found
[    4.144840] hub 3-0:1.0: 2 ports detected
[    4.352019] PM: Adding info for No Bus:usbdev3.1_ep81
[    4.352049] PM: Adding info for No Bus:usbdev3.1
[    4.352089] PM: Adding info for No Bus:usbdev3.1_ep00
[    4.352117] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    4.352167] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.352226] usb usb3: Product: UHCI Host Controller
[    4.352273] usb usb3: Manufacturer: Linux 2.6.27.6 uhci_hcd
[    4.352321] usb usb3: SerialNumber: 0000:00:10.1
[    4.352383] uhci_hcd 0000:00:10.2: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    4.352436] uhci_hcd 0000:00:10.2: UHCI Host Controller
[    4.352492] PM: Adding info for No Bus:usb_host4
[    4.352512] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[    4.352587] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000a400
[    4.352685] PM: Adding info for usb:usb4
[    4.352713] usb usb4: configuration #1 chosen from 1 choice
[    4.352772] PM: Adding info for usb:4-0:1.0
[    4.352795] hub 4-0:1.0: USB hub found
[    4.352847] hub 4-0:1.0: 2 ports detected
[    4.464005] usb 3-2: new full speed USB device using uhci_hcd and address 2
[    4.560019] PM: Adding info for No Bus:usbdev4.1_ep81
[    4.560048] PM: Adding info for No Bus:usbdev4.1
[    4.560085] PM: Adding info for No Bus:usbdev4.1_ep00
[    4.560105] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    4.560155] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.560214] usb usb4: Product: UHCI Host Controller
[    4.560262] usb usb4: Manufacturer: Linux 2.6.27.6 uhci_hcd
[    4.560310] usb usb4: SerialNumber: 0000:00:10.2
[    4.560371] uhci_hcd 0000:00:10.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    4.560423] uhci_hcd 0000:00:10.3: UHCI Host Controller
[    4.560479] PM: Adding info for No Bus:usb_host5
[    4.560500] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
[    4.561393] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000a800
[    4.561501] PM: Adding info for usb:usb5
[    4.561527] usb usb5: configuration #1 chosen from 1 choice
[    4.561587] PM: Adding info for usb:5-0:1.0
[    4.561610] hub 5-0:1.0: USB hub found
[    4.561661] hub 5-0:1.0: 2 ports detected
[    4.607609] PM: Adding info for usb:3-2
[    4.607634] usb 3-2: configuration #1 chosen from 1 choice
[    4.610597] PM: Adding info for usb:3-2:1.0
[    4.610635] PM: Adding info for No Bus:usbdev3.2_ep81
[    4.610670] PM: Adding info for No Bus:usbdev3.2_ep02
[    4.610696] PM: Adding info for No Bus:usbdev3.2
[    4.610735] PM: Adding info for No Bus:usbdev3.2_ep00
[    4.610756] usb 3-2: New USB device found, idVendor=05d8, idProduct=4003
[    4.610806] usb 3-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.768019] PM: Adding info for No Bus:usbdev5.1_ep81
[    4.768049] PM: Adding info for No Bus:usbdev5.1
[    4.768088] PM: Adding info for No Bus:usbdev5.1_ep00
[    4.768110] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    4.768160] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.768219] usb usb5: Product: UHCI Host Controller
[    4.768267] usb usb5: Manufacturer: Linux 2.6.27.6 uhci_hcd
[    4.768315] usb usb5: SerialNumber: 0000:00:10.3
[    4.768418] usbcore: registered new interface driver usblp
[    4.768467] Initializing USB Mass Storage driver...
[    4.768543] usbcore: registered new interface driver usb-storage
[    4.768592] USB Mass Storage support registered.
[    4.768663] usbcore: registered new interface driver microtekX6
[    4.768771] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    4.768867] PM: Adding info for platform:i8042
[    4.769150] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.769201] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.769257] PM: Adding info for No Bus:mice
[    4.769280] PM: Adding info for serio:serio0
[    4.769316] PM: Adding info for No Bus:psaux
[    4.769333] PM: Adding info for serio:serio1
[    4.769353] mice: PS/2 mouse device common for all mice
[    4.802277] PM: Adding info for No Bus:input0
[    4.802325] input: AT Translated Set 2 keyboard as /class/input/input0
[    4.802429] i2c /dev entries driver
[    4.802551] ACPI: I/O resource vt596_smbus [0x400-0x407] conflicts with ACPI region SMOV [0x400-0x406]
[    4.802613] ACPI: Device needs an ACPI driver
[    4.802669] PM: Adding info for No Bus:i2c-0
[    4.802697] PM: Adding info for No Bus:i2c-0
[    4.802754] cpuidle: using governor ladder
[    4.802801] cpuidle: using governor menu
[    4.802902] Advanced Linux Sound Architecture Driver Version 1.0.17.
[    4.802962] PM: Adding info for No Bus:timer
[    4.803004] VIA 82xx Audio 0000:00:11.5: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    4.803197] VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
[    5.316500] PM: Adding info for No Bus:pcmC0D1p
[    5.316589] PM: Adding info for No Bus:pcmC0D1c
[    5.316622] PM: Adding info for No Bus:adsp
[    5.316657] PM: Adding info for No Bus:pcmC0D0p
[    5.316691] PM: Adding info for No Bus:pcmC0D0c
[    5.316721] PM: Adding info for No Bus:dsp
[    5.316749] PM: Adding info for No Bus:audio
[    5.316778] PM: Adding info for ac97:0-0:ALC655
[    5.316808] PM: Adding info for No Bus:controlC0
[    5.316843] PM: Adding info for No Bus:mixer
[    5.317157] ALSA device list:
[    5.317206]   #0: VIA 8237 with ALC655 at 0x9800, irq 22
[    5.317649] TCP cubic registered
[    5.317696] NET: Registered protocol family 17
[    5.317829] RPC: Registered udp transport module.
[    5.317876] RPC: Registered tcp transport module.
[    5.317934] powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3200+ processors (1 cpu cores) (version 2.20.00)
[    5.318033] powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x2
[    5.318082] powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x6
[    5.318131] powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa
[    5.318179] powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
[    5.318284] Using IPI Shortcut mode
[    5.318350] PM: Adding info for No Bus:cpu_dma_latency
[    5.318378] PM: Adding info for No Bus:network_latency
[    5.318404] PM: Adding info for No Bus:network_throughput
[    5.318430] registered taskstats version 1
[    5.318599]   Magic number: 0:885:399
[    5.318710] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    5.318993] Freeing unused kernel memory: 244k freed
[    5.319072] PM: Adding info for No Bus:vcs1
[    5.319109] PM: Adding info for No Bus:vcsa1
[    5.350747] processor: module is already loaded
[    5.351019] thermal: module is already loaded
[    5.520357] udev: renamed network interface eth0 to eth1
[    5.646254] PM: Adding info for No Bus:input1
[    5.646293] input: PS/2 Logitech Mouse as /class/input/input1
[    5.652098] PM: Adding info for No Bus:mouse0
[    5.686570] processor: module is already loaded
[    5.686726] thermal: module is already loaded
[    5.821983] Floppy drive(s): fd0 is 1.44M
[    5.839797] FDC 0 is a post-1991 82077
[    5.840798] PM: Adding info for platform:floppy.0
[    5.840839] PM: Adding info for No Bus:fd0
[    5.840871] PM: Adding info for No Bus:2:0
[    5.896017] EXT3-fs: INFO: recovery required on readonly filesystem.
[    5.896071] EXT3-fs: write access will be enabled during recovery.
[    6.292626] kjournald starting.  Commit interval 5 seconds
[    6.292689] EXT3-fs: sda2: orphan cleanup on readonly fs
[    6.292741] ext3_orphan_cleanup: deleting unreferenced inode 6204313
[    6.292763] ext3_orphan_cleanup: deleting unreferenced inode 6204312
[    6.292769] ext3_orphan_cleanup: deleting unreferenced inode 6204311
[    6.292773] ext3_orphan_cleanup: deleting unreferenced inode 6204310
[    6.292788] ext3_orphan_cleanup: deleting unreferenced inode 6204309
[    6.292792] EXT3-fs: sda2: 5 orphan inodes deleted
[    6.292839] EXT3-fs: recovery complete.
[    6.323081] EXT3-fs: mounted filesystem with ordered data mode.
[    6.744643] PM: Removing info for No Bus:vcs1
[    6.744686] PM: Removing info for No Bus:vcsa1
[    6.744727] PM: Adding info for No Bus:vcs1
[    6.744739] PM: Adding info for No Bus:vcsa1
[    6.744756] PM: Removing info for No Bus:vcs1
[    6.744765] PM: Removing info for No Bus:vcsa1
[    6.756432] PM: Adding info for No Bus:vcs1
[    6.756443] PM: Adding info for No Bus:vcsa1
[    6.756496] PM: Removing info for No Bus:vcs1
[    6.756504] PM: Removing info for No Bus:vcsa1
[    6.756524] PM: Adding info for No Bus:vcs1
[    6.756534] PM: Adding info for No Bus:vcsa1
[    6.756579] PM: Removing info for No Bus:vcs1
[    6.756587] PM: Removing info for No Bus:vcsa1
[    6.756607] PM: Adding info for No Bus:vcs1
[    6.756616] PM: Adding info for No Bus:vcsa1
[    6.756701] PM: Removing info for No Bus:vcs1
[    6.756710] PM: Removing info for No Bus:vcsa1
[    6.768617] PM: Adding info for No Bus:vcs1
[    6.768628] PM: Adding info for No Bus:vcsa1
[    7.751290] udevd version 125 started
[    8.350763] PM: Adding info for No Bus:input2
[    8.350796] input: Power Button (FF) as /class/input/input2
[    8.360070] PM: Adding info for No Bus:event0
[    8.376063] PM: Adding info for No Bus:event1
[    8.408077] PM: Adding info for No Bus:event2
[    8.408097] ACPI: Power Button (FF) [PWRF]
[    8.408187] PM: Adding info for No Bus:input3
[    8.408214] input: Power Button (CM) as /class/input/input3
[    8.436061] PM: Adding info for No Bus:event3
[    8.436082] ACPI: Power Button (CM) [PWRB]
[    8.436188] PM: Adding info for No Bus:input4
[    8.436215] input: Sleep Button (CM) as /class/input/input4
[    8.460087] PM: Adding info for No Bus:event4
[    8.460123] ACPI: Sleep Button (CM) [SLPB]
[    8.483378] agpgart-amd64 0000:00:00.0: AGP bridge [1106/3188]
[    8.489179] PM: Adding info for No Bus:agpgart
[    8.489196] agpgart-amd64 0000:00:00.0: AGP aperture is 128M @ 0xd0000000
[    8.817628] PM: Adding info for No Bus:hwmon0
[    8.951340] PM: Adding info for No Bus:rtc0
[    8.951365] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    8.951447] rtc0: alarms up to one year, y3k
[    8.970977] PM: Adding info for No Bus:input5
[    8.971009] input: PC Speaker as /class/input/input5
[    8.981468] PM: Adding info for No Bus:event5
[   34.170605] Unable to find swap-space signature
[   34.582773] EXT3 FS on sda2, internal journal
[   35.478246] Unable to find swap-space signature
[   36.020435] r8169: eth1: link up
[   37.484103] PM: Adding info for No Bus:0:19
[   37.495045] PM: Adding info for No Bus:0:20
[   38.288223] ttyS1: LSR safety check engaged!
[   38.288759] ttyS1: LSR safety check engaged!
[   38.704254] PM: Removing info for No Bus:vcs1
[   38.704300] PM: Removing info for No Bus:vcsa1
[   38.704696] PM: Adding info for No Bus:vcs1
[   38.704709] PM: Adding info for No Bus:vcsa1
[   38.704762] PM: Removing info for No Bus:vcs1
[   38.704774] PM: Removing info for No Bus:vcsa1
[   38.704795] PM: Adding info for No Bus:vcs1
[   38.704805] PM: Adding info for No Bus:vcsa1
[   38.704851] PM: Removing info for No Bus:vcs1
[   38.704860] PM: Removing info for No Bus:vcsa1
[   38.704879] PM: Adding info for No Bus:vcs1
[   38.704890] PM: Adding info for No Bus:vcsa1
[   38.704975] PM: Removing info for No Bus:vcs1
[   38.704984] PM: Removing info for No Bus:vcsa1
[   38.705147] PM: Adding info for No Bus:vcs1
[   38.705159] PM: Adding info for No Bus:vcsa1
[   46.724060] ttyS1: LSR safety check engaged!
[   51.740927] PM: Adding info for No Bus:vcs3
[   51.740950] PM: Adding info for No Bus:vcsa3
[   51.742768] PM: Adding info for No Bus:vcs4
[   51.742791] PM: Adding info for No Bus:vcsa4
[   51.743498] PM: Adding info for No Bus:vcs2
[   51.743519] PM: Adding info for No Bus:vcsa2
[   51.744155] PM: Adding info for No Bus:vcs5
[   51.744173] PM: Adding info for No Bus:vcsa5
[   51.746012] PM: Adding info for No Bus:vcs6
[   51.746033] PM: Adding info for No Bus:vcsa6
[   51.815986] PM: Adding info for No Bus:vcs7
[   51.816026] PM: Adding info for No Bus:vcsa7
[   53.021248] PM: Removing info for No Bus:vcs7
[   53.021297] PM: Removing info for No Bus:vcsa7
[   72.641263] PM: Syncing filesystems ... done.
[   72.646638] PM: Preparing system for mem sleep
[   72.647528] Freezing user space processes ... (elapsed 0.00 seconds) done.
[   72.647880] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[   72.648047] PM: Entering mem sleep
[   72.648063] agpgart-amd64 0000:00:00.0: preparing suspend
[   72.648066] pci 0000:00:01.0: preparing suspend
[   72.648068] sata_via 0000:00:08.0: preparing suspend
[   72.648070] r8169 0000:00:0b.0: preparing suspend
[   72.648072] sata_promise 0000:00:0d.0: preparing suspend
[   72.648074] pci 0000:00:0e.0: preparing suspend
[   72.648076] sata_via 0000:00:0f.0: preparing suspend
[   72.648078] VIA_IDE 0000:00:0f.1: preparing suspend
[   72.648080] uhci_hcd 0000:00:10.0: preparing suspend
[   72.648082] uhci_hcd 0000:00:10.1: preparing suspend
[   72.648084] uhci_hcd 0000:00:10.2: preparing suspend
[   72.648086] uhci_hcd 0000:00:10.3: preparing suspend
[   72.648088] ehci_hcd 0000:00:10.4: preparing suspend
[   72.648090] pci 0000:00:11.0: preparing suspend
[   72.648092] VIA 82xx Audio 0000:00:11.5: preparing suspend
[   72.648094] pci 0000:00:18.0: preparing suspend
[   72.648095] pci 0000:00:18.1: preparing suspend
[   72.648097] pci 0000:00:18.2: preparing suspend
[   72.648099] k8temp 0000:00:18.3: preparing suspend
[   72.648101] pci 0000:01:00.0: preparing suspend
[   72.648109] pcspkr pcspkr: preparing suspend
[   72.648112] platform vesafb.0: preparing suspend
[   72.648129] serial8250 serial8250: preparing suspend
[   72.648151] usb usb1: preparing type suspend, may wakeup
[   72.648154] usb usb2: preparing type suspend, may wakeup
[   72.648157] usb usb3: preparing type suspend, may wakeup
[   72.648160] usb usb4: preparing type suspend, may wakeup
[   72.648163] usb usb5: preparing type suspend, may wakeup
[   72.648165] usb 3-2: preparing type suspend, may wakeup
[   72.648169] i8042 i8042: preparing suspend
[   72.648177] platform floppy.0: preparing suspend
[   72.648187] rtc rtc0: legacy class suspend
[   72.648215] platform floppy.0: suspend
[   72.648217] ac97 0-0:ALC655: legacy suspend
[   72.648220] psmouse serio1: legacy suspend
[   73.109030] atkbd serio0: legacy suspend
[   73.652003] i8042 i8042: suspend
[   73.652013] usb 3-2: type suspend, may wakeup
[   73.668006] usb usb5: type suspend, may wakeup
[   73.668008] usb usb4: type suspend, may wakeup
[   73.668011] usb usb3: type suspend, may wakeup
[   73.668024] usb usb2: type suspend, may wakeup
[   73.668026] usb usb1: type suspend, may wakeup
[   73.668029] sd 1:0:0:0: legacy suspend
[   73.668034] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[   73.668227] sd 1:0:0:0: [sda] Stopping disk
[   73.974812] serial8250 serial8250: suspend
[   73.974824] platform vesafb.0: suspend
[   73.974826] pcspkr pcspkr: suspend
[   73.974834] i8042 kbd 00:0a: legacy suspend
[   73.974852] i8042 aux 00:09: legacy suspend
[   73.974856] pnp 00:08: legacy suspend
[   73.974858] pnp 00:07: legacy suspend
[   73.974860] rtc_cmos 00:06: legacy suspend, may wakeup
[   73.974867] pnp 00:05: legacy suspend
[   73.974869] system 00:04: legacy suspend
[   73.974873] pnp 00:03: legacy suspend
[   73.974874] serial 00:02: legacy suspend
[   73.975028] serial 00:02: disabled
[   73.975095] pnp 00:01: legacy suspend
[   73.975096] pnp 00:00: legacy suspend
[   73.975098] pci 0000:01:00.0: suspend
[   73.975114] k8temp 0000:00:18.3: suspend
[   73.975119] pci 0000:00:18.2: suspend
[   73.975123] pci 0000:00:18.1: suspend
[   73.975128] pci 0000:00:18.0: suspend
[   73.975134] VIA 82xx Audio 0000:00:11.5: suspend
[   73.975862] VIA 82xx Audio 0000:00:11.5: PCI INT C disabled
[   73.988004] pci 0000:00:11.0: suspend
[   73.988027] ehci_hcd 0000:00:10.4: suspend
[   73.988055] ehci_hcd 0000:00:10.4: PCI INT C disabled
[   74.004005] uhci_hcd 0000:00:10.3: suspend
[   74.004032] uhci_hcd 0000:00:10.3: PCI INT B disabled
[   74.020004] uhci_hcd 0000:00:10.2: suspend
[   74.020030] uhci_hcd 0000:00:10.2: PCI INT B disabled
[   74.036004] uhci_hcd 0000:00:10.1: suspend
[   74.036030] uhci_hcd 0000:00:10.1: PCI INT A disabled
[   74.052004] uhci_hcd 0000:00:10.0: suspend
[   74.052030] uhci_hcd 0000:00:10.0: PCI INT A disabled
[   74.068004] VIA_IDE 0000:00:0f.1: suspend
[   74.068027] sata_via 0000:00:0f.0: suspend
[   74.428027] sata_via 0000:00:0f.0: PCI INT B disabled
[   74.444004] pci 0000:00:0e.0: suspend
[   74.444027] sata_promise 0000:00:0d.0: suspend
[   74.444691] sata_promise 0000:00:0d.0: PCI INT A disabled
[   74.460004] r8169 0000:00:0b.0: suspend
[   74.460032] ACPI handle has no context!
[   74.460037] ACPI handle has no context!
[   74.476003] sata_via 0000:00:08.0: suspend
[   74.476066] sata_via 0000:00:08.0: PCI INT A disabled
[   74.492003] pci 0000:00:01.0: suspend
[   74.492022] agpgart-amd64 0000:00:00.0: suspend
[   74.492054] ACPI handle has no context!
[   74.508004] acpi LNXTHERM:00: legacy suspend
[   74.508006] button PNP0C0E:00: legacy suspend
[   74.508008] pci_link PNP0C0F:07: legacy suspend
[   74.508010] pci_link PNP0C0F:06: legacy suspend
[   74.508012] pci_link PNP0C0F:05: legacy suspend
[   74.508014] pci_link PNP0C0F:04: legacy suspend
[   74.508016] pci_link PNP0C0F:03: legacy suspend
[   74.508017] pci_link PNP0C0F:02: legacy suspend
[   74.508019] pci_link PNP0C0F:01: legacy suspend
[   74.508021] pci_link PNP0C0F:00: legacy suspend
[   74.508023] acpi device:13: legacy suspend
[   74.508025] acpi device:12: legacy suspend
[   74.508026] acpi device:11: legacy suspend
[   74.508028] acpi device:10: legacy suspend
[   74.508030] acpi device:0f: legacy suspend
[   74.508031] acpi device:0e: legacy suspend
[   74.508033] acpi device:0d: legacy suspend
[   74.508035] acpi device:0c: legacy suspend
[   74.508037] acpi device:0b: legacy suspend
[   74.508038] acpi device:0a: legacy suspend
[   74.508040] acpi device:09: legacy suspend
[   74.508042] acpi device:08: legacy suspend
[   74.508044] acpi PNP0303:00: legacy suspend
[   74.508045] acpi PNP0F13:00: legacy suspend
[   74.508047] acpi PNP0C04:00: legacy suspend
[   74.508049] acpi PNP0800:00: legacy suspend
[   74.508050] acpi PNP0B00:00: legacy suspend
[   74.508052] acpi PNP0100:00: legacy suspend
[   74.508054] acpi PNP0200:00: legacy suspend
[   74.508056] acpi PNP0C02:00: legacy suspend
[   74.508057] acpi device:07: legacy suspend
[   74.508059] acpi device:06: legacy suspend
[   74.508061] acpi device:05: legacy suspend
[   74.508063] acpi device:04: legacy suspend
[   74.508064] acpi device:03: legacy suspend
[   74.508066] acpi device:02: legacy suspend
[   74.508068] acpi device:01: legacy suspend
[   74.508070] power LNXPOWER:03: legacy suspend
[   74.508071] power LNXPOWER:02: legacy suspend
[   74.508073] power LNXPOWER:01: legacy suspend
[   74.508075] power LNXPOWER:00: legacy suspend
[   74.508076] acpi PNP0401:00: legacy suspend
[   74.508078] acpi PNP0501:00: legacy suspend
[   74.508080] acpi PNP0700:00: legacy suspend
[   74.508082] pci_root PNP0A03:00: legacy suspend
[   74.508084] button PNP0C0C:00: legacy suspend
[   74.508085] acpi device:00: legacy suspend
[   74.508087] processor ACPI0007:00: legacy suspend
[   74.508089] button LNXPWRBN:00: legacy suspend
[   74.508091] acpi LNXSYSTM:00: legacy suspend
[   74.508229] ACPI: Preparing to enter system sleep state S3
[   74.508520] platform floppy.0: LATE suspend
[   74.508525] i8042 i8042: LATE suspend
[   74.508536] serial8250 serial8250: LATE suspend
[   74.508544] platform vesafb.0: LATE suspend
[   74.508546] pcspkr pcspkr: LATE suspend
[   74.508550] pci 0000:01:00.0: LATE suspend
[   74.508552] k8temp 0000:00:18.3: LATE suspend
[   74.508554] pci 0000:00:18.2: LATE suspend
[   74.508555] pci 0000:00:18.1: LATE suspend
[   74.508557] pci 0000:00:18.0: LATE suspend
[   74.508559] VIA 82xx Audio 0000:00:11.5: LATE suspend
[   74.508561] pci 0000:00:11.0: LATE suspend
[   74.508562] ehci_hcd 0000:00:10.4: LATE suspend
[   74.508564] uhci_hcd 0000:00:10.3: LATE suspend
[   74.508566] uhci_hcd 0000:00:10.2: LATE suspend
[   74.508568] uhci_hcd 0000:00:10.1: LATE suspend
[   74.508569] uhci_hcd 0000:00:10.0: LATE suspend
[   74.508571] VIA_IDE 0000:00:0f.1: LATE suspend
[   74.508573] sata_via 0000:00:0f.0: LATE suspend
[   74.508575] pci 0000:00:0e.0: LATE suspend
[   74.508577] sata_promise 0000:00:0d.0: LATE suspend
[   74.508579] r8169 0000:00:0b.0: LATE suspend
[   74.508580] sata_via 0000:00:08.0: LATE suspend
[   74.508582] pci 0000:00:01.0: LATE suspend
[   74.508584] agpgart-amd64 0000:00:00.0: LATE suspend
[   74.512001]  hwsleep-0311 [00] enter_sleep_state     : Entering sleep state [S3]
[   74.512001] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[   74.512001] Intel machine check architecture supported.
[   74.512001] Intel machine check reporting enabled on CPU#0.
[   74.512001] evxfevnt-0079 [00] enable                : System is already in ACPI mode
[   74.512001] Back to C!
[   74.512001] agpgart-amd64 0000:00:00.0: EARLY resume
[   74.512001] pci 0000:00:01.0: EARLY resume
[   74.512001] sata_via 0000:00:08.0: EARLY resume
[   74.512001] r8169 0000:00:0b.0: EARLY resume
[   74.512001] sata_promise 0000:00:0d.0: EARLY resume
[   74.512001] pci 0000:00:0e.0: EARLY resume
[   74.512001] sata_via 0000:00:0f.0: EARLY resume
[   74.512001] VIA_IDE 0000:00:0f.1: EARLY resume
[   74.512001] uhci_hcd 0000:00:10.0: EARLY resume
[   74.512001] uhci_hcd 0000:00:10.1: EARLY resume
[   74.512001] uhci_hcd 0000:00:10.2: EARLY resume
[   74.512001] uhci_hcd 0000:00:10.3: EARLY resume
[   74.512001] ehci_hcd 0000:00:10.4: EARLY resume
[   74.512001] pci 0000:00:11.0: EARLY resume
[   74.512001] VIA 82xx Audio 0000:00:11.5: EARLY resume
[   74.512001] pci 0000:00:18.0: EARLY resume
[   74.512001] pci 0000:00:18.1: EARLY resume
[   74.512001] pci 0000:00:18.2: EARLY resume
[   74.512001] k8temp 0000:00:18.3: EARLY resume
[   74.512001] pci 0000:01:00.0: EARLY resume
[   74.512001] pcspkr pcspkr: EARLY resume
[   74.512001] platform vesafb.0: EARLY resume
[   74.512001] serial8250 serial8250: EARLY resume
[   74.512001] i8042 i8042: EARLY resume
[   74.512001] platform floppy.0: EARLY resume
[   74.512001] ACPI: Waking up from system sleep state S3
[   75.168140] acpi LNXSYSTM:00: legacy resume
[   75.168142] button LNXPWRBN:00: legacy resume
[   75.168145] processor ACPI0007:00: legacy resume
[   75.168146] acpi device:00: legacy resume
[   75.168148] button PNP0C0C:00: legacy resume
[   75.168151] pci_root PNP0A03:00: legacy resume
[   75.168152] acpi PNP0700:00: legacy resume
[   75.168154] acpi PNP0501:00: legacy resume
[   75.168156] acpi PNP0401:00: legacy resume
[   75.168158] power LNXPOWER:00: legacy resume
[   75.168185] power LNXPOWER:01: legacy resume
[   75.168209] power LNXPOWER:02: legacy resume
[   75.168232] power LNXPOWER:03: legacy resume
[   75.168255] acpi device:01: legacy resume
[   75.168257] acpi device:02: legacy resume
[   75.168259] acpi device:03: legacy resume
[   75.168260] acpi device:04: legacy resume
[   75.168262] acpi device:05: legacy resume
[   75.168264] acpi device:06: legacy resume
[   75.168266] acpi device:07: legacy resume
[   75.168268] acpi PNP0C02:00: legacy resume
[   75.168269] acpi PNP0200:00: legacy resume
[   75.168271] acpi PNP0100:00: legacy resume
[   75.168273] acpi PNP0B00:00: legacy resume
[   75.168275] acpi PNP0800:00: legacy resume
[   75.168276] acpi PNP0C04:00: legacy resume
[   75.168278] acpi PNP0F13:00: legacy resume
[   75.168280] acpi PNP0303:00: legacy resume
[   75.168282] acpi device:08: legacy resume
[   75.168283] acpi device:09: legacy resume
[   75.168285] acpi device:0a: legacy resume
[   75.168287] acpi device:0b: legacy resume
[   75.168289] acpi device:0c: legacy resume
[   75.168290] acpi device:0d: legacy resume
[   75.168292] acpi device:0e: legacy resume
[   75.168294] acpi device:0f: legacy resume
[   75.168296] acpi device:10: legacy resume
[   75.168297] acpi device:11: legacy resume
[   75.168299] acpi device:12: legacy resume
[   75.168301] acpi device:13: legacy resume
[   75.168303] pci_link PNP0C0F:00: legacy resume
[   75.168305] pci_link PNP0C0F:01: legacy resume
[   75.168306] pci_link PNP0C0F:02: legacy resume
[   75.168308] pci_link PNP0C0F:03: legacy resume
[   75.168310] pci_link PNP0C0F:04: legacy resume
[   75.168312] pci_link PNP0C0F:05: legacy resume
[   75.168314] pci_link PNP0C0F:06: legacy resume
[   75.168316] pci_link PNP0C0F:07: legacy resume
[   75.168318] button PNP0C0E:00: legacy resume
[   75.168319] acpi LNXTHERM:00: legacy resume
[   75.168322] agpgart-amd64 0000:00:00.0: resume
[   75.184033] pci 0000:00:01.0: resume
[   75.184057] pci 0000:00:01.0: setting latency timer to 64
[   75.184060] sata_via 0000:00:08.0: resume
[   75.200030] sata_via 0000:00:08.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   75.200209] r8169 0000:00:0b.0: resume
[   75.216018] r8169 0000:00:0b.0: restoring config space at offset 0x3 (was 0x2008, writing 0x4008)
[   75.216030] sata_promise 0000:00:0d.0: resume
[   75.232029] sata_promise 0000:00:0d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   75.232111] r8169: eth1: link up
[   75.248407] pci 0000:00:0e.0: resume
[   75.248430] sata_via 0000:00:0f.0: resume
[   75.264027] sata_via 0000:00:0f.0: PCI INT B -> GSI 20 (level, low) -> IRQ 20
[   75.264083] VIA_IDE 0000:00:0f.1: resume
[   75.264111] VIA_IDE 0000:00:0f.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[   75.264161] uhci_hcd 0000:00:10.0: resume
[   75.280005] uhci_hcd 0000:00:10.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[   75.280090] usb usb2: root hub lost power or was reset
[   75.280147] uhci_hcd 0000:00:10.1: resume
[   75.296005] uhci_hcd 0000:00:10.1: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[   75.296089] usb usb3: root hub lost power or was reset
[   75.296144] uhci_hcd 0000:00:10.2: resume
[   75.312005] uhci_hcd 0000:00:10.2: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[   75.312089] usb usb4: root hub lost power or was reset
[   75.312144] uhci_hcd 0000:00:10.3: resume
[   75.328005] uhci_hcd 0000:00:10.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[   75.328089] usb usb5: root hub lost power or was reset
[   75.328145] ehci_hcd 0000:00:10.4: resume
[   75.344005] ehci_hcd 0000:00:10.4: PCI INT C -> GSI 21 (level, low) -> IRQ 21
[   75.344072] ehci_hcd 0000:00:10.4: restoring config space at offset 0x3 (was 0x802008, writing 0x802010)
[   75.344082] pci 0000:00:11.0: resume
[   75.344107] VIA 82xx Audio 0000:00:11.5: resume
[   75.367222] VIA 82xx Audio 0000:00:11.5: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[   75.367284] VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
[   75.370230] pci 0000:00:18.0: resume
[   75.370237] pci 0000:00:18.1: resume
[   75.370243] pci 0000:00:18.2: resume
[   75.370248] k8temp 0000:00:18.3: resume
[   75.370253] pci 0000:01:00.0: resume
[   75.370260] pci 0000:01:00.0: restoring config space at offset 0xc (was 0x0, writing 0xcfee0000)
[   75.370271] pnp 00:00: legacy resume
[   75.370273] pnp 00:01: legacy resume
[   75.370274] serial 00:02: legacy resume
[   75.370993] serial 00:02: activated
[   75.371042] pnp 00:03: legacy resume
[   75.371044] system 00:04: legacy resume
[   75.371046] pnp 00:05: legacy resume
[   75.371048] rtc_cmos 00:06: legacy resume
[   75.371051] pnp 00:07: legacy resume
[   75.371052] pnp 00:08: legacy resume
[   75.371054] i8042 aux 00:09: legacy resume
[   75.371056] i8042 kbd 00:0a: legacy resume
[   75.371061] pcspkr pcspkr: resume
[   75.371063] platform vesafb.0: resume
[   75.371078] serial8250 serial8250: resume
[   75.371094] sd 1:0:0:0: legacy resume
[   75.371097] sd 1:0:0:0: [sda] Starting disk
[   75.545270] ata4: SATA link down (SStatus 0 SControl 310)
[   75.545331] ata5: SATA link down (SStatus 0 SControl 310)
[   75.568074] ata1: SATA link down (SStatus 0 SControl 300)
[   75.724035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   75.740505] ata2.00: configured for UDMA/133
[   75.750539] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   75.750600] sd 1:0:0:0: [sda] Write Protect is off
[   75.750648] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   75.750663] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   75.750731] usb usb1: type resume
[   75.816023] usb usb2: type resume
[   75.816026] usb usb3: type resume
[   76.064006] usb usb4: type resume
[   76.064008] usb usb5: type resume
[   76.064010] usb 3-2: type resume
[   76.176005] usb 3-2: reset full speed USB device using uhci_hcd and address 2
[   76.322902] i8042 i8042: resume
[   76.322927] atkbd serio0: legacy resume
[   76.322930] psmouse serio1: legacy resume
[   76.322934] ac97 0-0:ALC655: legacy resume
[   76.322938] platform floppy.0: resume
[   76.322942] rtc rtc0: legacy class resume
[   76.322976] platform floppy.0: completing resume
[   76.322980] i8042 i8042: completing resume
[   76.322982] usb 3-2: completing type resume
[   76.322984] usb usb5: completing type resume
[   76.322986] usb usb4: completing type resume
[   76.322988] usb usb3: completing type resume
[   76.322991] usb usb2: completing type resume
[   76.322993] usb usb1: completing type resume
[   76.323004] serial8250 serial8250: completing resume
[   76.323013] platform vesafb.0: completing resume
[   76.323015] pcspkr pcspkr: completing resume
[   76.323019] pci 0000:01:00.0: completing resume
[   76.323021] k8temp 0000:00:18.3: completing resume
[   76.323023] pci 0000:00:18.2: completing resume
[   76.323025] pci 0000:00:18.1: completing resume
[   76.323027] pci 0000:00:18.0: completing resume
[   76.323028] VIA 82xx Audio 0000:00:11.5: completing resume
[   76.323030] pci 0000:00:11.0: completing resume
[   76.323032] ehci_hcd 0000:00:10.4: completing resume
[   76.323034] uhci_hcd 0000:00:10.3: completing resume
[   76.323036] uhci_hcd 0000:00:10.2: completing resume
[   76.323037] uhci_hcd 0000:00:10.1: completing resume
[   76.323039] uhci_hcd 0000:00:10.0: completing resume
[   76.323041] VIA_IDE 0000:00:0f.1: completing resume
[   76.323043] sata_via 0000:00:0f.0: completing resume
[   76.323044] pci 0000:00:0e.0: completing resume
[   76.323046] sata_promise 0000:00:0d.0: completing resume
[   76.323048] r8169 0000:00:0b.0: completing resume
[   76.323050] sata_via 0000:00:08.0: completing resume
[   76.323052] pci 0000:00:01.0: completing resume
[   76.323053] agpgart-amd64 0000:00:00.0: completing resume
[   76.323063] PM: Finishing wakeup.
[   76.323065] Restarting tasks ... done.
[   76.381309] atkbd.c: Failed to enable keyboard on isa0060/serio0
[  158.851751] PM: Syncing filesystems ... done.
[  158.854924] PM: Preparing system for mem sleep
[  158.855805] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  158.856175] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  158.856351] PM: Entering mem sleep
[  158.856368] agpgart-amd64 0000:00:00.0: preparing suspend
[  158.856370] pci 0000:00:01.0: preparing suspend
[  158.856372] sata_via 0000:00:08.0: preparing suspend
[  158.856374] r8169 0000:00:0b.0: preparing suspend
[  158.856376] sata_promise 0000:00:0d.0: preparing suspend
[  158.856378] pci 0000:00:0e.0: preparing suspend
[  158.856380] sata_via 0000:00:0f.0: preparing suspend
[  158.856382] VIA_IDE 0000:00:0f.1: preparing suspend
[  158.856384] uhci_hcd 0000:00:10.0: preparing suspend
[  158.856386] uhci_hcd 0000:00:10.1: preparing suspend
[  158.856388] uhci_hcd 0000:00:10.2: preparing suspend
[  158.856390] uhci_hcd 0000:00:10.3: preparing suspend
[  158.856392] ehci_hcd 0000:00:10.4: preparing suspend
[  158.856394] pci 0000:00:11.0: preparing suspend
[  158.856396] VIA 82xx Audio 0000:00:11.5: preparing suspend
[  158.856398] pci 0000:00:18.0: preparing suspend
[  158.856400] pci 0000:00:18.1: preparing suspend
[  158.856401] pci 0000:00:18.2: preparing suspend
[  158.856403] k8temp 0000:00:18.3: preparing suspend
[  158.856405] pci 0000:01:00.0: preparing suspend
[  158.856413] pcspkr pcspkr: preparing suspend
[  158.856416] platform vesafb.0: preparing suspend
[  158.856433] serial8250 serial8250: preparing suspend
[  158.856454] usb usb1: preparing type suspend, may wakeup
[  158.856458] usb usb2: preparing type suspend, may wakeup
[  158.856461] usb usb3: preparing type suspend, may wakeup
[  158.856464] usb usb4: preparing type suspend, may wakeup
[  158.856467] usb usb5: preparing type suspend, may wakeup
[  158.856469] usb 3-2: preparing type suspend, may wakeup
[  158.856473] i8042 i8042: preparing suspend
[  158.856481] platform floppy.0: preparing suspend
[  158.856491] rtc rtc0: legacy class suspend
[  158.856519] platform floppy.0: suspend
[  158.856521] ac97 0-0:ALC655: legacy suspend
[  158.856524] psmouse serio1: legacy suspend
[  159.313427] atkbd serio0: legacy suspend
[  159.856003] i8042 i8042: suspend
[  159.856014] usb 3-2: type suspend, may wakeup
[  159.872005] usb usb5: type suspend, may wakeup
[  159.872008] usb usb4: type suspend, may wakeup
[  159.872010] usb usb3: type suspend, may wakeup
[  159.872023] usb usb2: type suspend, may wakeup
[  159.872025] usb usb1: type suspend, may wakeup
[  159.872029] sd 1:0:0:0: legacy suspend
[  159.872034] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  159.872233] sd 1:0:0:0: [sda] Stopping disk
[  189.872020] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  189.872075] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  189.872076]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  189.872182] ata2.00: status: { DRDY }
[  189.872237] ata2: hard resetting link
[  190.192017] ata2: SATA link down (SStatus 100 SControl 300)
[  190.373016] ata2: hard resetting link
[  190.848036] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  190.864505] ata2.00: configured for UDMA/133
[  190.864759] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  190.864809] ata2: hotplug_status 0x2
[  190.880504] ata2.00: configured for UDMA/133
[  190.880554] ata2: EH complete
[  220.880010] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  220.880064] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  220.880065]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  220.880171] ata2.00: status: { DRDY }
[  220.880223] ata2: hard resetting link
[  221.200017] ata2: SATA link down (SStatus 100 SControl 300)
[  221.381000] ata2: hard resetting link
[  221.856034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  221.872501] ata2.00: configured for UDMA/133
[  221.872753] ata2: limiting SATA link speed to 1.5 Gbps
[  221.872802] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  221.872852] ata2: hotplug_status 0x2
[  221.872903] ata2: hard resetting link
[  222.752034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  222.768501] ata2.00: configured for UDMA/133
[  222.768550] ata2: EH complete
[  252.768010] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  252.768063] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  252.768064]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  252.768171] ata2.00: status: { DRDY }
[  252.768223] ata2: hard resetting link
[  253.088017] ata2: SATA link down (SStatus 100 SControl 300)
[  253.269002] ata2: hard resetting link
[  253.744034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  253.760916] ata2.00: both IDENTIFYs aborted, assuming NODEV
[  253.760918] ata2.00: revalidation failed (errno=-2)
[  258.744007] ata2: hard resetting link
[  259.220034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  259.236504] ata2.00: configured for UDMA/133
[  259.236756] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  259.236805] ata2: hotplug_status 0x2
[  259.244916] ata2.00: both IDENTIFYs aborted, assuming NODEV
[  259.244918] ata2.00: revalidation failed (errno=-2)
[  259.244970] ata2: hard resetting link
[  260.124035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  260.140502] ata2.00: configured for UDMA/133
[  260.140550] ata2: EH complete
[  290.140011] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  290.140064] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  290.140065]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  290.140172] ata2.00: status: { DRDY }
[  290.140224] ata2: hard resetting link
[  290.460017] ata2: SATA link down (SStatus 100 SControl 300)
[  290.641004] ata2: hard resetting link
[  291.116034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  291.132503] ata2.00: configured for UDMA/133
[  291.132756] ata2.00: limiting speed to UDMA/100:PIO4
[  291.132805] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  291.132854] ata2: hotplug_status 0x2
[  291.132906] ata2: hard resetting link
[  292.012035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  292.028502] ata2.00: configured for UDMA/100
[  292.028550] ata2: EH complete
[  322.028010] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  322.028063] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  322.028065]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  322.028171] ata2.00: status: { DRDY }
[  322.028223] ata2: hard resetting link
[  322.348017] ata2: SATA link down (SStatus 100 SControl 300)
[  322.529002] ata2: hard resetting link
[  323.004035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  323.020503] ata2.00: configured for UDMA/100
[  323.020755] ata2.00: limiting speed to UDMA/33:PIO4
[  323.020804] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  323.020853] ata2: hotplug_status 0x2
[  323.020904] ata2: hard resetting link
[  323.900034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  323.916503] ata2.00: configured for UDMA/33
[  323.916551] ata2: EH complete
[  353.916011] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  353.916064] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  353.916065]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  353.916172] ata2.00: status: { DRDY }
[  353.916223] ata2: hard resetting link
[  354.236016] ata2: SATA link down (SStatus 100 SControl 300)
[  354.417003] ata2: hard resetting link
[  354.892034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  354.908504] ata2.00: configured for UDMA/33
[  354.908757] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  354.908807] ata2: hotplug_status 0x2
[  354.924504] ata2.00: configured for UDMA/33
[  354.924555] sd 1:0:0:0: [sda] START_STOP FAILED
[  354.924602] sd 1:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  354.924696] sd 1:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  354.924886] sd 1:0:0:0: [sda] Add. Sense: No additional sense information
[  354.925002] suspend_device(): scsi_bus_suspend+0x0/0x3f returns 134217730
[  354.925123] PM: Device 1:0:0:0 failed to suspend: error 134217730
[  354.925174] PM: Some devices failed to suspend
[  354.925243] usb usb1: type resume
[  354.953038] ata2: EH complete
[  354.953112] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  354.953173] sd 1:0:0:0: [sda] Write Protect is off
[  354.953221] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  354.953237] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  354.953311] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  354.953368] sd 1:0:0:0: [sda] Write Protect is off
[  354.953416] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  354.953431] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  354.992018] usb usb2: type resume
[  354.992020] usb usb3: type resume
[  355.032009] usb usb4: type resume
[  355.032012] usb usb5: type resume
[  355.032013] usb 3-2: type resume
[  355.083004] i8042 i8042: resume
[  355.083027] atkbd serio0: legacy resume
[  355.083030] psmouse serio1: legacy resume
[  355.083034] ac97 0-0:ALC655: legacy resume
[  355.083037] platform floppy.0: resume
[  355.083040] rtc rtc0: legacy class resume
[  355.083074] platform floppy.0: completing resume
[  355.083078] i8042 i8042: completing resume
[  355.083081] usb 3-2: completing type resume
[  355.083083] usb usb5: completing type resume
[  355.083085] usb usb4: completing type resume
[  355.083087] usb usb3: completing type resume
[  355.083089] usb usb2: completing type resume
[  355.083091] usb usb1: completing type resume
[  355.083105] serial8250 serial8250: completing resume
[  355.083117] platform vesafb.0: completing resume
[  355.083119] pcspkr pcspkr: completing resume
[  355.083125] pci 0000:01:00.0: completing resume
[  355.083127] k8temp 0000:00:18.3: completing resume
[  355.083129] pci 0000:00:18.2: completing resume
[  355.083130] pci 0000:00:18.1: completing resume
[  355.083132] pci 0000:00:18.0: completing resume
[  355.083134] VIA 82xx Audio 0000:00:11.5: completing resume
[  355.083136] pci 0000:00:11.0: completing resume
[  355.083137] ehci_hcd 0000:00:10.4: completing resume
[  355.083139] uhci_hcd 0000:00:10.3: completing resume
[  355.083141] uhci_hcd 0000:00:10.2: completing resume
[  355.083143] uhci_hcd 0000:00:10.1: completing resume
[  355.083145] uhci_hcd 0000:00:10.0: completing resume
[  355.083147] VIA_IDE 0000:00:0f.1: completing resume
[  355.083148] sata_via 0000:00:0f.0: completing resume
[  355.083150] pci 0000:00:0e.0: completing resume
[  355.083152] sata_promise 0000:00:0d.0: completing resume
[  355.083154] r8169 0000:00:0b.0: completing resume
[  355.083156] sata_via 0000:00:08.0: completing resume
[  355.083157] pci 0000:00:01.0: completing resume
[  355.083159] agpgart-amd64 0000:00:00.0: completing resume
[  355.083170] PM: Finishing wakeup.
[  355.083171] Restarting tasks ... done.

--------------040702020309020103040108
Content-Type: text/plain;
 name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.27.6
# Mon Nov 24 21:57:46 2008
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
# CONFIG_X86_64 is not set
CONFIG_X86=y
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
# CONFIG_GENERIC_LOCKBREAK is not set
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_FAST_CMPXCHG_LOCAL=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
# CONFIG_GENERIC_GPIO is not set
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
# CONFIG_GENERIC_TIME_VSYSCALL is not set
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
# CONFIG_HAVE_CPUMASK_OF_CPU_MAP is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# CONFIG_ZONE_DMA32 is not set
CONFIG_ARCH_POPULATES_NODE_MAP=y
# CONFIG_AUDIT_ARCH is not set
CONFIG_ARCH_SUPPORTS_AOUT=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_TREE=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_CGROUPS=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_NS=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_GROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_USER_SCHED=y
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_RESOURCE_COUNTERS is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
CONFIG_RELAY=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_COMPAT_BRK is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_PROFILING=y
# CONFIG_MARKERS is not set
CONFIG_OPROFILE=m
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
# CONFIG_HAVE_ARCH_TRACEHOOK is not set
# CONFIG_HAVE_DMA_ATTRS is not set
# CONFIG_USE_GENERIC_SMP_HELPERS is not set
# CONFIG_HAVE_CLK is not set
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_BLOCK=y
CONFIG_LBD=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_LSF=y
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_CLASSIC_RCU=y

#
# Processor type and features
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
# CONFIG_SMP is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_VSMP is not set
# CONFIG_X86_RDC321X is not set
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_PARAVIRT_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_VMI is not set
# CONFIG_KVM_CLOCK is not set
# CONFIG_KVM_GUEST is not set
# CONFIG_LGUEST_GUEST is not set
# CONFIG_PARAVIRT is not set
# CONFIG_PARAVIRT_CLOCK is not set
# CONFIG_MEMTEST is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
CONFIG_MK8=y
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_GENERIC_CPU is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CPU=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_XADD=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_IOMMU_HELPER is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_RCU is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=m
# CONFIG_X86_MCE_P4THERMAL is not set
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_HIGHPTE is not set
CONFIG_X86_RESERVE_LOW_64K=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x100000
# CONFIG_COMPAT_VDSO is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_VERBOSE=y
CONFIG_CAN_PM_TRACE=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_SLEEP=y
CONFIG_SUSPEND=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_PROCFS=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_SYSFS_POWER=y
CONFIG_ACPI_PROC_EVENT=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_BAY=m
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_WMI=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_DEBUG_FUNC_TRACE is not set
CONFIG_ACPI_EC=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m
CONFIG_ACPI_SBS=m
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_X86_CPUFREQ_NFORCE2=y
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_ARCH_SUPPORTS_MSI=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY=y
# CONFIG_PCI_DEBUG is not set
CONFIG_HT_IRQ=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
CONFIG_K8_NB=y
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_LRO=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_DEFAULT_BIC is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_CT_ACCT=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CT_PROTO_DCCP is not set
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=m
CONFIG_NF_CT_PROTO_UDPLITE=m
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_CONNTRACK_IPV4=m
CONFIG_NF_CONNTRACK_PROC_COMPAT=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_PROTO_UDPLITE=m
CONFIG_NF_NAT_PROTO_SCTP=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_NF_NAT_SIP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_SECURITY is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_AF_RXRPC=m
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_FIB_RULES=y

#
# Wireless
#
# CONFIG_CFG80211 is not set
CONFIG_WIRELESS_EXT=y
# CONFIG_WIRELESS_EXT_SYSFS is not set
# CONFIG_MAC80211 is not set
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=m
# CONFIG_IEEE80211_CRYPT_CCMP is not set
# CONFIG_IEEE80211_CRYPT_TKIP is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_TIMINGS=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_PLATFORM is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_BLK_DEV_TC86C001 is not set
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_TGT=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
# CONFIG_SCSI_FC_TGT_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=m
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=m
# CONFIG_SCSI_SRP_TGT_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y
CONFIG_SATA_AHCI=y
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y
# CONFIG_SATA_SVW is not set
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
CONFIG_SATA_PROMISE=y
CONFIG_SATA_SX4=y
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
CONFIG_SATA_VIA=y
# CONFIG_SATA_VITESSE is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_PATA_ACPI is not set
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_ATA_GENERIC=y
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set
# CONFIG_PATA_SCH is not set
# CONFIG_MD is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# Enable only one of the two stacks, unless you know what you are doing
#
# CONFIG_FIREWIRE is not set
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
CONFIG_VETH=m
# CONFIG_NET_SB1000 is not set
# CONFIG_ARCNET is not set
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_NET_PCI is not set
# CONFIG_B44 is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_E1000E is not set
# CONFIG_IP1000 is not set
# CONFIG_IGB is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_R8169=y
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set
# CONFIG_IWLWIFI_LEDS is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_DEVKMEM=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_SIMTEC is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Graphics adapter I2C/DDC channel drivers
#
# CONFIG_I2C_VOODOO3 is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_STUB is not set
# CONFIG_SCx200_ACB is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_DS1682 is not set
# CONFIG_AT24 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_PCF8575 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
# CONFIG_SPI is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7473=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_FSCPOS=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_HWMON_DEBUG_CHIP is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_TMIO is not set

#
# Multimedia devices
#

#
# Multimedia core support
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_VIDEO_MEDIA is not set

#
# Multimedia drivers
#
# CONFIG_DAB is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_AGP_EFFICEON=m
CONFIG_DRM=m
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_I915=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
CONFIG_DRM_VIA=m
CONFIG_DRM_SAVAGE=m
CONFIG_VGASTATE=m
CONFIG_VIDEO_OUTPUT_CONTROL=m
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_SVGALIB=m
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
# CONFIG_FB_HGA_ACCEL is not set
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
CONFIG_FB_I810=m
# CONFIG_FB_I810_GTF is not set
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_INTEL=m
# CONFIG_FB_INTEL_DEBUG is not set
CONFIG_FB_INTEL_I2C=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=m
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
CONFIG_FB_CYBLA=m
CONFIG_FB_TRIDENT=m
# CONFIG_FB_TRIDENT_ACCEL is not set
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
# CONFIG_FB_CARMINE is not set
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=m
CONFIG_FB_GEODE_GX=m
CONFIG_FB_GEODE_GX1=m
CONFIG_FB_VIRTUAL=m
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_CORGI is not set
# CONFIG_BACKLIGHT_PROGEAR is not set
# CONFIG_BACKLIGHT_MBP_NVIDIA is not set

#
# Display device support
#
CONFIG_DISPLAY_SUPPORT=y

#
# Display hardware drivers
#

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=100
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_HIFIER is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=y
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_USB is not set
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=y
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HID_DEBUG is not set
CONFIG_HIDRAW=y

#
# USB Input Devices
#
CONFIG_USB_HID=m
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_DEVICE_CLASS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
# CONFIG_USB_STORAGE_ONETOUCH is not set
CONFIG_USB_STORAGE_KARMA=y
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=y

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_S35390A=m
# CONFIG_RTC_DRV_FM3130 is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_DMADEVICES is not set
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_SMX is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_ISCSI_IBFT_FIND is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=y
CONFIG_GENERIC_ACL=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RPCSEC_GSS_SPKM3=m
# CONFIG_SMB_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG2 is not set
CONFIG_CIFS_EXPERIMENTAL=y
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_SYSCTL_SYSCALL_CHECK=y
CONFIG_HAVE_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
# CONFIG_FTRACE is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SYSPROF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_CONTEXT_SWITCH_TRACER is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_DEBUG_NX_TEST is not set
# CONFIG_4KSTACKS is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_MMIOTRACE is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_FILE_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT is not set
# CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=m
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_SEQIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=m
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SALSA20_586=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_586=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_GEODE=m
CONFIG_CRYPTO_DEV_HIFN_795X=m
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_LGUEST is not set
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_AUDIT_GENERIC=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y

--------------040702020309020103040108
Content-Type: text/plain;
 name="second-suspend-with-patch-if0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="second-suspend-with-patch-if0"

18.350308] PM: Removing info for No Bus:vcsa1
[   18.350328] PM: Adding info for No Bus:vcs1
[   18.350338] PM: Adding info for No Bus:vcsa1
[   18.350425] PM: Removing info for No Bus:vcs1
[   18.350433] PM: Removing info for No Bus:vcsa1
[   18.350604] PM: Adding info for No Bus:vcs1
[   18.350616] PM: Adding info for No Bus:vcsa1
[   27.645566] ttyS1: LSR safety check engaged!
[   33.499668] PM: Adding info for No Bus:vcs7
[   33.499692] PM: Adding info for No Bus:vcsa7
[   33.557720] PM: Adding info for No Bus:vcs3
[   33.557746] PM: Adding info for No Bus:vcsa3
[   33.559560] PM: Adding info for No Bus:vcs4
[   33.559587] PM: Adding info for No Bus:vcsa4
[   33.560356] PM: Adding info for No Bus:vcs2
[   33.560375] PM: Adding info for No Bus:vcsa2
[   33.561008] PM: Adding info for No Bus:vcs5
[   33.561026] PM: Adding info for No Bus:vcsa5
[   33.562874] PM: Adding info for No Bus:vcs6
[   33.562897] PM: Adding info for No Bus:vcsa6
[   34.796592] PM: Removing info for No Bus:vcs7
[   34.796639] PM: Removing info for No Bus:vcsa7
[  152.885562] PM: Syncing filesystems ... done.
[  152.891145] PM: Preparing system for mem sleep
[  152.892040] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  152.892391] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  152.892551] PM: Entering mem sleep
[  152.892568] agpgart-amd64 0000:00:00.0: preparing suspend
[  152.892571] pci 0000:00:01.0: preparing suspend
[  152.892573] sata_via 0000:00:08.0: preparing suspend
[  152.892575] r8169 0000:00:0b.0: preparing suspend
[  152.892577] sata_promise 0000:00:0d.0: preparing suspend
[  152.892579] pci 0000:00:0e.0: preparing suspend
[  152.892581] sata_via 0000:00:0f.0: preparing suspend
[  152.892583] VIA_IDE 0000:00:0f.1: preparing suspend
[  152.892585] uhci_hcd 0000:00:10.0: preparing suspend
[  152.892587] uhci_hcd 0000:00:10.1: preparing suspend
[  152.892589] uhci_hcd 0000:00:10.2: preparing suspend
[  152.892591] uhci_hcd 0000:00:10.3: preparing suspend
[  152.892593] ehci_hcd 0000:00:10.4: preparing suspend
[  152.892595] pci 0000:00:11.0: preparing suspend
[  152.892597] VIA 82xx Audio 0000:00:11.5: preparing suspend
[  152.892599] pci 0000:00:18.0: preparing suspend
[  152.892601] pci 0000:00:18.1: preparing suspend
[  152.892603] pci 0000:00:18.2: preparing suspend
[  152.892605] k8temp 0000:00:18.3: preparing suspend
[  152.892607] pci 0000:01:00.0: preparing suspend
[  152.892615] pcspkr pcspkr: preparing suspend
[  152.892618] platform vesafb.0: preparing suspend
[  152.892637] serial8250 serial8250: preparing suspend
[  152.892661] usb usb1: preparing type suspend, may wakeup
[  152.892664] usb usb2: preparing type suspend, may wakeup
[  152.892667] usb usb3: preparing type suspend, may wakeup
[  152.892671] usb usb4: preparing type suspend, may wakeup
[  152.892674] usb usb5: preparing type suspend, may wakeup
[  152.892676] usb 3-2: preparing type suspend, may wakeup
[  152.892680] i8042 i8042: preparing suspend
[  152.892688] platform floppy.0: preparing suspend
[  152.892699] rtc rtc0: legacy class suspend
[  152.892727] platform floppy.0: suspend
[  152.892730] ac97 0-0:ALC655: legacy suspend
[  152.892733] psmouse serio1: legacy suspend
[  153.352694] atkbd serio0: legacy suspend
[  153.896004] i8042 i8042: suspend
[  153.896014] usb 3-2: type suspend, may wakeup
[  153.912010] usb usb5: type suspend, may wakeup
[  153.912012] usb usb4: type suspend, may wakeup
[  153.912015] usb usb3: type suspend, may wakeup
[  153.912029] usb usb2: type suspend, may wakeup
[  153.912031] usb usb1: type suspend, may wakeup
[  153.912035] sd 1:0:0:0: legacy suspend
[  153.912040] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  153.912238] sd 1:0:0:0: [sda] Stopping disk
[  154.227094] serial8250 serial8250: suspend
[  154.227108] platform vesafb.0: suspend
[  154.227110] pcspkr pcspkr: suspend
[  154.227117] i8042 kbd 00:0a: legacy suspend
[  154.227136] i8042 aux 00:09: legacy suspend
[  154.227140] pnp 00:08: legacy suspend
[  154.227142] pnp 00:07: legacy suspend
[  154.227144] rtc_cmos 00:06: legacy suspend, may wakeup
[  154.227151] pnp 00:05: legacy suspend
[  154.227153] system 00:04: legacy suspend
[  154.227157] pnp 00:03: legacy suspend
[  154.227159] serial 00:02: legacy suspend
[  154.227311] serial 00:02: disabled
[  154.227378] pnp 00:01: legacy suspend
[  154.227380] pnp 00:00: legacy suspend
[  154.227382] pci 0000:01:00.0: suspend
[  154.227398] k8temp 0000:00:18.3: suspend
[  154.227403] pci 0000:00:18.2: suspend
[  154.227407] pci 0000:00:18.1: suspend
[  154.227412] pci 0000:00:18.0: suspend
[  154.227418] VIA 82xx Audio 0000:00:11.5: suspend
[  154.228137] VIA 82xx Audio 0000:00:11.5: PCI INT C disabled
[  154.244005] pci 0000:00:11.0: suspend
[  154.244028] ehci_hcd 0000:00:10.4: suspend
[  154.244055] ehci_hcd 0000:00:10.4: PCI INT C disabled
[  154.260004] uhci_hcd 0000:00:10.3: suspend
[  154.260031] uhci_hcd 0000:00:10.3: PCI INT B disabled
[  154.276004] uhci_hcd 0000:00:10.2: suspend
[  154.276030] uhci_hcd 0000:00:10.2: PCI INT B disabled
[  154.292004] uhci_hcd 0000:00:10.1: suspend
[  154.292030] uhci_hcd 0000:00:10.1: PCI INT A disabled
[  154.308004] uhci_hcd 0000:00:10.0: suspend
[  154.308030] uhci_hcd 0000:00:10.0: PCI INT A disabled
[  154.324004] VIA_IDE 0000:00:0f.1: suspend
[  154.324027] sata_via 0000:00:0f.0: suspend
[  154.670667] sata_via 0000:00:0f.0: PCI INT B disabled
[  154.684003] pci 0000:00:0e.0: suspend
[  154.684026] sata_promise 0000:00:0d.0: suspend
[  154.684688] sata_promise 0000:00:0d.0: PCI INT A disabled
[  154.700004] r8169 0000:00:0b.0: suspend
[  154.700030] ACPI handle has no context!
[  154.700034] ACPI handle has no context!
[  154.716003] sata_via 0000:00:08.0: suspend
[  154.716064] sata_via 0000:00:08.0: PCI INT A disabled
[  154.732003] pci 0000:00:01.0: suspend
[  154.732021] agpgart-amd64 0000:00:00.0: suspend
[  154.732052] ACPI handle has no context!
[  154.748004] acpi LNXTHERM:00: legacy suspend
[  154.748006] button PNP0C0E:00: legacy suspend
[  154.748008] pci_link PNP0C0F:07: legacy suspend
[  154.748010] pci_link PNP0C0F:06: legacy suspend
[  154.748012] pci_link PNP0C0F:05: legacy suspend
[  154.748014] pci_link PNP0C0F:04: legacy suspend
[  154.748016] pci_link PNP0C0F:03: legacy suspend
[  154.748018] pci_link PNP0C0F:02: legacy suspend
[  154.748020] pci_link PNP0C0F:01: legacy suspend
[  154.748022] pci_link PNP0C0F:00: legacy suspend
[  154.748023] acpi device:13: legacy suspend
[  154.748025] acpi device:12: legacy suspend
[  154.748027] acpi device:11: legacy suspend
[  154.748029] acpi device:10: legacy suspend
[  154.748030] acpi device:0f: legacy suspend
[  154.748032] acpi device:0e: legacy suspend
[  154.748034] acpi device:0d: legacy suspend
[  154.748036] acpi device:0c: legacy suspend
[  154.748037] acpi device:0b: legacy suspend
[  154.748039] acpi device:0a: legacy suspend
[  154.748041] acpi device:09: legacy suspend
[  154.748043] acpi device:08: legacy suspend
[  154.748045] acpi PNP0303:00: legacy suspend
[  154.748047] acpi PNP0F13:00: legacy suspend
[  154.748048] acpi PNP0C04:00: legacy suspend
[  154.748050] acpi PNP0800:00: legacy suspend
[  154.748052] acpi PNP0B00:00: legacy suspend
[  154.748054] acpi PNP0100:00: legacy suspend
[  154.748056] acpi PNP0200:00: legacy suspend
[  154.748057] acpi PNP0C02:00: legacy suspend
[  154.748059] acpi device:07: legacy suspend
[  154.748061] acpi device:06: legacy suspend
[  154.748063] acpi device:05: legacy suspend
[  154.748065] acpi device:04: legacy suspend
[  154.748066] acpi device:03: legacy suspend
[  154.748068] acpi device:02: legacy suspend
[  154.748070] acpi device:01: legacy suspend
[  154.748072] power LNXPOWER:03: legacy suspend
[  154.748074] power LNXPOWER:02: legacy suspend
[  154.748075] power LNXPOWER:01: legacy suspend
[  154.748077] power LNXPOWER:00: legacy suspend
[  154.748079] acpi PNP0401:00: legacy suspend
[  154.748081] acpi PNP0501:00: legacy suspend
[  154.748083] acpi PNP0700:00: legacy suspend
[  154.748085] pci_root PNP0A03:00: legacy suspend
[  154.748086] button PNP0C0C:00: legacy suspend
[  154.748088] acpi device:00: legacy suspend
[  154.748090] processor ACPI0007:00: legacy suspend
[  154.748092] button LNXPWRBN:00: legacy suspend
[  154.748094] acpi LNXSYSTM:00: legacy suspend
[  154.748229] ACPI: Preparing to enter system sleep state S3
[  154.748518] platform floppy.0: LATE suspend
[  154.748523] i8042 i8042: LATE suspend
[  154.748534] serial8250 serial8250: LATE suspend
[  154.748542] platform vesafb.0: LATE suspend
[  154.748544] pcspkr pcspkr: LATE suspend
[  154.748548] pci 0000:01:00.0: LATE suspend
[  154.748550] k8temp 0000:00:18.3: LATE suspend
[  154.748552] pci 0000:00:18.2: LATE suspend
[  154.748554] pci 0000:00:18.1: LATE suspend
[  154.748555] pci 0000:00:18.0: LATE suspend
[  154.748557] VIA 82xx Audio 0000:00:11.5: LATE suspend
[  154.748559] pci 0000:00:11.0: LATE suspend
[  154.748561] ehci_hcd 0000:00:10.4: LATE suspend
[  154.748562] uhci_hcd 0000:00:10.3: LATE suspend
[  154.748564] uhci_hcd 0000:00:10.2: LATE suspend
[  154.748566] uhci_hcd 0000:00:10.1: LATE suspend
[  154.748567] uhci_hcd 0000:00:10.0: LATE suspend
[  154.748569] VIA_IDE 0000:00:0f.1: LATE suspend
[  154.748571] sata_via 0000:00:0f.0: LATE suspend
[  154.748573] pci 0000:00:0e.0: LATE suspend
[  154.748575] sata_promise 0000:00:0d.0: LATE suspend
[  154.748576] r8169 0000:00:0b.0: LATE suspend
[  154.748578] sata_via 0000:00:08.0: LATE suspend
[  154.748580] pci 0000:00:01.0: LATE suspend
[  154.748582] agpgart-amd64 0000:00:00.0: LATE suspend
[  154.752001]  hwsleep-0311 [00] enter_sleep_state     : Entering sleep state [S3]
[  154.752001] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[  154.752001] Intel machine check architecture supported.
[  154.752001] Intel machine check reporting enabled on CPU#0.
[  154.752001] evxfevnt-0079 [00] enable                : System is already in ACPI mode
[  154.752001] Back to C!
[  154.752001] agpgart-amd64 0000:00:00.0: EARLY resume
[  154.752001] pci 0000:00:01.0: EARLY resume
[  154.752001] sata_via 0000:00:08.0: EARLY resume
[  154.752001] r8169 0000:00:0b.0: EARLY resume
[  154.752001] sata_promise 0000:00:0d.0: EARLY resume
[  154.752001] pci 0000:00:0e.0: EARLY resume
[  154.752001] sata_via 0000:00:0f.0: EARLY resume
[  154.752001] VIA_IDE 0000:00:0f.1: EARLY resume
[  154.752001] uhci_hcd 0000:00:10.0: EARLY resume
[  154.752001] uhci_hcd 0000:00:10.1: EARLY resume
[  154.752001] uhci_hcd 0000:00:10.2: EARLY resume
[  154.752001] uhci_hcd 0000:00:10.3: EARLY resume
[  154.752001] ehci_hcd 0000:00:10.4: EARLY resume
[  154.752001] pci 0000:00:11.0: EARLY resume
[  154.752001] VIA 82xx Audio 0000:00:11.5: EARLY resume
[  154.752001] pci 0000:00:18.0: EARLY resume
[  154.752001] pci 0000:00:18.1: EARLY resume
[  154.752001] pci 0000:00:18.2: EARLY resume
[  154.752001] k8temp 0000:00:18.3: EARLY resume
[  154.752001] pci 0000:01:00.0: EARLY resume
[  154.752001] pcspkr pcspkr: EARLY resume
[  154.752001] platform vesafb.0: EARLY resume
[  154.752001] serial8250 serial8250: EARLY resume
[  154.752001] i8042 i8042: EARLY resume
[  154.752001] platform floppy.0: EARLY resume
[  154.752001] ACPI: Waking up from system sleep state S3
[  155.408139] acpi LNXSYSTM:00: legacy resume
[  155.408142] button LNXPWRBN:00: legacy resume
[  155.408144] processor ACPI0007:00: legacy resume
[  155.408146] acpi device:00: legacy resume
[  155.408148] button PNP0C0C:00: legacy resume
[  155.408150] pci_root PNP0A03:00: legacy resume
[  155.408152] acpi PNP0700:00: legacy resume
[  155.408153] acpi PNP0501:00: legacy resume
[  155.408155] acpi PNP0401:00: legacy resume
[  155.408157] power LNXPOWER:00: legacy resume
[  155.408184] power LNXPOWER:01: legacy resume
[  155.408208] power LNXPOWER:02: legacy resume
[  155.408231] power LNXPOWER:03: legacy resume
[  155.408254] acpi device:01: legacy resume
[  155.408256] acpi device:02: legacy resume
[  155.408257] acpi device:03: legacy resume
[  155.408259] acpi device:04: legacy resume
[  155.408261] acpi device:05: legacy resume
[  155.408263] acpi device:06: legacy resume
[  155.408264] acpi device:07: legacy resume
[  155.408266] acpi PNP0C02:00: legacy resume
[  155.408268] acpi PNP0200:00: legacy resume
[  155.408269] acpi PNP0100:00: legacy resume
[  155.408271] acpi PNP0B00:00: legacy resume
[  155.408273] acpi PNP0800:00: legacy resume
[  155.408275] acpi PNP0C04:00: legacy resume
[  155.408276] acpi PNP0F13:00: legacy resume
[  155.408278] acpi PNP0303:00: legacy resume
[  155.408280] acpi device:08: legacy resume
[  155.408281] acpi device:09: legacy resume
[  155.408283] acpi device:0a: legacy resume
[  155.408285] acpi device:0b: legacy resume
[  155.408287] acpi device:0c: legacy resume
[  155.408288] acpi device:0d: legacy resume
[  155.408290] acpi device:0e: legacy resume
[  155.408292] acpi device:0f: legacy resume
[  155.408293] acpi device:10: legacy resume
[  155.408295] acpi device:11: legacy resume
[  155.408297] acpi device:12: legacy resume
[  155.408299] acpi device:13: legacy resume
[  155.408300] pci_link PNP0C0F:00: legacy resume
[  155.408302] pci_link PNP0C0F:01: legacy resume
[  155.408304] pci_link PNP0C0F:02: legacy resume
[  155.408306] pci_link PNP0C0F:03: legacy resume
[  155.408308] pci_link PNP0C0F:04: legacy resume
[  155.408309] pci_link PNP0C0F:05: legacy resume
[  155.408311] pci_link PNP0C0F:06: legacy resume
[  155.408313] pci_link PNP0C0F:07: legacy resume
[  155.408315] button PNP0C0E:00: legacy resume
[  155.408317] acpi LNXTHERM:00: legacy resume
[  155.408319] agpgart-amd64 0000:00:00.0: resume
[  155.424030] pci 0000:00:01.0: resume
[  155.424053] pci 0000:00:01.0: setting latency timer to 64
[  155.424056] sata_via 0000:00:08.0: resume
[  155.440031] sata_via 0000:00:08.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[  155.440210] r8169 0000:00:0b.0: resume
[  155.456018] r8169 0000:00:0b.0: restoring config space at offset 0x3 (was 0x2008, writing 0x4008)
[  155.456029] sata_promise 0000:00:0d.0: resume
[  155.472029] sata_promise 0000:00:0d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[  155.472108] r8169: eth1: link up
[  155.488409] pci 0000:00:0e.0: resume
[  155.488432] sata_via 0000:00:0f.0: resume
[  155.504026] sata_via 0000:00:0f.0: PCI INT B -> GSI 20 (level, low) -> IRQ 20
[  155.504082] VIA_IDE 0000:00:0f.1: resume
[  155.504108] VIA_IDE 0000:00:0f.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[  155.504159] uhci_hcd 0000:00:10.0: resume
[  155.520005] uhci_hcd 0000:00:10.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  155.520090] usb usb2: root hub lost power or was reset
[  155.520146] uhci_hcd 0000:00:10.1: resume
[  155.536005] uhci_hcd 0000:00:10.1: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  155.536088] usb usb3: root hub lost power or was reset
[  155.536144] uhci_hcd 0000:00:10.2: resume
[  155.552005] uhci_hcd 0000:00:10.2: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[  155.552088] usb usb4: root hub lost power or was reset
[  155.552144] uhci_hcd 0000:00:10.3: resume
[  155.568005] uhci_hcd 0000:00:10.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[  155.568088] usb usb5: root hub lost power or was reset
[  155.568143] ehci_hcd 0000:00:10.4: resume
[  155.584005] ehci_hcd 0000:00:10.4: PCI INT C -> GSI 21 (level, low) -> IRQ 21
[  155.584071] ehci_hcd 0000:00:10.4: restoring config space at offset 0x3 (was 0x802008, writing 0x802010)
[  155.584082] pci 0000:00:11.0: resume
[  155.584105] VIA 82xx Audio 0000:00:11.5: resume
[  155.607221] VIA 82xx Audio 0000:00:11.5: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[  155.607283] VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
[  155.610231] pci 0000:00:18.0: resume
[  155.610236] pci 0000:00:18.1: resume
[  155.610241] pci 0000:00:18.2: resume
[  155.610246] k8temp 0000:00:18.3: resume
[  155.610251] pci 0000:01:00.0: resume
[  155.610257] pci 0000:01:00.0: restoring config space at offset 0xc (was 0x0, writing 0xcfee0000)
[  155.610267] pnp 00:00: legacy resume
[  155.610269] pnp 00:01: legacy resume
[  155.610271] serial 00:02: legacy resume
[  155.610992] serial 00:02: activated
[  155.611041] pnp 00:03: legacy resume
[  155.611043] system 00:04: legacy resume
[  155.611045] pnp 00:05: legacy resume
[  155.611047] rtc_cmos 00:06: legacy resume
[  155.611049] pnp 00:07: legacy resume
[  155.611051] pnp 00:08: legacy resume
[  155.611053] i8042 aux 00:09: legacy resume
[  155.611055] i8042 kbd 00:0a: legacy resume
[  155.611059] pcspkr pcspkr: resume
[  155.611062] platform vesafb.0: resume
[  155.611077] serial8250 serial8250: resume
[  155.611093] sd 1:0:0:0: legacy resume
[  155.611095] sd 1:0:0:0: [sda] Starting disk
[  155.785270] ata4: SATA link down (SStatus 0 SControl 310)
[  155.785332] ata5: SATA link down (SStatus 0 SControl 310)
[  155.808017] ata1: SATA link down (SStatus 0 SControl 300)
[  155.964035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  155.980514] ata2.00: configured for UDMA/133
[  155.989852] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  155.989913] sd 1:0:0:0: [sda] Write Protect is off
[  155.989961] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  155.989977] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  155.990045] usb usb1: type resume
[  156.056021] usb usb2: type resume
[  156.056023] usb usb3: type resume
[  156.304005] usb usb4: type resume
[  156.304008] usb usb5: type resume
[  156.304010] usb 3-2: type resume
[  156.416005] usb 3-2: reset full speed USB device using uhci_hcd and address 2
[  156.562903] i8042 i8042: resume
[  156.562928] atkbd serio0: legacy resume
[  156.562930] psmouse serio1: legacy resume
[  156.562935] ac97 0-0:ALC655: legacy resume
[  156.562938] platform floppy.0: resume
[  156.562943] rtc rtc0: legacy class resume
[  156.562976] platform floppy.0: completing resume
[  156.562980] i8042 i8042: completing resume
[  156.562982] usb 3-2: completing type resume
[  156.562984] usb usb5: completing type resume
[  156.562986] usb usb4: completing type resume
[  156.562988] usb usb3: completing type resume
[  156.562990] usb usb2: completing type resume
[  156.562992] usb usb1: completing type resume
[  156.563003] serial8250 serial8250: completing resume
[  156.563013] platform vesafb.0: completing resume
[  156.563015] pcspkr pcspkr: completing resume
[  156.563019] pci 0000:01:00.0: completing resume
[  156.563021] k8temp 0000:00:18.3: completing resume
[  156.563023] pci 0000:00:18.2: completing resume
[  156.563025] pci 0000:00:18.1: completing resume
[  156.563027] pci 0000:00:18.0: completing resume
[  156.563029] VIA 82xx Audio 0000:00:11.5: completing resume
[  156.563030] pci 0000:00:11.0: completing resume
[  156.563032] ehci_hcd 0000:00:10.4: completing resume
[  156.563034] uhci_hcd 0000:00:10.3: completing resume
[  156.563036] uhci_hcd 0000:00:10.2: completing resume
[  156.563038] uhci_hcd 0000:00:10.1: completing resume
[  156.563039] uhci_hcd 0000:00:10.0: completing resume
[  156.563041] VIA_IDE 0000:00:0f.1: completing resume
[  156.563043] sata_via 0000:00:0f.0: completing resume
[  156.563045] pci 0000:00:0e.0: completing resume
[  156.563047] sata_promise 0000:00:0d.0: completing resume
[  156.563048] r8169 0000:00:0b.0: completing resume
[  156.563050] sata_via 0000:00:08.0: completing resume
[  156.563052] pci 0000:00:01.0: completing resume
[  156.563054] agpgart-amd64 0000:00:00.0: completing resume
[  156.563064] PM: Finishing wakeup.
[  156.563065] Restarting tasks ... done.
[  162.314427] PM: Syncing filesystems ... done.
[  162.318365] PM: Preparing system for mem sleep
[  162.319246] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  162.319607] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  162.319783] PM: Entering mem sleep
[  162.319800] agpgart-amd64 0000:00:00.0: preparing suspend
[  162.319803] pci 0000:00:01.0: preparing suspend
[  162.319805] sata_via 0000:00:08.0: preparing suspend
[  162.319807] r8169 0000:00:0b.0: preparing suspend
[  162.319809] sata_promise 0000:00:0d.0: preparing suspend
[  162.319811] pci 0000:00:0e.0: preparing suspend
[  162.319813] sata_via 0000:00:0f.0: preparing suspend
[  162.319815] VIA_IDE 0000:00:0f.1: preparing suspend
[  162.319817] uhci_hcd 0000:00:10.0: preparing suspend
[  162.319819] uhci_hcd 0000:00:10.1: preparing suspend
[  162.319821] uhci_hcd 0000:00:10.2: preparing suspend
[  162.319823] uhci_hcd 0000:00:10.3: preparing suspend
[  162.319825] ehci_hcd 0000:00:10.4: preparing suspend
[  162.319826] pci 0000:00:11.0: preparing suspend
[  162.319828] VIA 82xx Audio 0000:00:11.5: preparing suspend
[  162.319830] pci 0000:00:18.0: preparing suspend
[  162.319832] pci 0000:00:18.1: preparing suspend
[  162.319834] pci 0000:00:18.2: preparing suspend
[  162.319836] k8temp 0000:00:18.3: preparing suspend
[  162.319838] pci 0000:01:00.0: preparing suspend
[  162.319846] pcspkr pcspkr: preparing suspend
[  162.319849] platform vesafb.0: preparing suspend
[  162.319866] serial8250 serial8250: preparing suspend
[  162.319887] usb usb1: preparing type suspend, may wakeup
[  162.319891] usb usb2: preparing type suspend, may wakeup
[  162.319894] usb usb3: preparing type suspend, may wakeup
[  162.319897] usb usb4: preparing type suspend, may wakeup
[  162.319900] usb usb5: preparing type suspend, may wakeup
[  162.319902] usb 3-2: preparing type suspend, may wakeup
[  162.319906] i8042 i8042: preparing suspend
[  162.319914] platform floppy.0: preparing suspend
[  162.319923] rtc rtc0: legacy class suspend
[  162.319951] platform floppy.0: suspend
[  162.319954] ac97 0-0:ALC655: legacy suspend
[  162.319957] psmouse serio1: legacy suspend
[  162.781309] atkbd serio0: legacy suspend
[  163.324004] i8042 i8042: suspend
[  163.324014] usb 3-2: type suspend, may wakeup
[  163.340006] usb usb5: type suspend, may wakeup
[  163.340008] usb usb4: type suspend, may wakeup
[  163.340010] usb usb3: type suspend, may wakeup
[  163.340024] usb usb2: type suspend, may wakeup
[  163.340026] usb usb1: type suspend, may wakeup
[  163.340030] sd 1:0:0:0: legacy suspend
[  163.340034] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  163.340205] sd 1:0:0:0: [sda] Stopping disk
[  193.340020] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  193.340075] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  193.340076]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  193.340183] ata2.00: status: { DRDY }
[  193.340237] ata2: hard resetting link
[  193.660017] ata2: SATA link down (SStatus 100 SControl 300)
[  193.841017] ata2: hard resetting link
[  194.372032] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  194.388501] ata2.00: configured for UDMA/133
[  194.388756] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  194.388806] ata2: hotplug_status 0x2
[  194.396916] ata2.00: both IDENTIFYs aborted, assuming NODEV
[  194.396918] ata2.00: revalidation failed (errno=-2)
[  194.396970] ata2: hard resetting link
[  195.276035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  195.292499] ata2.00: configured for UDMA/133
[  195.292549] ata2: EH complete
[  225.292010] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  225.292064] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  225.292065]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  225.292172] ata2.00: status: { DRDY }
[  225.292223] ata2: hard resetting link
[  225.612016] ata2: SATA link down (SStatus 100 SControl 300)
[  225.793002] ata2: hard resetting link
[  226.268034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  226.284500] ata2.00: configured for UDMA/133
[  226.284753] ata2: limiting SATA link speed to 1.5 Gbps
[  226.284802] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  226.284851] ata2: hotplug_status 0x2
[  226.284902] ata2: hard resetting link
[  227.164035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  227.180505] ata2.00: configured for UDMA/133
[  227.180554] ata2: EH complete
[  257.180010] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  257.180063] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  257.180064]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  257.180171] ata2.00: status: { DRDY }
[  257.180222] ata2: hard resetting link
[  257.500016] ata2: SATA link down (SStatus 100 SControl 300)
[  257.681002] ata2: hard resetting link
[  258.156034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  258.172501] ata2.00: configured for UDMA/133
[  258.172753] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  258.172803] ata2: hotplug_status 0x2
[  258.188504] ata2.00: configured for UDMA/133
[  258.188553] ata2: EH complete
[  288.188010] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  288.188063] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  288.188064]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  288.188171] ata2.00: status: { DRDY }
[  288.188222] ata2: hard resetting link
[  288.508016] ata2: SATA link down (SStatus 100 SControl 300)
[  288.689002] ata2: hard resetting link
[  289.164034] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  289.180503] ata2.00: configured for UDMA/133
[  289.180756] ata2.00: limiting speed to UDMA/100:PIO4
[  289.180805] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  289.180854] ata2: hotplug_status 0x2
[  289.180906] ata2: hard resetting link
[  290.060035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  290.076503] ata2.00: configured for UDMA/100
[  290.076552] ata2: EH complete
[  320.076010] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  320.076063] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  320.076065]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  320.076171] ata2.00: status: { DRDY }
[  320.076223] ata2: hard resetting link
[  320.396016] ata2: SATA link down (SStatus 100 SControl 300)
[  320.577003] ata2: hard resetting link
[  321.052035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  321.068500] ata2.00: configured for UDMA/100
[  321.068754] ata2.00: limiting speed to UDMA/33:PIO4
[  321.068803] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  321.068852] ata2: hotplug_status 0x2
[  321.068903] ata2: hard resetting link
[  321.948035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  321.964905] ata2.00: both IDENTIFYs aborted, assuming NODEV
[  321.964907] ata2.00: revalidation failed (errno=-2)
[  326.948008] ata2: hard resetting link
[  327.424035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  327.440501] ata2.00: configured for UDMA/33
[  327.440550] ata2: EH complete
[  357.440012] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  357.440065] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  357.440066]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  357.440173] ata2.00: status: { DRDY }
[  357.440224] ata2: hard resetting link
[  357.760016] ata2: SATA link down (SStatus 100 SControl 300)
[  357.941004] ata2: hard resetting link
[  358.416035] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  358.432502] ata2.00: configured for UDMA/33
[  358.432755] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  358.432805] ata2: hotplug_status 0x2
[  358.448502] ata2.00: configured for UDMA/33
[  358.448553] sd 1:0:0:0: [sda] START_STOP FAILED
[  358.448601] sd 1:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  358.448694] sd 1:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  358.448884] sd 1:0:0:0: [sda] Add. Sense: No additional sense information
[  358.449001] suspend_device(): scsi_bus_suspend+0x0/0x3f returns 134217730
[  358.449122] PM: Device 1:0:0:0 failed to suspend: error 134217730
[  358.449171] PM: Some devices failed to suspend
[  358.449243] usb usb1: type resume
[  358.477039] ata2: EH complete
[  358.477118] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  358.477179] sd 1:0:0:0: [sda] Write Protect is off
[  358.477227] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  358.477244] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.477319] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  358.477376] sd 1:0:0:0: [sda] Write Protect is off
[  358.477424] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  358.477440] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.516020] usb usb2: type resume
[  358.516023] usb usb3: type resume
[  358.556010] usb usb4: type resume
[  358.556013] usb usb5: type resume
[  358.556015] usb 3-2: type resume
[  358.607003] i8042 i8042: resume
[  358.607027] atkbd serio0: legacy resume
[  358.607030] psmouse serio1: legacy resume
[  358.607034] ac97 0-0:ALC655: legacy resume
[  358.607037] platform floppy.0: resume
[  358.607042] rtc rtc0: legacy class resume
[  358.607076] platform floppy.0: completing resume
[  358.607080] i8042 i8042: completing resume
[  358.607082] usb 3-2: completing type resume
[  358.607084] usb usb5: completing type resume
[  358.607087] usb usb4: completing type resume
[  358.607089] usb usb3: completing type resume
[  358.607091] usb usb2: completing type resume
[  358.607094] usb usb1: completing type resume
[  358.607108] serial8250 serial8250: completing resume
[  358.607121] platform vesafb.0: completing resume
[  358.607123] pcspkr pcspkr: completing resume
[  358.607129] pci 0000:01:00.0: completing resume
[  358.607132] k8temp 0000:00:18.3: completing resume
[  358.607133] pci 0000:00:18.2: completing resume
[  358.607135] pci 0000:00:18.1: completing resume
[  358.607137] pci 0000:00:18.0: completing resume
[  358.607139] VIA 82xx Audio 0000:00:11.5: completing resume
[  358.607141] pci 0000:00:11.0: completing resume
[  358.607143] ehci_hcd 0000:00:10.4: completing resume
[  358.607145] uhci_hcd 0000:00:10.3: completing resume
[  358.607147] uhci_hcd 0000:00:10.2: completing resume
[  358.607149] uhci_hcd 0000:00:10.1: completing resume
[  358.607151] uhci_hcd 0000:00:10.0: completing resume
[  358.607153] VIA_IDE 0000:00:0f.1: completing resume
[  358.607155] sata_via 0000:00:0f.0: completing resume
[  358.607156] pci 0000:00:0e.0: completing resume
[  358.607158] sata_promise 0000:00:0d.0: completing resume
[  358.607160] r8169 0000:00:0b.0: completing resume
[  358.607162] sata_via 0000:00:08.0: completing resume
[  358.607164] pci 0000:00:01.0: completing resume
[  358.607166] agpgart-amd64 0000:00:00.0: completing resume
[  358.607177] PM: Finishing wakeup.
[  358.607178] Restarting tasks ... done.

--------------040702020309020103040108
Content-Type: text/plain;
 name="suspend-to-disk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="suspend-to-disk"

eeze
[  398.732049] acpi PNP0800:00: legacy freeze
[  398.732051] acpi PNP0B00:00: legacy freeze
[  398.732053] acpi PNP0100:00: legacy freeze
[  398.732055] acpi PNP0200:00: legacy freeze
[  398.732056] acpi PNP0C02:00: legacy freeze
[  398.732058] acpi device:07: legacy freeze
[  398.732060] acpi device:06: legacy freeze
[  398.732062] acpi device:05: legacy freeze
[  398.732063] acpi device:04: legacy freeze
[  398.732065] acpi device:03: legacy freeze
[  398.732067] acpi device:02: legacy freeze
[  398.732069] acpi device:01: legacy freeze
[  398.732070] power LNXPOWER:03: legacy freeze
[  398.732072] power LNXPOWER:02: legacy freeze
[  398.732074] power LNXPOWER:01: legacy freeze
[  398.732076] power LNXPOWER:00: legacy freeze
[  398.732077] acpi PNP0401:00: legacy freeze
[  398.732079] acpi PNP0501:00: legacy freeze
[  398.732081] acpi PNP0700:00: legacy freeze
[  398.732083] pci_root PNP0A03:00: legacy freeze
[  398.732085] button PNP0C0C:00: legacy freeze
[  398.732086] acpi device:00: legacy freeze
[  398.732088] processor ACPI0007:00: legacy freeze
[  398.732090] button LNXPWRBN:00: legacy freeze
[  398.732092] acpi LNXSYSTM:00: legacy freeze
[  398.732193] ACPI: Preparing to enter system sleep state S4
[  398.732447] platform floppy.0: LATE freeze
[  398.732452] i8042 i8042: LATE freeze
[  398.732465] serial8250 serial8250: LATE freeze
[  398.732476] platform vesafb.0: LATE freeze
[  398.732478] pcspkr pcspkr: LATE freeze
[  398.732483] pci 0000:01:00.0: LATE freeze
[  398.732485] k8temp 0000:00:18.3: LATE freeze
[  398.732487] pci 0000:00:18.2: LATE freeze
[  398.732489] pci 0000:00:18.1: LATE freeze
[  398.732490] pci 0000:00:18.0: LATE freeze
[  398.732492] VIA 82xx Audio 0000:00:11.5: LATE freeze
[  398.732494] pci 0000:00:11.0: LATE freeze
[  398.732495] ehci_hcd 0000:00:10.4: LATE freeze
[  398.732497] uhci_hcd 0000:00:10.3: LATE freeze
[  398.732499] uhci_hcd 0000:00:10.2: LATE freeze
[  398.732501] uhci_hcd 0000:00:10.1: LATE freeze
[  398.732502] uhci_hcd 0000:00:10.0: LATE freeze
[  398.732504] VIA_IDE 0000:00:0f.1: LATE freeze
[  398.732506] sata_via 0000:00:0f.0: LATE freeze
[  398.732508] pci 0000:00:0e.0: LATE freeze
[  398.732509] sata_promise 0000:00:0d.0: LATE freeze
[  398.732511] r8169 0000:00:0b.0: LATE freeze
[  398.732513] sata_via 0000:00:08.0: LATE freeze
[  398.732514] pci 0000:00:01.0: LATE freeze
[  398.732516] agpgart-amd64 0000:00:00.0: LATE freeze
[  398.732827] PM: Creating hibernation image: 
[  398.736001] PM: Need to copy 55695 pages
[  398.736001] PM: Normal pages needed: 14957 + 1024 + 40, available pages: 214305
[  398.736001] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[  398.736001] Intel machine check architecture supported.
[  398.736001] Intel machine check reporting enabled on CPU#0.
[  398.736001] evxfevnt-0079 [00] enable                : System is already in ACPI mode
[  398.736001] agpgart-amd64 0000:00:00.0: EARLY restore
[  398.736001] pci 0000:00:01.0: EARLY restore
[  398.736001] sata_via 0000:00:08.0: EARLY restore
[  398.736001] r8169 0000:00:0b.0: EARLY restore
[  398.736001] sata_promise 0000:00:0d.0: EARLY restore
[  398.736001] pci 0000:00:0e.0: EARLY restore
[  398.736001] sata_via 0000:00:0f.0: EARLY restore
[  398.736001] VIA_IDE 0000:00:0f.1: EARLY restore
[  398.736001] uhci_hcd 0000:00:10.0: EARLY restore
[  398.736001] uhci_hcd 0000:00:10.1: EARLY restore
[  398.736001] uhci_hcd 0000:00:10.2: EARLY restore
[  398.736001] uhci_hcd 0000:00:10.3: EARLY restore
[  398.736001] ehci_hcd 0000:00:10.4: EARLY restore
[  398.736001] pci 0000:00:11.0: EARLY restore
[  398.736001] VIA 82xx Audio 0000:00:11.5: EARLY restore
[  398.736001] pci 0000:00:18.0: EARLY restore
[  398.736001] pci 0000:00:18.1: EARLY restore
[  398.736001] pci 0000:00:18.2: EARLY restore
[  398.736001] k8temp 0000:00:18.3: EARLY restore
[  398.736001] pci 0000:01:00.0: EARLY restore
[  398.736001] pcspkr pcspkr: EARLY restore
[  398.736001] platform vesafb.0: EARLY restore
[  398.736001] serial8250 serial8250: EARLY restore
[  398.736001] i8042 i8042: EARLY restore
[  398.736001] platform floppy.0: EARLY restore
[  398.736001] ACPI: Waking up from system sleep state S4
[  399.392104] acpi LNXSYSTM:00: legacy restore
[  399.392106] button LNXPWRBN:00: legacy restore
[  399.392108] processor ACPI0007:00: legacy restore
[  399.392110] acpi device:00: legacy restore
[  399.392112] button PNP0C0C:00: legacy restore
[  399.392114] pci_root PNP0A03:00: legacy restore
[  399.392116] acpi PNP0700:00: legacy restore
[  399.392118] acpi PNP0501:00: legacy restore
[  399.392119] acpi PNP0401:00: legacy restore
[  399.392121] power LNXPOWER:00: legacy restore
[  399.392149] power LNXPOWER:01: legacy restore
[  399.392173] power LNXPOWER:02: legacy restore
[  399.392197] power LNXPOWER:03: legacy restore
[  399.392220] acpi device:01: legacy restore
[  399.392222] acpi device:02: legacy restore
[  399.392224] acpi device:03: legacy restore
[  399.392225] acpi device:04: legacy restore
[  399.392227] acpi device:05: legacy restore
[  399.392229] acpi device:06: legacy restore
[  399.392231] acpi device:07: legacy restore
[  399.392232] acpi PNP0C02:00: legacy restore
[  399.392234] acpi PNP0200:00: legacy restore
[  399.392236] acpi PNP0100:00: legacy restore
[  399.392237] acpi PNP0B00:00: legacy restore
[  399.392239] acpi PNP0800:00: legacy restore
[  399.392241] acpi PNP0C04:00: legacy restore
[  399.392243] acpi PNP0F13:00: legacy restore
[  399.392244] acpi PNP0303:00: legacy restore
[  399.392246] acpi device:08: legacy restore
[  399.392248] acpi device:09: legacy restore
[  399.392249] acpi device:0a: legacy restore
[  399.392251] acpi device:0b: legacy restore
[  399.392253] acpi device:0c: legacy restore
[  399.392255] acpi device:0d: legacy restore
[  399.392256] acpi device:0e: legacy restore
[  399.392258] acpi device:0f: legacy restore
[  399.392260] acpi device:10: legacy restore
[  399.392261] acpi device:11: legacy restore
[  399.392263] acpi device:12: legacy restore
[  399.392265] acpi device:13: legacy restore
[  399.392267] pci_link PNP0C0F:00: legacy restore
[  399.392268] pci_link PNP0C0F:01: legacy restore
[  399.392270] pci_link PNP0C0F:02: legacy restore
[  399.392272] pci_link PNP0C0F:03: legacy restore
[  399.392274] pci_link PNP0C0F:04: legacy restore
[  399.392276] pci_link PNP0C0F:05: legacy restore
[  399.392278] pci_link PNP0C0F:06: legacy restore
[  399.392279] pci_link PNP0C0F:07: legacy restore
[  399.392281] button PNP0C0E:00: legacy restore
[  399.392283] acpi LNXTHERM:00: legacy restore
[  399.392285] agpgart-amd64 0000:00:00.0: restore
[  399.408031] pci 0000:00:01.0: restore
[  399.408054] pci 0000:00:01.0: setting latency timer to 64
[  399.408056] sata_via 0000:00:08.0: restore
[  399.408076] sata_via 0000:00:08.0: restoring config space at offset 0x1 (was 0x2900003, writing 0x2900007)
[  399.408088] sata_via 0000:00:08.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[  399.408269] r8169 0000:00:0b.0: restore
[  399.424026] sata_promise 0000:00:0d.0: restore
[  399.424045] sata_promise 0000:00:0d.0: restoring config space at offset 0x1 (was 0x2300013, writing 0x2300017)
[  399.424056] sata_promise 0000:00:0d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[  399.440012] pci 0000:00:0e.0: restore
[  399.440035] sata_via 0000:00:0f.0: restore
[  399.440054] sata_via 0000:00:0f.0: restoring config space at offset 0x1 (was 0x2900003, writing 0x2900007)
[  399.440064] sata_via 0000:00:0f.0: PCI INT B -> GSI 20 (level, low) -> IRQ 20
[  399.440120] VIA_IDE 0000:00:0f.1: restore
[  399.440147] VIA_IDE 0000:00:0f.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[  399.440197] uhci_hcd 0000:00:10.0: restore
[  399.440201] uhci_hcd 0000:00:10.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  399.440279] uhci_hcd 0000:00:10.1: restore
[  399.440282] uhci_hcd 0000:00:10.1: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  399.440359] uhci_hcd 0000:00:10.2: restore
[  399.440362] uhci_hcd 0000:00:10.2: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[  399.440439] uhci_hcd 0000:00:10.3: restore
[  399.440442] uhci_hcd 0000:00:10.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[  399.440519] ehci_hcd 0000:00:10.4: restore
[  399.440522] ehci_hcd 0000:00:10.4: PCI INT C -> GSI 21 (level, low) -> IRQ 21
[  399.440596] pci 0000:00:11.0: restore
[  399.440619] VIA 82xx Audio 0000:00:11.5: restore
[  399.440906] r8169: eth1: link up
[  399.456026] VIA 82xx Audio 0000:00:11.5: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[  399.456088] VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
[  399.459231] pci 0000:00:18.0: restore
[  399.459237] pci 0000:00:18.1: restore
[  399.459241] pci 0000:00:18.2: restore
[  399.459246] k8temp 0000:00:18.3: restore
[  399.459251] pci 0000:01:00.0: restore
[  399.459264] pnp 00:00: legacy restore
[  399.459266] pnp 00:01: legacy restore
[  399.459268] serial 00:02: legacy restore
[  399.459992] serial 00:02: activated
[  399.460047] pnp 00:03: legacy restore
[  399.460049] system 00:04: legacy restore
[  399.460051] pnp 00:05: legacy restore
[  399.460053] rtc_cmos 00:06: legacy restore
[  399.460069] pnp 00:07: legacy restore
[  399.460071] pnp 00:08: legacy restore
[  399.460073] i8042 aux 00:09: legacy restore
[  399.460075] i8042 kbd 00:0a: legacy restore
[  399.460080] pcspkr pcspkr: restore
[  399.460082] platform vesafb.0: restore
[  399.460097] serial8250 serial8250: restore
[  399.460114] sd 1:0:0:0: legacy restore
[  399.460117] sd 1:0:0:0: [sda] Starting disk
[  399.749270] ata5: SATA link down (SStatus 0 SControl 310)
[  399.749332] ata4: SATA link down (SStatus 0 SControl 310)
[  399.760071] ata1: SATA link down (SStatus 0 SControl 300)
[  399.916031] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  399.932434] ata2.00: configured for UDMA/133
[  399.938058] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  399.938119] sd 1:0:0:0: [sda] Write Protect is off
[  399.938168] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  399.938184] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  399.938252] usb usb1: type restore
[  400.004023] usb usb2: type restore
[  400.004027] usb usb3: type restore
[  400.044010] usb usb4: type restore
[  400.044013] usb usb5: type restore
[  400.044015] usb 3-2: type restore
[  400.044019] i8042 i8042: restore
[  400.044043] atkbd serio0: legacy restore
[  400.044046] psmouse serio1: legacy restore
[  400.044051] ac97 0-0:ALC655: legacy restore
[  400.044055] platform floppy.0: restore
[  400.044060] rtc rtc0: legacy class restore
[  400.044094] platform floppy.0: completing restore
[  400.044098] i8042 i8042: completing restore
[  400.044100] usb 3-2: completing type restore
[  400.044102] usb usb5: completing type restore
[  400.044104] usb usb4: completing type restore
[  400.044106] usb usb3: completing type restore
[  400.044109] usb usb2: completing type restore
[  400.044111] usb usb1: completing type restore
[  400.044123] serial8250 serial8250: completing restore
[  400.044134] platform vesafb.0: completing restore
[  400.044136] pcspkr pcspkr: completing restore
[  400.044141] pci 0000:01:00.0: completing restore
[  400.044143] k8temp 0000:00:18.3: completing restore
[  400.044145] pci 0000:00:18.2: completing restore
[  400.044146] pci 0000:00:18.1: completing restore
[  400.044148] pci 0000:00:18.0: completing restore
[  400.044150] VIA 82xx Audio 0000:00:11.5: completing restore
[  400.044152] pci 0000:00:11.0: completing restore
[  400.044153] ehci_hcd 0000:00:10.4: completing restore
[  400.044155] uhci_hcd 0000:00:10.3: completing restore
[  400.044157] uhci_hcd 0000:00:10.2: completing restore
[  400.044159] uhci_hcd 0000:00:10.1: completing restore
[  400.044161] uhci_hcd 0000:00:10.0: completing restore
[  400.044162] VIA_IDE 0000:00:0f.1: completing restore
[  400.044164] sata_via 0000:00:0f.0: completing restore
[  400.044166] pci 0000:00:0e.0: completing restore
[  400.044168] sata_promise 0000:00:0d.0: completing restore
[  400.044170] r8169 0000:00:0b.0: completing restore
[  400.044172] sata_via 0000:00:08.0: completing restore
[  400.044173] pci 0000:00:01.0: completing restore
[  400.044175] agpgart-amd64 0000:00:00.0: completing restore
[  400.044186] PM: Image restored successfully.
[  400.063578] Restarting tasks ... done.
[  400.076602] PM: Basic memory bitmaps freed
[  400.125190] atkbd.c: Failed to enable keyboard on isa0060/serio0
[  410.812509] PM: Marking nosave pages: 000000000009f000 - 0000000000100000
[  410.812657] PM: Basic memory bitmaps created
[  410.812723] PM: Syncing filesystems ... done.
[  410.828268] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  410.828648] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  410.828824] PM: Shrinking memory...  -done (0 pages freed)
[  410.877257] PM: Freed 0 kbytes in 0.04 seconds (0.00 MB/s)
[  410.877320] agpgart-amd64 0000:00:00.0: preparing freeze
[  410.877322] pci 0000:00:01.0: preparing freeze
[  410.877324] sata_via 0000:00:08.0: preparing freeze
[  410.877326] r8169 0000:00:0b.0: preparing freeze
[  410.877328] sata_promise 0000:00:0d.0: preparing freeze
[  410.877330] pci 0000:00:0e.0: preparing freeze
[  410.877332] sata_via 0000:00:0f.0: preparing freeze
[  410.877334] VIA_IDE 0000:00:0f.1: preparing freeze
[  410.877336] uhci_hcd 0000:00:10.0: preparing freeze
[  410.877338] uhci_hcd 0000:00:10.1: preparing freeze
[  410.877340] uhci_hcd 0000:00:10.2: preparing freeze
[  410.877342] uhci_hcd 0000:00:10.3: preparing freeze
[  410.877344] ehci_hcd 0000:00:10.4: preparing freeze
[  410.877345] pci 0000:00:11.0: preparing freeze
[  410.877347] VIA 82xx Audio 0000:00:11.5: preparing freeze
[  410.877349] pci 0000:00:18.0: preparing freeze
[  410.877351] pci 0000:00:18.1: preparing freeze
[  410.877353] pci 0000:00:18.2: preparing freeze
[  410.877355] k8temp 0000:00:18.3: preparing freeze
[  410.877356] pci 0000:01:00.0: preparing freeze
[  410.877363] pcspkr pcspkr: preparing freeze
[  410.877366] platform vesafb.0: preparing freeze
[  410.877381] serial8250 serial8250: preparing freeze
[  410.877401] usb usb1: preparing type freeze
[  410.877404] usb usb2: preparing type freeze
[  410.877407] usb usb3: preparing type freeze
[  410.877409] usb usb4: preparing type freeze
[  410.877412] usb usb5: preparing type freeze
[  410.877414] usb 3-2: preparing type freeze
[  410.877417] i8042 i8042: preparing freeze
[  410.877424] platform floppy.0: preparing freeze
[  410.877434] rtc rtc0: legacy class freeze
[  410.877461] platform floppy.0: freeze
[  410.877464] ac97 0-0:ALC655: legacy freeze
[  410.877467] psmouse serio1: legacy freeze
[  410.877469] atkbd serio0: legacy freeze
[  410.877470] i8042 i8042: freeze
[  410.877473] usb 3-2: type freeze
[  410.877477] usb usb5: type freeze
[  410.877479] usb usb4: type freeze
[  410.877481] usb usb3: type freeze
[  410.877497] usb usb2: type freeze
[  410.877499] usb usb1: type freeze
[  410.877502] sd 1:0:0:0: legacy freeze
[  410.877508] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  411.416147] serial8250 serial8250: freeze
[  411.416160] platform vesafb.0: freeze
[  411.416162] pcspkr pcspkr: freeze
[  411.416170] i8042 kbd 00:0a: legacy freeze
[  411.416187] i8042 aux 00:09: legacy freeze
[  411.416191] pnp 00:08: legacy freeze
[  411.416193] pnp 00:07: legacy freeze
[  411.416195] rtc_cmos 00:06: legacy freeze
[  411.416202] pnp 00:05: legacy freeze
[  411.416204] system 00:04: legacy freeze
[  411.416208] pnp 00:03: legacy freeze
[  411.416209] serial 00:02: legacy freeze
[  411.416362] serial 00:02: disabled
[  411.416483] pnp 00:01: legacy freeze
[  411.416485] pnp 00:00: legacy freeze
[  411.416487] pci 0000:01:00.0: freeze
[  411.416502] k8temp 0000:00:18.3: freeze
[  411.416507] pci 0000:00:18.2: freeze
[  411.416511] pci 0000:00:18.1: freeze
[  411.416516] pci 0000:00:18.0: freeze
[  411.416522] VIA 82xx Audio 0000:00:11.5: freeze
[  411.417249] VIA 82xx Audio 0000:00:11.5: PCI INT C disabled
[  411.432005] pci 0000:00:11.0: freeze
[  411.432028] ehci_hcd 0000:00:10.4: freeze
[  411.432055] ehci_hcd 0000:00:10.4: PCI INT C disabled
[  411.432103] uhci_hcd 0000:00:10.3: freeze
[  411.432130] uhci_hcd 0000:00:10.3: PCI INT B disabled
[  411.432178] uhci_hcd 0000:00:10.2: freeze
[  411.432204] uhci_hcd 0000:00:10.2: PCI INT B disabled
[  411.432252] uhci_hcd 0000:00:10.1: freeze
[  411.432278] uhci_hcd 0000:00:10.1: PCI INT A disabled
[  411.432326] uhci_hcd 0000:00:10.0: freeze
[  411.432352] uhci_hcd 0000:00:10.0: PCI INT A disabled
[  411.432400] VIA_IDE 0000:00:0f.1: freeze
[  411.432422] sata_via 0000:00:0f.0: freeze
[  411.432478] sata_via 0000:00:0f.0: PCI INT B disabled
[  411.432526] pci 0000:00:0e.0: freeze
[  411.432549] sata_promise 0000:00:0d.0: freeze
[  411.433208] sata_promise 0000:00:0d.0: PCI INT A disabled
[  411.433256] r8169 0000:00:0b.0: freeze
[  411.433283] ACPI handle has no context!
[  411.433287] ACPI handle has no context!
[  411.448003] sata_via 0000:00:08.0: freeze
[  411.448061] sata_via 0000:00:08.0: PCI INT A disabled
[  411.448110] pci 0000:00:01.0: freeze
[  411.448127] agpgart-amd64 0000:00:00.0: freeze
[  411.448158] ACPI handle has no context!
[  411.464005] acpi LNXTHERM:00: legacy freeze
[  411.464007] button PNP0C0E:00: legacy freeze
[  411.464009] pci_link PNP0C0F:07: legacy freeze
[  411.464011] pci_link PNP0C0F:06: legacy freeze
[  411.464013] pci_link PNP0C0F:05: legacy freeze
[  411.464015] pci_link PNP0C0F:04: legacy freeze
[  411.464016] pci_link PNP0C0F:03: legacy freeze
[  411.464018] pci_link PNP0C0F:02: legacy freeze
[  411.464020] pci_link PNP0C0F:01: legacy freeze
[  411.464022] pci_link PNP0C0F:00: legacy freeze
[  411.464024] acpi device:13: legacy freeze
[  411.464025] acpi device:12: legacy freeze
[  411.464027] acpi device:11: legacy freeze
[  411.464029] acpi device:10: legacy freeze
[  411.464030] acpi device:0f: legacy freeze
[  411.464032] acpi device:0e: legacy freeze
[  411.464034] acpi device:0d: legacy freeze
[  411.464036] acpi device:0c: legacy freeze
[  411.464037] acpi device:0b: legacy freeze
[  411.464039] acpi device:0a: legacy freeze
[  411.464041] acpi device:09: legacy freeze
[  411.464043] acpi device:08: legacy freeze
[  411.464044] acpi PNP0303:00: legacy freeze
[  411.464046] acpi PNP0F13:00: legacy freeze
[  411.464048] acpi PNP0C04:00: legacy freeze
[  411.464050] acpi PNP0800:00: legacy freeze
[  411.464051] acpi PNP0B00:00: legacy freeze
[  411.464053] acpi PNP0100:00: legacy freeze
[  411.464055] acpi PNP0200:00: legacy freeze
[  411.464057] acpi PNP0C02:00: legacy freeze
[  411.464058] acpi device:07: legacy freeze
[  411.464060] acpi device:06: legacy freeze
[  411.464062] acpi device:05: legacy freeze
[  411.464064] acpi device:04: legacy freeze
[  411.464066] acpi device:03: legacy freeze
[  411.464067] acpi device:02: legacy freeze
[  411.464069] acpi device:01: legacy freeze
[  411.464071] power LNXPOWER:03: legacy freeze
[  411.464073] power LNXPOWER:02: legacy freeze
[  411.464074] power LNXPOWER:01: legacy freeze
[  411.464076] power LNXPOWER:00: legacy freeze
[  411.464078] acpi PNP0401:00: legacy freeze
[  411.464080] acpi PNP0501:00: legacy freeze
[  411.464082] acpi PNP0700:00: legacy freeze
[  411.464083] pci_root PNP0A03:00: legacy freeze
[  411.464085] button PNP0C0C:00: legacy freeze
[  411.464087] acpi device:00: legacy freeze
[  411.464089] processor ACPI0007:00: legacy freeze
[  411.464091] button LNXPWRBN:00: legacy freeze
[  411.464093] acpi LNXSYSTM:00: legacy freeze
[  411.464195] ACPI: Preparing to enter system sleep state S4
[  411.464533] platform floppy.0: LATE freeze
[  411.464538] i8042 i8042: LATE freeze
[  411.464551] serial8250 serial8250: LATE freeze
[  411.464562] platform vesafb.0: LATE freeze
[  411.464564] pcspkr pcspkr: LATE freeze
[  411.464568] pci 0000:01:00.0: LATE freeze
[  411.464571] k8temp 0000:00:18.3: LATE freeze
[  411.464572] pci 0000:00:18.2: LATE freeze
[  411.464574] pci 0000:00:18.1: LATE freeze
[  411.464576] pci 0000:00:18.0: LATE freeze
[  411.464577] VIA 82xx Audio 0000:00:11.5: LATE freeze
[  411.464579] pci 0000:00:11.0: LATE freeze
[  411.464581] ehci_hcd 0000:00:10.4: LATE freeze
[  411.464583] uhci_hcd 0000:00:10.3: LATE freeze
[  411.464585] uhci_hcd 0000:00:10.2: LATE freeze
[  411.464586] uhci_hcd 0000:00:10.1: LATE freeze
[  411.464588] uhci_hcd 0000:00:10.0: LATE freeze
[  411.464590] VIA_IDE 0000:00:0f.1: LATE freeze
[  411.464592] sata_via 0000:00:0f.0: LATE freeze
[  411.464593] pci 0000:00:0e.0: LATE freeze
[  411.464595] sata_promise 0000:00:0d.0: LATE freeze
[  411.464597] r8169 0000:00:0b.0: LATE freeze
[  411.464598] sata_via 0000:00:08.0: LATE freeze
[  411.464600] pci 0000:00:01.0: LATE freeze
[  411.464602] agpgart-amd64 0000:00:00.0: LATE freeze
[  411.464912] PM: Creating hibernation image: 
[  411.468001] PM: Need to copy 55719 pages
[  411.468001] PM: Normal pages needed: 15034 + 1024 + 40, available pages: 214228
[  411.468001] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[  411.468001] Intel machine check architecture supported.
[  411.468001] Intel machine check reporting enabled on CPU#0.
[  411.468001] evxfevnt-0079 [00] enable                : System is already in ACPI mode
[  411.468001] agpgart-amd64 0000:00:00.0: EARLY restore
[  411.468001] pci 0000:00:01.0: EARLY restore
[  411.468001] sata_via 0000:00:08.0: EARLY restore
[  411.468001] r8169 0000:00:0b.0: EARLY restore
[  411.468001] sata_promise 0000:00:0d.0: EARLY restore
[  411.468001] pci 0000:00:0e.0: EARLY restore
[  411.468001] sata_via 0000:00:0f.0: EARLY restore
[  411.468001] VIA_IDE 0000:00:0f.1: EARLY restore
[  411.468001] uhci_hcd 0000:00:10.0: EARLY restore
[  411.468001] uhci_hcd 0000:00:10.1: EARLY restore
[  411.468001] uhci_hcd 0000:00:10.2: EARLY restore
[  411.468001] uhci_hcd 0000:00:10.3: EARLY restore
[  411.468001] ehci_hcd 0000:00:10.4: EARLY restore
[  411.468001] pci 0000:00:11.0: EARLY restore
[  411.468001] VIA 82xx Audio 0000:00:11.5: EARLY restore
[  411.468001] pci 0000:00:18.0: EARLY restore
[  411.468001] pci 0000:00:18.1: EARLY restore
[  411.468001] pci 0000:00:18.2: EARLY restore
[  411.468001] k8temp 0000:00:18.3: EARLY restore
[  411.468001] pci 0000:01:00.0: EARLY restore
[  411.468001] pcspkr pcspkr: EARLY restore
[  411.468001] platform vesafb.0: EARLY restore
[  411.468001] serial8250 serial8250: EARLY restore
[  411.468001] i8042 i8042: EARLY restore
[  411.468001] platform floppy.0: EARLY restore
[  411.468001] ACPI: Waking up from system sleep state S4
[  412.124102] acpi LNXSYSTM:00: legacy restore
[  412.124105] button LNXPWRBN:00: legacy restore
[  412.124107] processor ACPI0007:00: legacy restore
[  412.124109] acpi device:00: legacy restore
[  412.124111] button PNP0C0C:00: legacy restore
[  412.124113] pci_root PNP0A03:00: legacy restore
[  412.124114] acpi PNP0700:00: legacy restore
[  412.124116] acpi PNP0501:00: legacy restore
[  412.124118] acpi PNP0401:00: legacy restore
[  412.124120] power LNXPOWER:00: legacy restore
[  412.124147] power LNXPOWER:01: legacy restore
[  412.124171] power LNXPOWER:02: legacy restore
[  412.124195] power LNXPOWER:03: legacy restore
[  412.124218] acpi device:01: legacy restore
[  412.124220] acpi device:02: legacy restore
[  412.124221] acpi device:03: legacy restore
[  412.124223] acpi device:04: legacy restore
[  412.124225] acpi device:05: legacy restore
[  412.124227] acpi device:06: legacy restore
[  412.124228] acpi device:07: legacy restore
[  412.124230] acpi PNP0C02:00: legacy restore
[  412.124232] acpi PNP0200:00: legacy restore
[  412.124233] acpi PNP0100:00: legacy restore
[  412.124235] acpi PNP0B00:00: legacy restore
[  412.124237] acpi PNP0800:00: legacy restore
[  412.124238] acpi PNP0C04:00: legacy restore
[  412.124240] acpi PNP0F13:00: legacy restore
[  412.124242] acpi PNP0303:00: legacy restore
[  412.124244] acpi device:08: legacy restore
[  412.124245] acpi device:09: legacy restore
[  412.124247] acpi device:0a: legacy restore
[  412.124249] acpi device:0b: legacy restore
[  412.124250] acpi device:0c: legacy restore
[  412.124252] acpi device:0d: legacy restore
[  412.124254] acpi device:0e: legacy restore
[  412.124255] acpi device:0f: legacy restore
[  412.124257] acpi device:10: legacy restore
[  412.124259] acpi device:11: legacy restore
[  412.124260] acpi device:12: legacy restore
[  412.124262] acpi device:13: legacy restore
[  412.124264] pci_link PNP0C0F:00: legacy restore
[  412.124266] pci_link PNP0C0F:01: legacy restore
[  412.124267] pci_link PNP0C0F:02: legacy restore
[  412.124269] pci_link PNP0C0F:03: legacy restore
[  412.124271] pci_link PNP0C0F:04: legacy restore
[  412.124273] pci_link PNP0C0F:05: legacy restore
[  412.124275] pci_link PNP0C0F:06: legacy restore
[  412.124276] pci_link PNP0C0F:07: legacy restore
[  412.124278] button PNP0C0E:00: legacy restore
[  412.124280] acpi LNXTHERM:00: legacy restore
[  412.124282] agpgart-amd64 0000:00:00.0: restore
[  412.140030] pci 0000:00:01.0: restore
[  412.140053] pci 0000:00:01.0: setting latency timer to 64
[  412.140056] sata_via 0000:00:08.0: restore
[  412.140075] sata_via 0000:00:08.0: restoring config space at offset 0x1 (was 0x2900003, writing 0x2900007)
[  412.140088] sata_via 0000:00:08.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[  412.140268] r8169 0000:00:0b.0: restore
[  412.156026] sata_promise 0000:00:0d.0: restore
[  412.156045] sata_promise 0000:00:0d.0: restoring config space at offset 0x1 (was 0x2300013, writing 0x2300017)
[  412.156055] sata_promise 0000:00:0d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[  412.172012] pci 0000:00:0e.0: restore
[  412.172034] sata_via 0000:00:0f.0: restore
[  412.172054] sata_via 0000:00:0f.0: restoring config space at offset 0x1 (was 0x2900003, writing 0x2900007)
[  412.172064] sata_via 0000:00:0f.0: PCI INT B -> GSI 20 (level, low) -> IRQ 20
[  412.172120] VIA_IDE 0000:00:0f.1: restore
[  412.172146] VIA_IDE 0000:00:0f.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[  412.172197] uhci_hcd 0000:00:10.0: restore
[  412.172201] uhci_hcd 0000:00:10.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  412.172278] uhci_hcd 0000:00:10.1: restore
[  412.172281] uhci_hcd 0000:00:10.1: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  412.172358] uhci_hcd 0000:00:10.2: restore
[  412.172362] uhci_hcd 0000:00:10.2: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[  412.172438] uhci_hcd 0000:00:10.3: restore
[  412.172442] uhci_hcd 0000:00:10.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[  412.172518] ehci_hcd 0000:00:10.4: restore
[  412.172522] ehci_hcd 0000:00:10.4: PCI INT C -> GSI 21 (level, low) -> IRQ 21
[  412.172595] pci 0000:00:11.0: restore
[  412.172619] VIA 82xx Audio 0000:00:11.5: restore
[  412.173442] r8169: eth1: link up
[  412.188026] VIA 82xx Audio 0000:00:11.5: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[  412.188089] VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
[  412.191231] pci 0000:00:18.0: restore
[  412.191237] pci 0000:00:18.1: restore
[  412.191242] pci 0000:00:18.2: restore
[  412.191246] k8temp 0000:00:18.3: restore
[  412.191251] pci 0000:01:00.0: restore
[  412.191265] pnp 00:00: legacy restore
[  412.191267] pnp 00:01: legacy restore
[  412.191268] serial 00:02: legacy restore
[  412.191990] serial 00:02: activated
[  412.192045] pnp 00:03: legacy restore
[  412.192047] system 00:04: legacy restore
[  412.192049] pnp 00:05: legacy restore
[  412.192051] rtc_cmos 00:06: legacy restore
[  412.192054] pnp 00:07: legacy restore
[  412.192055] pnp 00:08: legacy restore
[  412.192057] i8042 aux 00:09: legacy restore
[  412.192059] i8042 kbd 00:0a: legacy restore
[  412.192063] pcspkr pcspkr: restore
[  412.192066] platform vesafb.0: restore
[  412.192081] serial8250 serial8250: restore
[  412.192098] sd 1:0:0:0: legacy restore
[  412.192100] sd 1:0:0:0: [sda] Starting disk
[  412.481271] ata5: SATA link down (SStatus 0 SControl 310)
[  412.481333] ata4: SATA link down (SStatus 0 SControl 310)
[  412.492017] ata1: SATA link down (SStatus 0 SControl 300)
[  412.648032] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  412.664431] ata2.00: configured for UDMA/133
[  412.675026] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  412.675087] sd 1:0:0:0: [sda] Write Protect is off
[  412.675136] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  412.675152] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  412.675220] usb usb1: type restore
[  412.740021] usb usb2: type restore
[  412.740024] usb usb3: type restore
[  412.780010] usb usb4: type restore
[  412.780012] usb usb5: type restore
[  412.780014] usb 3-2: type restore
[  412.780018] i8042 i8042: restore
[  412.780043] atkbd serio0: legacy restore
[  412.780046] psmouse serio1: legacy restore
[  412.780050] ac97 0-0:ALC655: legacy restore
[  412.780054] platform floppy.0: restore
[  412.780059] rtc rtc0: legacy class restore
[  412.780092] platform floppy.0: completing restore
[  412.780097] i8042 i8042: completing restore
[  412.780099] usb 3-2: completing type restore
[  412.780101] usb usb5: completing type restore
[  412.780103] usb usb4: completing type restore
[  412.780106] usb usb3: completing type restore
[  412.780108] usb usb2: completing type restore
[  412.780110] usb usb1: completing type restore
[  412.780122] serial8250 serial8250: completing restore
[  412.780132] platform vesafb.0: completing restore
[  412.780134] pcspkr pcspkr: completing restore
[  412.780138] pci 0000:01:00.0: completing restore
[  412.780140] k8temp 0000:00:18.3: completing restore
[  412.780142] pci 0000:00:18.2: completing restore
[  412.780144] pci 0000:00:18.1: completing restore
[  412.780146] pci 0000:00:18.0: completing restore
[  412.780147] VIA 82xx Audio 0000:00:11.5: completing restore
[  412.780149] pci 0000:00:11.0: completing restore
[  412.780151] ehci_hcd 0000:00:10.4: completing restore
[  412.780153] uhci_hcd 0000:00:10.3: completing restore
[  412.780155] uhci_hcd 0000:00:10.2: completing restore
[  412.780157] uhci_hcd 0000:00:10.1: completing restore
[  412.780158] uhci_hcd 0000:00:10.0: completing restore
[  412.780160] VIA_IDE 0000:00:0f.1: completing restore
[  412.780162] sata_via 0000:00:0f.0: completing restore
[  412.780164] pci 0000:00:0e.0: completing restore
[  412.780166] sata_promise 0000:00:0d.0: completing restore
[  412.780168] r8169 0000:00:0b.0: completing restore
[  412.780170] sata_via 0000:00:08.0: completing restore
[  412.780171] pci 0000:00:01.0: completing restore
[  412.780173] agpgart-amd64 0000:00:00.0: completing restore
[  412.780183] PM: Image restored successfully.
[  412.799552] Restarting tasks ... done.
[  412.812197] PM: Basic memory bitmaps freed
[  412.860205] atkbd.c: Failed to enable keyboard on isa0060/serio0

--------------040702020309020103040108--
