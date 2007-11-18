From: Tobias Oed <tobiasoed@hotmail.com>
Subject: Lost interrupt with cmd 64x
Date: Sun, 18 Nov 2007 08:01:03 -0500
Message-ID: <BAY139-W374C1413B6CEBCB202A330A37D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay0-omc3-s32.bay0.hotmail.com ([65.54.246.232]:61593 "EHLO
	bay0-omc3-s32.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751760AbXKRNBE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Nov 2007 08:01:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hello,
I have an LSI 511 rev 2 pci card, that has 2 silicon image 0649CL160 ch=
ips on it and an intel 80960rs100. When the bios of the card is enabled=
 it is detected by the megaraid_mbox driver. Since I don't want the rai=
d function, I disable the bios with a jumper on the card. Then I see th=
is in lspci -vv
02:00.0 RAID bus controller: Silicon Image, Inc. SiI 0649 Ultra ATA/100=
 PCI to ATA Host Controller (rev 02)
        Subsystem: Unknown device 7fb5:ffed
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbor=
t- SERR- TAbort- SERR- 23 and a mixture of kernel parameters. Since I'm=
 doing this more or less randomly, I'm not getting anywhere, what can I=
 do to get this card to work?
Thanks,
Tobias
ps: typical dmesg:

Oct 31 22:01:18 smallbox kernel: klogd 1.4.2, log source =3D /proc/kmsg=
 started.
Oct 31 22:01:18 smallbox kernel: Linux version 2.6.21.5 (tobias@tobslap=
) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-27)) #13 Wed Oct 31 21:44:=
42 CET 2007
Oct 31 22:01:18 smallbox kernel: BIOS-provided physical RAM map:
Oct 31 22:01:18 smallbox kernel: sanitize start
Oct 31 22:01:18 smallbox kernel: sanitize end
Oct 31 22:01:18 smallbox kernel: copy_e820_map() start: 000000000000000=
0 size: 000000000009fc00 end: 000000000009fc00 type: 1
Oct 31 22:01:18 smallbox kernel: copy_e820_map() type is E820_RAM
Oct 31 22:01:18 smallbox kernel: copy_e820_map() start: 000000000009fc0=
0 size: 0000000000000400 end: 00000000000a0000 type: 2
Oct 31 22:01:18 smallbox kernel: copy_e820_map() start: 00000000000f000=
0 size: 0000000000010000 end: 0000000000100000 type: 2
Oct 31 22:01:18 smallbox kernel: copy_e820_map() start: 000000000010000=
0 size: 0000000005efc000 end: 0000000005ffc000 type: 1
Oct 31 22:01:18 smallbox kernel: copy_e820_map() type is E820_RAM
Oct 31 22:01:18 smallbox kernel: copy_e820_map() start: 0000000005ffc00=
0 size: 0000000000003000 end: 0000000005fff000 type: 3
Oct 31 22:01:18 smallbox kernel: copy_e820_map() start: 0000000005fff00=
0 size: 0000000000001000 end: 0000000006000000 type: 4
Oct 31 22:01:18 smallbox kernel: copy_e820_map() start: 00000000ffff000=
0 size: 0000000000010000 end: 0000000100000000 type: 2
Oct 31 22:01:18 smallbox kernel:  BIOS-e820: 0000000000000000 - 0000000=
00009fc00 (usable)
Oct 31 22:01:18 smallbox kernel:  BIOS-e820: 000000000009fc00 - 0000000=
0000a0000 (reserved)
Oct 31 22:01:18 smallbox kernel:  BIOS-e820: 00000000000f0000 - 0000000=
000100000 (reserved)
Oct 31 22:01:18 smallbox kernel:  BIOS-e820: 0000000000100000 - 0000000=
005ffc000 (usable)
Oct 31 22:01:18 smallbox kernel:  BIOS-e820: 0000000005ffc000 - 0000000=
005fff000 (ACPI data)
Oct 31 22:01:18 smallbox kernel:  BIOS-e820: 0000000005fff000 - 0000000=
006000000 (ACPI NVS)
Oct 31 22:01:18 smallbox kernel:  BIOS-e820: 00000000ffff0000 - 0000000=
100000000 (reserved)
Oct 31 22:01:18 smallbox kernel: 95MB LOWMEM available.
Oct 31 22:01:18 smallbox kernel: Zone PFN ranges:
Oct 31 22:01:18 smallbox kernel:   DMA             0 ->     4096
Oct 31 22:01:18 smallbox kernel:   Normal       4096 ->    24572
Oct 31 22:01:18 smallbox kernel: early_node_map[1] active PFN ranges
Oct 31 22:01:18 smallbox kernel:     0:        0 ->    24572
Oct 31 22:01:18 smallbox kernel: DMI 2.0 present.
Oct 31 22:01:18 smallbox kernel: ACPI: RSDP 000F81A0, 0014 (r0 ASUS  )
Oct 31 22:01:18 smallbox kernel: ACPI: RSDT 05FFC000, 002C (r1 ASUS   P=
5A      58582E31 ASUS 31303030)
Oct 31 22:01:18 smallbox kernel: ACPI: FACP 05FFC080, 0074 (r1 ASUS   P=
5A      58582E31 ASUS 31303030)
Oct 31 22:01:18 smallbox kernel: ACPI: DSDT 05FFC100, 23F6 (r1   ASUS P=
5A          1000 MSFT  1000001)
Oct 31 22:01:18 smallbox kernel: ACPI: FACS 05FFF000, 0040
Oct 31 22:01:18 smallbox kernel: ACPI: BOOT 05FFC040, 0028 (r1 ASUS   P=
5A      58582E31 ASUS 31303030)
Oct 31 22:01:18 smallbox kernel: ACPI: PM-Timer IO Port: 0xec08
Oct 31 22:01:18 smallbox kernel: Allocating PCI resources starting at 1=
0000000 (gap: 06000000:f9ff0000)
Oct 31 22:01:18 smallbox kernel: Built 1 zonelists.  Total pages: 24381
Oct 31 22:01:18 smallbox kernel: Kernel command line: ro root=3DLABEL=3D=
/=20
Oct 31 22:01:18 smallbox kernel: Initializing CPU#0
Oct 31 22:01:18 smallbox kernel: PID hash table entries: 512 (order: 9,=
 2048 bytes)
