From: Ruben Jenster <ruben@hotheads.de>
Subject: DriveReady SeekComplete Error - thinkpad T41p
Date: Tue, 25 Jan 2005 08:29:49 +0100
Message-ID: <200501250829.49755.ruben@hotheads.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tVf9BFJ7d+T8MzA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.176]:36843 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261850AbVAYH36 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jan 2005 02:29:58 -0500
Received: from [212.227.126.206] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CtL9B-00072v-00
	for linux-ide@vger.kernel.org; Tue, 25 Jan 2005 08:29:57 +0100
Received: from [130.83.73.188] (helo=x442.vpn.hrz.tu-darmstadt.de)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CtL9A-0005An-00
	for linux-ide@vger.kernel.org; Tue, 25 Jan 2005 08:29:57 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_tVf9BFJ7d+T8MzA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I get the following error on a thinkpad T41p from kernel 2.6.10 to 2.6.11-rc2.
It doesn't matter whether multimode is enabled or not.


> hda: max request size: 128KiB
> hda: Host Protected Area detected.
>         current capacity is 109170031 sectors (55895 MB)
>         native  capacity is 117210240 sectors (60011 MB)
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> ide: failed opcode was: 0xf9
> hda: 109170031 sectors (55895 MB) w/7877KiB Cache, CHS=65535/16/63, 
UDMA(100)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >


Regards 

Ruben Jenster


Attachment: full messages

--Boundary-00=_tVf9BFJ7d+T8MzA
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg-2.6.10-tp-r11"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-2.6.10-tp-r11"

Linux version 2.6.10-tp-r11 (root@laptop.hotheads.de) (gcc version 3.4.3 20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #2 Mon Jan 24 22:22:11 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff77000 (ACPI data)
 BIOS-e820: 000000001ff77000 - 000000001ff79000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126816 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6df0
ACPI: XSDT (v001 IBM    TP-1R    0x00003130  LTP 0x00000000) @ 0x1ff6a6cd
ACPI: FADT (v003 IBM    TP-1R    0x00003130 IBM  0x00000001) @ 0x1ff6a800
ACPI: SSDT (v001 IBM    TP-1R    0x00003130 MSFT 0x0100000e) @ 0x1ff6a9b4
ACPI: ECDT (v001 IBM    TP-1R    0x00003130 IBM  0x00000001) @ 0x1ff76ebc
ACPI: TCPA (v001 IBM    TP-1R    0x00003130 PTL  0x00000001) @ 0x1ff76f0e
ACPI: BOOT (v001 IBM    TP-1R    0x00003130  LTP 0x00000001) @ 0x1ff76fd8
ACPI: DSDT (v001 IBM    TP-1R    0x00003130 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: root=/dev/hda5 video=mtrr,vesafb:1400x1050 vga=834 acpi_sleep=s3_bios splash=verbose,theme:emergence
fbsplash: verbose
fbsplash: theme emergence
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 598.197 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513716k/523648k available (2108k kernel code, 9348k reserved, 739k data, 1124k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1179.64 BogoMIPS (lpj=589824)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: After vendor identify, caps:  a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        a7e9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1700MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0800)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 279k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050114
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x35 set to 0x1
Initializing Cryptographic API
inotify device minor=63
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 5742k, total 131008k
vesafb: mode is 1400x1050x16, linelength=2800, pages=44
vesafb: protected mode interface info at c000:59fd
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 175x65
fbsplash: console 0 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 0
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (23 C)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
IBM TrackPoint firmware: 0x0E
input: PS/2 IBM TrackPoint on isa0060/serio1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS726060M9AT00, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-RAM UJ-812, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 109170031 sectors (55895 MB)
	native  capacity is 117210240 sectors (60011 MB)
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0xf9
hda: 109170031 sectors (55895 MB) w/7877KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0552]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.0, mfunc 0x01d21b22, devctl 0x64
Yenta: ISA IRQ mask 0x04f8, PCI irq 11
Socket status: 30000086
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0552]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.1, mfunc 0x01d21b22, devctl 0x64
Yenta: ISA IRQ mask 0x04f8, PCI irq 11
Socket status: 30000086
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
 LID SLPB PCI0 UART PCI1 USB0 USB1 AC9M 
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
ibm_acpi: IBM ThinkPad ACPI Extras v0.10
ibm_acpi: http://ibm-acpi.sf.net/
ibm_acpi: dock device not present
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Freeing unused kernel memory: 1124k freed
Adding 498920k swap on /dev/hda6.  Priority:-1 extents:1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
fbsplash: console 1 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 1
fbsplash: console 2 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 2
fbsplash: console 3 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 3
fbsplash: console 4 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 4
fbsplash: console 5 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 5
fbsplash: console 6 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 6
fbsplash: console 7 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 7
fbsplash: console 8 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 8
fbsplash: console 9 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 9
fbsplash: console 10 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 10
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem 0xc0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.12.14 (AR5210, AR5211, AR5212)
wlan: 0.8.4.5 (EXPERIMENTAL)
ath_rate_onoe: 1.0
ath_pci: 0.9.4.12 (EXPERIMENTAL)
intel8x0_measure_ac97_clock: measured 49450 usecs
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: mac 5.6 phy 4.1 5ghz radio 1.7 2ghz radio 2.3
ath0: 802.11 address: 00:05:4e:4d:1b:9d
ath0: Use hw queue 0 for WME_AC_BE traffic
ath0: Use hw queue 1 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Atheros 5212: mem=0xc0210000, irq=11
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
ath_pci: driver unloaded
ath_hal: driver unloaded
ath_rate_onoe: unloaded
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000

--Boundary-00=_tVf9BFJ7d+T8MzA--
