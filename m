From: n001 <n001@sengena.com>
Subject: [BUG REPORT] cat /proc/ide/hdb/identify = ide bus freeze
Date: Thu, 25 Mar 2004 05:22:19 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40625E7B.7090201@sengena.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000503070104050306000709"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bmvm.sengena.com ([212.13.208.167]:59660 "EHLO bmvm.sengena.com")
	by vger.kernel.org with ESMTP id S263144AbUCYEW2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Mar 2004 23:22:28 -0500
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000503070104050306000709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here is a bug report:

when I do this:

cat /proc/ide/hdb/identify

The command stop here, and the ide bus become freezed.
After about one minute, I have "hdb lost interrupt" (but the IDE bus is 
always unavailable)

It seem that if I unload "ide_cd", "sr_mod" and "cdrom" modules (don't 
tried each separatly, but I can if needed), the command work.


kernel is:
2.6.5-rc2

dmesg after booting attached.

If you need more info or testings, just let me know.

-- 
Nicolas Dimitrijevic - Sengena SARL - http://www.sengena.com
tel: (33)4 91 40 46 50


--------------000503070104050306000709
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

urce
Console: colour VGA+ 80x25
Memory: 1033684k/1048560k available (2288k kernel code, 13976k reserved, 880k data, 172k init, 131056k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3399.68 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 2100+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1724.0486 MHz.
..... host bus clock speed is 265.0305 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040311
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xa9 -> IRQ 18 Mode:1 Active:1)
00:00:09[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb1 -> IRQ 19 Mode:1 Active:1)
00:00:0c[A] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb9 -> IRQ 16 Mode:1 Active:1)
00:00:0c[B] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xc1 -> IRQ 17 Mode:1 Active:1)
00:00:0c[C] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
00:00:0f[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    B9
 11 001 01  1    1    0   1   0    1    1    C1
 12 001 01  1    1    0   1   0    1    1    A9
 13 001 01  1    1    0   1   0    1    1    B1
 14 001 01  1    1    0   1   0    1    1    C9
 15 001 01  1    1    0   1   0    1    1    D1
 16 001 01  1    1    0   1   0    1    1    D9
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=275.00 Mhz, System=275.00 MHz
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon QL  DDR SGRAM 64 MB
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.0, from 9 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 9 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 11 to 5
PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 160x64
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xf0000000
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PCI: Enabling device 0000:00:09.0 (0014 -> 0017)
sk98lin: Network Device Driver v6.23
(C)Copyright 1999-2004 Marvell(R).
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 20
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVVA07-0, ATA DISK drive
hdb: CD-W540E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ST3120026A, ATA DISK drive
hdd: IBM-DTLA-307045, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
hdc: max request size: 1024KiB
hdc: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1 < p5 p6 p7 > p2
hdd: max request size: 128KiB
hdd: 90069840 sectors (46115 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 > p3
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Bridge firewalling registered
ACPI: (supports S0 S1 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc5) for (hdc5)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 172k freed
Adding 497972k swap on /dev/hda6.  Priority:-1 extents:1
input: PC Speaker
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. USB
uhci_hcd 0000:00:10.0: irq 21, io base 00009000
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 00008800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. USB (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 00008400
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. USB (#4)
uhci_hcd 0000:00:10.3: irq 21, io base 00008000
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
usb 1-1: new low speed USB device using address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hdb: ATAPI 48X CD-ROM CD-R/RW CD-MRW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-0000:00:10.0-1
PCI: Setting latency timer of device 0000:00:11.5 to 64
usb 4-2: new low speed USB device using address 2
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
input: USB HID v1.00 Keyboard [NOVATEK Keyboard NT6881] on usb-0000:00:10.3-2
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
input: USB HID v1.00 Mouse [NOVATEK Keyboard NT6881] on usb-0000:00:10.3-2
Linux video capture interface: v1.00
usb 2-2: new full speed USB device using address 2
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
PCI: Enabling device 0000:00:0b.0 (0004 -> 0006)
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
bttv0: Bt848 (rev 18) at 0000:00:0b.0, irq: 19, latency: 32, mmio: 0xe7000000
bttv0: using: IMS/IXmicro TurboTV [card=9,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00fffffe [init]
bttv0: using tuner=3
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tuner: chip found at addr 0xc0 i2c-bus bt848 #0 [sw]
tuner: type set to 3 (Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)) by bt848 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .......<6>usb 2-2.3: new full speed USB device using address 3
...failed
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda5) for (hda5)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda7) for (hda7)
Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
Using r5 hash to sort names
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem f9cbc000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
usb 4-2: USB disconnect, address 2
usb 2-2: USB disconnect, address 2
usb 2-2.3: USB disconnect, address 3
usb 1-1: USB disconnect, address 2
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
usb 2-2: new full speed USB device using address 4
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
hub 2-2:1.0: hub_hub_status failed (err = -71)
hub 2-2:1.0: config failed, can't get hub status (err -71)
usb 4-2: new low speed USB device using address 3
input: USB HID v1.00 Keyboard [NOVATEK Keyboard NT6881] on usb-0000:00:10.3-2
input: USB HID v1.00 Mouse [NOVATEK Keyboard NT6881] on usb-0000:00:10.3-2
usb 1-1: new low speed USB device using address 3
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-0000:00:10.0-1
Disabled Privacy Extensions on device c03da180(lo)
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
eth0: no IPv6 routers present
hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdb: drive_cmd: error=0x04Aborted Command 
SCSI subsystem initialized
[drm] Initialized radeon 1.9.0 20020828 on minor 0
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode

--------------000503070104050306000709--