Oct 31 22:01:18 smallbox kernel: Detected 451.078 MHz processor.
Oct 31 22:01:18 smallbox kernel: Console: colour VGA+ 80x25
Oct 31 22:01:18 smallbox kernel: Dentry cache hash table entries: 16384=
 (order: 4, 65536 bytes)
Oct 31 22:01:18 smallbox kernel: Inode-cache hash table entries: 8192 (=
order: 3, 32768 bytes)
Oct 31 22:01:18 smallbox kernel: Memory: 91576k/98288k available (1725k=
 kernel code, 6256k reserved, 555k data, 172k init, 0k highmem)
Oct 31 22:01:18 smallbox kernel: virtual kernel memory layout:
Oct 31 22:01:18 smallbox kernel:     fixmap  : 0xffff8000 - 0xfffff000 =
  (  28 kB)
Oct 31 22:01:18 smallbox kernel:     vmalloc : 0xc6800000 - 0xffff6000 =
  ( 919 MB)
Oct 31 22:01:18 smallbox kernel:     lowmem  : 0xc0000000 - 0xc5ffc000 =
  (  95 MB)
Oct 31 22:01:18 smallbox kernel:       .init : 0xc123e000 - 0xc1269000 =
  ( 172 kB)
Oct 31 22:01:18 smallbox kernel:       .data : 0xc11af48e - 0xc123a3b4 =
  ( 555 kB)
Oct 31 22:01:18 smallbox kernel:       .text : 0xc1000000 - 0xc11af48e =
  (1725 kB)
Oct 31 22:01:18 smallbox kernel: Checking if this processor honours the=
 WP bit even in supervisor mode... Ok.
Oct 31 22:01:18 smallbox kernel: Calibrating delay using timer specific=
 routine.. 902.76 BogoMIPS (lpj=3D1805535)
Oct 31 22:01:18 smallbox kernel: Mount-cache hash table entries: 512
Oct 31 22:01:18 smallbox kernel: CPU: L1 I Cache: 32K (32 bytes/line), =
D cache 32K (32 bytes/line)
Oct 31 22:01:18 smallbox kernel: CPU: AMD-K6(tm) 3D processor stepping =
0c
Oct 31 22:01:18 smallbox kernel: Checking 'hlt' instruction... OK.
Oct 31 22:01:18 smallbox kernel: ACPI: Core revision 20070126
Oct 31 22:01:18 smallbox kernel: ACPI: setting ELCR to 0200 (from 0e20)
Oct 31 22:01:18 smallbox kernel: NET: Registered protocol family 16
Oct 31 22:01:18 smallbox kernel: ACPI: bus type pci registered
Oct 31 22:01:18 smallbox kernel: PCI: PCI BIOS revision 2.10 entry at 0=
xf06c0, last bus=3D2
Oct 31 22:01:18 smallbox kernel: PCI: Using configuration type 1
Oct 31 22:01:18 smallbox kernel: Setting up standard PCI resources
Oct 31 22:01:18 smallbox kernel: ACPI: Interpreter enabled
Oct 31 22:01:18 smallbox kernel: ACPI: (supports S0 S1 S5)
Oct 31 22:01:18 smallbox kernel: ACPI: Using PIC for interrupt routing
Oct 31 22:01:18 smallbox kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Oct 31 22:01:18 smallbox kernel: PCI quirk: region 5c20-5c3f claimed by=
 ali7101 SMB
