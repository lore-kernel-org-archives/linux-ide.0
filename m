From: Lloyd Carothers <lloyd@passcal.nmt.edu>
Subject: buffer I/O error, trying to use SimpleTech compact flash via pcmcia
Date: Mon, 21 Jun 2004 18:05:02 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1087862702.2920.6.camel@firestorm.passcal.nmt.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from passcal.passcal.nmt.edu ([129.138.26.245]:34511 "EHLO
	passcal.passcal.nmt.edu") by vger.kernel.org with ESMTP
	id S266531AbUFVAFD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Jun 2004 20:05:03 -0400
Received: from firestorm.passcal.nmt.edu (firestorm.passcal.nmt.edu [129.138.26.246])
	by passcal.passcal.nmt.edu (8.12.10/8.12.10) with ESMTP id i5M052Zl009783
	for <linux-ide@vger.kernel.org>; Mon, 21 Jun 2004 18:05:02 -0600 (MDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi,

I posted this to linux-pcmcia and King pointed me here.

The following info was generated on an IBM A31 laptop with kernel
2.6.5-1.358 trying to use a SimpleTech 1GB Compact Flash ATA card with a
pcmcia adapter

I get very similar results with 2.4 kernels and the 2.6.7 kernels and on
other laptops including IBM T41.

The only time I have be able to use this card is with the 2.4.20 kernel
and the pcmcia-cs package utilities, not drivers installed.

Also, I am able to use similar cards with out problems including IBM's
microdrives, SanDisks compact flash 1 and 1GB cards, and Kingston
technology 32MB cards.

I would be willing to ship off a couple of these cards to the
maintainers if 
they request so.

Below are label outputs from dmesg ,cardctl , lspci -v and  what
/var/log/messages gets on insert and ejection of the card.

thanks
--Lloyd

cardctl status:
===========================================
Socket 0:
  3.3V 16-bit PC Card
  function 0: [ready], [bat dead], [bat low]
Socket 1:
  no card

dmesg:
=============================================
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
cdrom: open failed.
Adding 2519488k swap on /dev/hda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
SCSI subsystem initialized
inserting floppy driver for 2.6.5-1.358
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
divert: allocating divert_blk for eth0
e100: eth0: e100_probe: addr 0xd0200000, irq 11, MAC addr
00:02:8A:35:85:5B
divert: freeing divert_blk for eth0
ip_tables: (C) 2000-2002 Netfilter core team
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
divert: allocating divert_blk for eth0
e100: eth0: e100_probe: addr 0xd0200000, irq 11, MAC addr
00:02:8A:35:85:5B
ip_tables: (C) 2000-2002 Netfilter core team
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0185]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0185]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 78379 usecs
intel8x0: clocking to 48000
cs: memory probe 0xa0000000-0xa0ffffff: clean.
hde: STI Flash S.1.0, CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 3
hde: max request size: 128KiB
hde: 2002896 sectors (1025 MB) w/1KiB Cache, CHS=1987/16/63
 hde:hde: status error: status=0x20 { DeviceFault }

