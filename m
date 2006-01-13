From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Fri, 13 Jan 2006 19:10:11 +0100
Message-ID: <200601131910.11382.pvrusb2@toplitzer.net>
References: <200601131909.07981.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_D0+xDauuAEzCK9W"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:32981 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1422781AbWAMSKK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jan 2006 13:10:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by toplitzer.net (SX Mail) with ESMTP id 0841CBC89
	for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2006 19:09:48 +0100 (CET)
Received: from [10.0.0.140] (pc057-adsl.adsl.uni-klu.ac.at [143.205.236.57])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by toplitzer.net (SX Mail) with ESMTP id CC093BC44
	for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2006 19:09:46 +0100 (CET)
In-Reply-To: <200601131909.07981.pvrusb2@toplitzer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_D0+xDauuAEzCK9W
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Here are the logs

-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656

--Boundary-00=_D0+xDauuAEzCK9W
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.6.15 (root@) (gcc-Version 3.3.5 (Debian 1:3.3.5-13)) #1 Fri Jan 6 21:30:24 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000fb930
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 61424 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa980
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x0fff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0fff0030
ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x0fff00c0
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 10000000:eec00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=301 resume=/dev/hda2 1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1754.164 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256468k/262080k available (1583k kernel code, 5060k reserved, 667k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3514.31 BogoMIPS (lpj=7028624)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Athlon(tm) XP 2200+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by vt8235 PM
PCI quirk: region 0400-040f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: dee00000-dfefffff
  PREFETCH window: dad00000-decfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
 0000:00:10.2: uhci_check_and_reset_hc: legsup = 0x2000
 0000:00:10.2: Performing full reset
 0000:00:10.1: uhci_check_and_reset_hc: legsup = 0x2000
 0000:00:10.1: Performing full reset
 0000:00:10.0: uhci_check_and_reset_hc: legsup = 0x2000
 0000:00:10.0: Performing full reset
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports 16 throttling states)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:12.0, from 11 to 0
eth0: VIA Rhine II at 0x1dc00, 00:10:dc:97:81:11, IRQ 16.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 15
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST3200822A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GSA-4081B, ATAPI CD/DVD-ROM drive
hdd: CD-RW CRX100E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 24X CD-ROM CD-R/RW drive, 1024kB Cache, DMA
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_tables: (C) 2000-2002 Netfilter core team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
Freeing unused kernel memory: 136k freed
input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
Adding 1469936k swap on /dev/hda2.  Priority:-1 extents:1 across:1469936k
Generic RTC Driver v1.07
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:11.5, from 5 to 1
PCI: Setting latency timer of device 0000:00:11.5 to 64
Matrox MGA G200/G400/G450/G550 YUV Video interface v2.01 (c) Aaron Holtzman & A'rpi
mga_vid: Found MGA G400/G450 at [0000:01:00.0]
mga_vid: MMIO at 0xd0a00000 IRQ: 11  framebuffer: 0xDC000000
mga_vid: OPTION word: 0x400A1520  mem: 0x05  SDRAM
mga_vid: detected RAMSIZE is 32 MB
syncfb (mga): IRQ disabled in mga_vid.c
mga_vid: 1 supported cards found
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0: LSR safety check engaged!
ttyS0: LSR safety check engaged!
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!

--Boundary-00=_D0+xDauuAEzCK9W
Content-Type: text/plain;
  charset="iso-8859-15";
  name="log1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log1.txt"

shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  116 MB in  3.04 seconds =  38.11 MB/sec
shell$burnK7 &
[1] 2478
shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  164 MB in  3.02 seconds =  54.37 MB/sec
shell$fg
burnK7

shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  108 MB in  3.01 seconds =  35.85 MB/sec

--Boundary-00=_D0+xDauuAEzCK9W
Content-Type: text/plain;
  charset="iso-8859-15";
  name="log2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log2.txt"

shell$lsmod 
Module                  Size  Used by
8250                   16660  0 
serial_core            15104  1 8250
dm_mod                 44600  0 
mga_vid                11232  0 
snd_via82xx            19924  0 
snd_ac97_codec         80032  1 snd_via82xx
snd_ac97_bus            1920  1 snd_ac97_codec
snd_pcm_oss            41952  0 
snd_mixer_oss          14208  1 snd_pcm_oss
snd_pcm                67656  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              18052  1 snd_pcm
snd_page_alloc          8008  2 snd_via82xx,snd_pcm
snd_mpu401_uart         5248  1 snd_via82xx
snd_rawmidi            18016  1 snd_mpu401_uart
snd_seq_device          6668  1 snd_rawmidi
snd                    41636  9 snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               6752  1 snd
floppy                 50820  0 
w83781d                27300  0 
hwmon_vid               2176  1 w83781d
eeprom                  5456  0 
lm80                   14992  0 
i2c_isa                 3456  1 w83781d
i2c_viapro              6996  0 
i2c_core               15504  5 w83781d,eeprom,lm80,i2c_isa,i2c_viapro
genrtc                  7488  0 
shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  114 MB in  3.01 seconds =  37.85 MB/sec
shell$burnK7 &
[1] 1786
shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  174 MB in  3.03 seconds =  57.46 MB/sec
shell$fg
burnK7

shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  108 MB in  3.02 seconds =  35.76 MB/sec
shell$modprobe uhci-hcd
shell$modprobe ehci-hcd
shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  110 MB in  3.03 seconds =  36.33 MB/sec
shell$
shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:   68 MB in  3.04 seconds =  22.40 MB/sec
shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:   68 MB in  3.07 seconds =  22.13 MB/sec
shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:   70 MB in  3.06 seconds =  22.87 MB/sec
shell$burnK7 &
[1] 2426
shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  168 MB in  3.02 seconds =  55.63 MB/sec
shell$fg
burnK7

shell$rmmod ehci-hcd
shell$hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  112 MB in  3.02 seconds =  37.13 MB/sec

--Boundary-00=_D0+xDauuAEzCK9W
Content-Type: text/plain;
  charset="iso-8859-15";
  name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.txt"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: dee00000-dfefffff
	Prefetchable memory behind bridge: dad00000-decfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 4: I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 18
	Region 4: I/O ports at e800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at ec00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 18
	Region 0: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 17
	Region 0: I/O ports at e000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM Dual Head
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dc000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at dfefc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at dfec0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1


--Boundary-00=_D0+xDauuAEzCK9W--