Oct 31 22:01:18 smallbox kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs =
3 4 5 6 7 9 10 *11 12 14 15)
Oct 31 22:01:18 smallbox kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs =
3 4 5 6 7 9 *10 11 12 14 15)
Oct 31 22:01:18 smallbox kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs =
1 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
Oct 31 22:01:18 smallbox kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs =
1 3 4 *5 6 7 9 10 11 12 14 15)
Oct 31 22:01:18 smallbox kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs =
1 3 4 5 6 7 *9 10 11 12 14 15)
Oct 31 22:01:18 smallbox kernel: Linux Plug and Play Support v0.97 (c) =
Adam Belay
Oct 31 22:01:18 smallbox kernel: pnp: PnP ACPI init
Oct 31 22:01:18 smallbox kernel: pnp: PnP ACPI: found 13 devices
Oct 31 22:01:19 smallbox kernel: usbcore: registered new interface driv=
er usbfs
Oct 31 22:01:19 smallbox kernel: usbcore: registered new interface driv=
er hub
Oct 31 22:01:19 smallbox kernel: usbcore: registered new device driver =
usb
Oct 31 22:01:19 smallbox kernel: PCI: Using ACPI for IRQ routing
Oct 31 22:01:19 smallbox kernel: PCI: If a device doesn't work, try "pc=
i=3Drouteirq".  If it helps, post a report
Oct 31 22:01:19 smallbox kernel: pnp: 00:00: iomem range 0x0-0x9ffff co=
uld not be reserved
Oct 31 22:01:19 smallbox kernel: pnp: 00:00: iomem range 0xf0000-0xffff=
f could not be reserved
Oct 31 22:01:19 smallbox kernel: pnp: 00:00: iomem range 0x100000-0x5ff=
ffff could not be reserved
Oct 31 22:01:19 smallbox kernel: pnp: 00:00: iomem range 0xfffe0000-0xf=
fffffff could not be reserved
Oct 31 22:01:19 smallbox kernel: Time: tsc clocksource has been install=
ed.
Oct 31 22:01:19 smallbox kernel: pnp: 00:02: ioport range 0xec00-0xec3f=
 has been reserved
Oct 31 22:01:19 smallbox kernel: pnp: 00:02: ioport range 0xe800-0xe81f=
 has been reserved
Oct 31 22:01:19 smallbox kernel: pnp: 00:02: ioport range 0x40b-0x40b h=
as been reserved
Oct 31 22:01:19 smallbox kernel: pnp: 00:02: ioport range 0x480-0x49f h=
as been reserved
Oct 31 22:01:19 smallbox kernel: pnp: 00:02: ioport range 0x4d6-0x4d6 h=
as been reserved
Oct 31 22:01:19 smallbox kernel: pnp: 00:02: ioport range 0x290-0x297 h=
as been reserved
Oct 31 22:01:19 smallbox kernel: PM-Timer running at invalid rate: 200%=
 of normal - aborting.