On insert:
==============================================
Jun 21 13:08:35 localhost cardmgr[1948]: socket 0: ATA/IDE Fixed Disk
Jun 21 13:08:36 localhost kernel: hde: STI Flash S.1.0, CFA DISK drive
Jun 21 13:08:36 localhost kernel: ide2 at 0x100-0x107,0x10e on irq 3
Jun 21 13:08:36 localhost kernel: hde: max request size: 128KiB
Jun 21 13:08:36 localhost kernel: hde: 2002896 sectors (1025 MB) w/1KiB
Cache, CHS=1987/16/63
Jun 21 13:08:36 localhost kernel:  hde:hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:36 localhost kernel: 
Jun 21 13:08:36 localhost kernel: hde: drive not ready for command
Jun 21 13:08:36 localhost udev[3304]: creating device node '/udev/hde'
Jun 21 13:08:36 localhost kernel: ide2: reset: success
Jun 21 13:08:36 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:36 localhost kernel: 
Jun 21 13:08:36 localhost kernel: hde: drive not ready for command
Jun 21 13:08:36 localhost kernel: ide2: reset: success
Jun 21 13:08:36 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: end_request: I/O error, dev hde,
sector 0
Jun 21 13:08:37 localhost kernel: Buffer I/O error on device hde,
logical block 0
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: ide2: reset: success
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: ide2: reset: success
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: end_request: I/O error, dev hde,
sector 0
Jun 21 13:08:37 localhost kernel: Buffer I/O error on device hde,
logical block 0
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: ide2: reset: success
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: ide2: reset: success
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: end_request: I/O error, dev hde,
sector 2002888
Jun 21 13:08:37 localhost kernel: Buffer I/O error on device hde,
logical block 250361
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: ide2: reset: success
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: ide2: reset: success
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: end_request: I/O error, dev hde,
sector 2002888
Jun 21 13:08:37 localhost kernel: Buffer I/O error on device hde,
logical block 250361
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: ide2: reset: success
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: ide2: reset: success
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: end_request: I/O error, dev hde,
sector 0
Jun 21 13:08:37 localhost kernel: Buffer I/O error on device hde,
logical block 0
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel:  unable to read partition table
Jun 21 13:08:37 localhost kernel: ide-cs: hde: Vcc = 3.3, Vpp = 0.0
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:37 localhost kernel: hde: drive not ready for command
Jun 21 13:08:37 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 13:08:37 localhost kernel: 
Jun 21 13:08:38 localhost kernel: hde: drive not ready for command

On eject
=================================================
Jun 21 14:00:19 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 14:00:19 localhost kernel: 
Jun 21 14:00:19 localhost kernel: hde: drive not ready for command
Jun 21 14:00:19 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 14:00:19 localhost kernel: 
Jun 21 14:00:19 localhost kernel: hde: drive not ready for command
Jun 21 14:00:19 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 14:00:19 localhost kernel: 
Jun 21 14:00:19 localhost kernel: hde: drive not ready for command
Jun 21 14:00:19 localhost kernel: hde: status error: status=0x20 {
DeviceFault }
Jun 21 14:00:19 localhost kernel: 
Jun 21 14:00:19 localhost kernel: hde: drive not ready for command
Jun 21 14:00:22 localhost udev[4445]: removing device node '/udev/hde'



lspci -v output
================================================

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge (rev 04)
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable)
	Capabilities: [e4] #09 [d104]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
(rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: e8000000-efffffff
	Expansion ROM at 00003000 [disabled] [size=4K]

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
(prog-if 00 [UHCI])
	Subsystem: IBM ThinkPad A/T/X Series
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
(prog-if 00 [UHCI])
	Subsystem: IBM ThinkPad A/T/X Series
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
(prog-if 00 [UHCI])
	Subsystem: IBM ThinkPad A/T/X Series
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1840 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: d0200000-dfffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if
8a [Master SecP PriP])
	Subsystem: IBM ThinkPad A/T/X Series
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at 1860 [size=16]
	Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
	Subsystem: IBM ThinkPad A/T/X Series
	Flags: medium devsel, IRQ 11
	I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
Controller (rev 02)
	Subsystem: IBM ThinkPad T30
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1c00
	I/O ports at 18c0 [size=64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
(prog-if 00 [Generic])
	Subsystem: IBM ThinkPad A/T/X Series
	Flags: medium devsel, IRQ 11
	I/O ports at 2400
	I/O ports at 2000 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0509
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel,
latency 66, IRQ 11
	Memory at e8000000 (32-bit, prefetchable)
	I/O ports at 3000 [size=256]
	Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

02:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: IBM ThinkPad A/T/X Series
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 50000000 (32-bit, non-prefetchable)
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: IBM ThinkPad A/T/X Series
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 50100000 (32-bit, non-prefetchable)
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE
(LOM) Ethernet Controller (rev 42)
	Subsystem: IBM ThinkPad A/T/X Series
	Flags: bus master, medium devsel, latency 66, IRQ 11
	Memory at d0200000 (32-bit, non-prefetchable)
	I/O ports at 8000 [size=64]
	Capabilities: [dc] Power Management version 2