Oct 31 22:01:19 smallbox kernel: PCI: Bridge: 0000:00:01.0
Oct 31 22:01:19 smallbox kernel:   IO window: disabled.
Oct 31 22:01:19 smallbox kernel:   MEM window: e1000000-e1ffffff
Oct 31 22:01:19 smallbox kernel:   PREFETCH window: e5f00000-e7ffffff
Oct 31 22:01:19 smallbox kernel: PCI: Bridge: 0000:00:0d.0
Oct 31 22:01:19 smallbox kernel:   IO window: 9000-cfff
Oct 31 22:01:19 smallbox kernel:   MEM window: disabled.
Oct 31 22:01:19 smallbox kernel:   PREFETCH window: disabled.
Oct 31 22:01:19 smallbox kernel: NET: Registered protocol family 2
Oct 31 22:01:19 smallbox kernel: IP route cache hash table entries: 102=
4 (order: 0, 4096 bytes)
Oct 31 22:01:19 smallbox kernel: TCP established hash table entries: 40=
96 (order: 3, 32768 bytes)
Oct 31 22:01:19 smallbox kernel: TCP bind hash table entries: 4096 (ord=
er: 2, 16384 bytes)
Oct 31 22:01:19 smallbox kernel: TCP: Hash tables configured (establish=
ed 4096 bind 4096)
Oct 31 22:01:19 smallbox kernel: TCP reno registered
Oct 31 22:01:19 smallbox kernel: checking if image is initramfs... it i=
s
Oct 31 22:01:19 smallbox kernel: Freeing initrd memory: 2696k freed
Oct 31 22:01:19 smallbox kernel: Simple Boot Flag at 0x46 set to 0x1
Oct 31 22:01:19 smallbox kernel: io scheduler noop registered
Oct 31 22:01:19 smallbox kernel: io scheduler cfq registered (default)
Oct 31 22:01:19 smallbox kernel: Activating ISA DMA hang workarounds.
Oct 31 22:01:19 smallbox kernel: input: Power Button (FF) as /class/inp=
ut/input0
Oct 31 22:01:19 smallbox kernel: ACPI: Power Button (FF) [PWRF]
Oct 31 22:01:19 smallbox kernel: ACPI: CPU0 (power states: C1[C1] C2[C2=
] C3[C3])
Oct 31 22:01:19 smallbox kernel: Real Time Clock Driver v1.12ac
Oct 31 22:01:19 smallbox kernel: Linux agpgart interface v0.102 (c) Dav=
e Jones
Oct 31 22:01:19 smallbox kernel: agpgart: Detected ALi M1541 chipset
Oct 31 22:01:19 smallbox kernel: agpgart: AGP aperture is 32M @ 0xe2000=
000
Oct 31 22:01:19 smallbox kernel: Serial: 8250/16550 driver $Revision: 1=
=2E90 $ 4 ports, IRQ sharing enabled
Oct 31 22:01:19 smallbox kernel: Time: pit clocksource has been install=
ed.
Oct 31 22:01:19 smallbox kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =3D=
 4) is a 16550A
Oct 31 22:01:19 smallbox kernel: serial8250: ttyS1 at I/O 0x2f8 (irq =3D=
 3) is a 16550A
Oct 31 22:01:19 smallbox kernel: 00:09: ttyS0 at I/O 0x3f8 (irq =3D 4) =
is a 16550A
Oct 31 22:01:19 smallbox kernel: 00:0a: ttyS1 at I/O 0x2f8 (irq =3D 3) =
is a 16550A
Oct 31 22:01:19 smallbox kernel: RAMDISK driver initialized: 16 RAM dis=
ks of 16384K size 4096 blocksize
Oct 31 22:01:19 smallbox kernel: 8139too Fast Ethernet driver 0.9.28
Oct 31 22:01:19 smallbox kernel: ACPI: PCI Interrupt Link [LNKB] enable=
d at IRQ 10
Oct 31 22:01:19 smallbox kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] ->=
 Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Oct 31 22:01:19 smallbox kernel: eth0: RealTek RTL8139 at 0xc680e000, 0=
0:02:e3:0f:8f:8e, IRQ 10
Oct 31 22:01:19 smallbox kernel: Uniform Multi-Platform E-IDE driver Re=
vision: 7.00alpha2
Oct 31 22:01:19 smallbox kernel: ide: Assuming 33MHz system bus speed f=
or PIO modes; override with idebus=3Dxx
Oct 31 22:01:19 smallbox kernel: ALI15X3: IDE controller at PCI slot 00=
00:00:0f.0
Oct 31 22:01:19 smallbox kernel: ACPI: Unable to derive IRQ for device =
0000:00:0f.0
Oct 31 22:01:19 smallbox kernel: ACPI: PCI Interrupt 0000:00:0f.0[A]: n=
o GSI
Oct 31 22:01:19 smallbox kernel: ALI15X3: chipset revision 193
Oct 31 22:01:19 smallbox kernel: ALI15X3: not 100% native mode: will pr=
obe irqs later
Oct 31 22:01:19 smallbox kernel:     ide0: BM-DMA at 0x8800-0x8807, BIO=
S settings: hda:DMA, hdb:pio
Oct 31 22:01:19 smallbox kernel:     ide1: BM-DMA at 0x8808-0x880f, BIO=
S settings: hdc:pio, hdd:pio
Oct 31 22:01:19 smallbox kernel: hda: Maxtor 91080D5, ATA DISK drive
Oct 31 22:01:19 smallbox kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 31 22:01:19 smallbox kernel: hda: max request size: 128KiB
Oct 31 22:01:19 smallbox kernel: hda: 21095424 sectors (10800 MB) w/512=
KiB Cache, CHS=3D20928/16/63, UDMA(33)
Oct 31 22:01:19 smallbox kernel: hda: cache flushes not supported
Oct 31 22:01:19 smallbox kernel:  hda: hda1 hda2 hda3
Oct 31 22:01:19 smallbox kernel: usbcore: registered new interface driv=
er libusual
Oct 31 22:01:19 smallbox kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP=
0f13:PS2M] at 0x60,0x64 irq 1,12
Oct 31 22:01:19 smallbox kernel: serio: i8042 KBD port at 0x60,0x64 irq=
 1
Oct 31 22:01:19 smallbox kernel: serio: i8042 AUX port at 0x60,0x64 irq=
 12
Oct 31 22:01:19 smallbox kernel: mice: PS/2 mouse device common for all=
 mice
Oct 31 22:01:19 smallbox kernel: input: AT Translated Set 2 keyboard as=
 /class/input/input1
Oct 31 22:01:19 smallbox kernel: TCP bic registered
Oct 31 22:01:19 smallbox kernel: Initializing XFRM netlink socket
Oct 31 22:01:19 smallbox kernel: NET: Registered protocol family 1
Oct 31 22:01:19 smallbox kernel: NET: Registered protocol family 17
Oct 31 22:01:19 smallbox kernel: Using IPI Shortcut mode
Oct 31 22:01:19 smallbox kernel: Freeing unused kernel memory: 172k fre=
ed
Oct 31 22:01:19 smallbox kernel: logips2pp: Detected unknown logitech m=
ouse model 1
Oct 31 22:01:19 smallbox kernel: ACPI: PCI Interrupt Link [LNKE] enable=
d at IRQ 9
Oct 31 22:01:19 smallbox kernel: ACPI: PCI Interrupt 0000:00:02.0[A] ->=
 Link [LNKE] -> GSI 9 (level, low) -> IRQ 9
Oct 31 22:01:19 smallbox kernel: ohci_hcd 0000:00:02.0: OHCI Host Contr=
oller
Oct 31 22:01:19 smallbox kernel: ohci_hcd 0000:00:02.0: new USB bus reg=
istered, assigned bus number 1
Oct 31 22:01:19 smallbox kernel: ohci_hcd 0000:00:02.0: irq 9, io mem 0=
xe0800000
Oct 31 22:01:19 smallbox kernel: usb usb1: configuration #1 chosen from=
 1 choice
Oct 31 22:01:19 smallbox kernel: hub 1-0:1.0: USB hub found
Oct 31 22:01:19 smallbox kernel: hub 1-0:1.0: 2 ports detected
Oct 31 22:01:19 smallbox kernel: input: PS/2 Logitech Mouse as /class/i=
nput/input2
Oct 31 22:01:19 smallbox kernel: kjournald starting.  Commit interval 5=
 seconds
Oct 31 22:01:19 smallbox kernel: EXT3-fs: mounted filesystem with order=
ed data mode.
Oct 31 22:01:19 smallbox kernel: ali1535_smbus 0000:00:03.0: SMB device=
 not enabled - upgrade BIOS?
Oct 31 22:01:19 smallbox kernel: ali1535_smbus 0000:00:03.0: ALI1535 no=
t detected, module not inserted.
Oct 31 22:01:19 smallbox kernel: ath_hal: module license 'Proprietary' =
taints kernel.
Oct 31 22:01:19 smallbox kernel: ath_hal: 0.9.18.0 (AR5210, AR5211, AR5=
212, RF5111, RF5112, RF2413, RF5413)
Oct 31 22:01:19 smallbox kernel: CMD649: IDE controller at PCI slot 000=
0:02:00.0
Oct 31 22:01:19 smallbox kernel: ACPI: PCI Interrupt Link [LNKD] enable=
d at IRQ 5
Oct 31 22:01:19 smallbox kernel: ACPI: PCI Interrupt 0000:02:00.0[A] ->=
 Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
Oct 31 22:01:19 smallbox kernel: CMD649: chipset revision 2
Oct 31 22:01:19 smallbox kernel: CMD649: 100% native mode on irq 5
Oct 31 22:01:19 smallbox kernel:     ide2: BM-DMA at 0xb400-0xb407, BIO=
S settings: hde:pio, hdf:pio
Oct 31 22:01:19 smallbox kernel:     ide3: BM-DMA at 0xb408-0xb40f, BIO=
S settings: hdg:pio, hdh:pio
Oct 31 22:01:19 smallbox kernel: wlan: 0.8.4.2 (0.9.3.3)
Oct 31 22:01:19 smallbox kernel: parport: PnPBIOS parport detected.
Oct 31 22:01:19 smallbox kernel: parport0: PC-style at 0x378 (0x778), i=
rq 7 [PCSPP,TRISTATE]
Oct 31 22:01:19 smallbox kernel: hde: FUJITSU MPE3064AT, ATA DISK drive
Oct 31 22:01:19 smallbox kernel: ide2 at 0xc800-0xc807,0xc402 on irq 5
Oct 31 22:01:19 smallbox kernel: hde: max request size: 128KiB
Oct 31 22:01:19 smallbox kernel: hde: 12672450 sectors (6488 MB) w/512K=
iB Cache, CHS=3D13410/15/63, UDMA(33)
Oct 31 22:01:19 smallbox kernel: hde: cache flushes not supported
Oct 31 22:01:19 smallbox kernel:  hde:hde: lost interrupt
Oct 31 22:01:19 smallbox kernel: Floppy drive(s): fd0 is 1.44M
Oct 31 22:01:19 smallbox kernel: FDC 0 is a post-1991 82077
Oct 31 22:01:19 smallbox kernel: device-mapper: ioctl: 4.11.0-ioctl (20=
06-10-12) initialised: dm-devel@redhat.com
Oct 31 22:01:19 smallbox kernel: EXT3 FS on hda1, internal journal
Oct 31 22:01:19 smallbox kernel: kjournald starting.  Commit interval 5=
 seconds
Oct 31 22:01:19 smallbox kernel: EXT3 FS on hda2, internal journal
Oct 31 22:01:19 smallbox kernel: EXT3-fs: mounted filesystem with order=
ed data mode.
Oct 31 22:01:19 smallbox kernel: Adding 313256k swap on /dev/hda3.  Pri=
ority:-1 extents:1 across:313256k
Oct 31 22:01:19 smallbox kernel: ip_tables: (C) 2000-2006 Netfilter Cor=
e Team
Oct 31 22:01:19 smallbox kernel: Netfilter messages via NETLINK v0.30.
Oct 31 22:01:20 smallbox kernel: nf_conntrack version 0.5.0 (767 bucket=
s, 6136 max)
Oct 31 22:01:20 smallbox kernel: ath_pci: 0.9.4.5 (0.9.3.3)
Oct 31 22:01:20 smallbox kernel: hde: lost interrupt
Oct 31 22:01:20 smallbox kernel: hde: dma_timer_expiry: dma status =3D=3D=
 0x24
Oct 31 22:01:20 smallbox kernel: hde: DMA interrupt recovery
Oct 31 22:01:20 smallbox kernel: hde: lost interrupt
Oct 31 22:01:20 smallbox kernel:  hde1
Oct 31 22:01:20 smallbox kernel: CMD649: IDE controller at PCI slot 000=
0:02:01.0
Oct 31 22:01:20 smallbox kernel: ACPI: PCI Interrupt Link [LNKA] enable=
d at IRQ 11
Oct 31 22:01:20 smallbox kernel: ACPI: PCI Interrupt 0000:02:01.0[A] ->=
 Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Oct 31 22:01:20 smallbox kernel: CMD649: chipset revision 2
Oct 31 22:01:20 smallbox kernel: CMD649: 100% native mode on irq 11
Oct 31 22:01:20 smallbox kernel:     ide4: BM-DMA at 0x9800-0x9807, BIO=
S settings: hdi:pio, hdj:pio
Oct 31 22:01:20 smallbox kernel:     ide5: BM-DMA at 0x9808-0x980f, BIO=
S settings: hdk:pio, hdl:pio
Oct 31 22:01:20 smallbox kernel: ACPI: PCI Interrupt 0000:00:09.0[A] ->=
 Link [LNKD] -> GSI 5 (level, low) -> IRQ 5


_________________________________________________________________
You keep typing, we keep giving. Download Messenger and join the i=92m =
Initiative now.
http://im.live.com/messenger/im/home/?source=3DTAGLM