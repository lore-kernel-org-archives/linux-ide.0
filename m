From: "theHog" <lists@t3i.nl>
Subject: sata_mv timeout issue
Date: Tue, 16 Mar 2010 20:43:10 +0100
Message-ID: <E1NrcfW-00024z-1v@daffy.sipo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from daffy.sipo.nl ([109.235.32.73]:60561 "EHLO daffy.sipo.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758005Ab0CPUcE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2010 16:32:04 -0400
Received: from nobody by daffy.sipo.nl with local (Exim 4.63)
	(envelope-from <lists@t3i.nl>)
	id 1NrcfW-00024z-1v
	for linux-ide@vger.kernel.org; Tue, 16 Mar 2010 20:43:10 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

I am building a system based on a Marvell Kirkwood SOC and two sata dis=
ks
(Western Digital 'Caviar Green' WD15EADS). After power on, the system s=
tarts
U-boot. If I interrupt U-boot for a while (>8 seconds) and then boot li=
nux,
then the disks are initialized normally during the kernel initializatio=
n, and
available when the kernel starts init.

But, when linux is started with a shorter delay (e.g. 3 seconds), then =
some
timeout related errors are reported wrt. the sata link:
ata1: SATA link down (SStatus 0 SControl F300)
=2E..
ata1: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
ata1: edma_err_cause=3D00000010 pp_flags=3D00000000, dev connect
ata1: SError: { PHYRdyChg DevExch }
ata1: hard resetting link
ata2: link is slow to respond, please be patient (ready=3D0)

The 2 disks are not initialized properly until after init has started (=
see
also the dmesg output below).

Watching the leds of the disks, it seems that there is a 6 seconds pena=
lty
for performing a (hard?) reset of the sata link. After power-on, it tak=
es 6
seconds until the leds of both disk light up. Then the leds go of and i=
t
takes another 6 seconds until both light up (probably because the link =
was
hard-reset again?).

I tried to play around with some timeout values (ATA_TMOUT_FF_WAIT=3D12=
500) but
that did not work out.

Is there something I can do solve this? May have the driver waiting a f=
ew
seconds longer for the sata link to come up before trying to reset it? =
I'm
not a kernel developer so I hope that you can help me out here.

Richard.

Linux version 2.6.33.1 (emblin@Wodan) (gcc version 4.4.0 (crosstool-NG-=
1.6.0)
) #5 Tue Mar 16 19:41:41 CET 2010
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=3D00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: QNAP TS-119/TS-219
Ignoring unrecognised tag 0x41000403
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c03498ec, node_mem_map c03da000
  Normal zone: 1024 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 130048 pages, LIFO batch:31
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 13=
0048
Kernel command line: mem=3D512M console=3DttyS0,115200 swroot=3Drescue =
swwait=3D0
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512MB =3D 512MB total
Memory: 515584KB available (2828K code, 647K data, 420K init, 0K highme=
m)
SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
Hierarchical RCU implementation.
NR_IRQS:114
Calibrating delay loop... 1199.30 BogoMIPS (lpj=3D5996544)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
Kirkwood: MV88F6281-A0, TCLK=3D200000000.
=46eroceon L2: Enabling L2
=46eroceon L2: Cache support initialised.
initial MPP regs: 11112222 03303311 55551100 00000000 00000000 00000000
00000000
  final MPP regs: 11552222 03303311 55551100 00000000 00000000 00000000
00000000
pci 0000:00:00.0: reg 10: [mem 0xf1000000-0xf10fffff 64bit pref]
pci 0000:00:00.0: reg 18: [mem 0x00000000-0x1fffffff]
pci 0000:00:00.0: supports D1 D2
pci 0000:00:01.0: reg 24: [mem 0x40000000-0x40001fff]
pci 0000:00:01.0: reg 30: [mem 0x00000000-0x0000ffff pref]
pci 0000:00:01.0: PME# supported from D3hot
pci 0000:00:01.0: PME# disabled
pci 0000:00:01.1: reg 10: [io  0xfff8-0xffff]
pci 0000:00:01.1: reg 14: [io  0xfffc-0xffff]
pci 0000:00:01.1: reg 18: [io  0xfff8-0xffff]
pci 0000:00:01.1: reg 1c: [io  0xfffc-0xffff]
pci 0000:00:01.1: reg 20: [io  0xfff0-0xffff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: BAR 6: assigned [mem 0xe0000000-0xe000ffff pref]
pci 0000:00:01.0: BAR 5: assigned [mem 0xe0010000-0xe0011fff]
pci 0000:00:01.0: BAR 5: set to [mem 0xe0010000-0xe0011fff] (PCI addres=
s
[0xe0010000-0xe0011fff]
pci 0000:00:01.1: BAR 4: assigned [io  0x1000-0x100f]
pci 0000:00:01.1: BAR 4: set to [io  0x1000-0x100f] (PCI address
[0x1000-0x100f]
pci 0000:00:01.1: BAR 0: assigned [io  0x1010-0x1017]
pci 0000:00:01.1: BAR 0: set to [io  0x1010-0x1017] (PCI address
[0x1010-0x1017]
pci 0000:00:01.1: BAR 2: assigned [io  0x1018-0x101f]
pci 0000:00:01.1: BAR 2: set to [io  0x1018-0x101f] (PCI address
[0x1018-0x101f]
pci 0000:00:01.1: BAR 1: assigned [io  0x1020-0x1023]
pci 0000:00:01.1: BAR 1: set to [io  0x1020-0x1023] (PCI address
[0x1020-0x1023]
pci 0000:00:01.1: BAR 3: assigned [io  0x1024-0x1027]
pci 0000:00:01.1: BAR 3: set to [io  0x1024-0x1027] (PCI address
[0x1024-0x1027]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource orion_clocksource
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
PCI: CLS 32 bytes, default 32
JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
SGI XFS with security attributes, large block/inode numbers, no debug e=
nabled
msgmni has been set to 1007
io scheduler noop registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xf1012000 (irq =3D 33) is a 16550A
console [ttyS0] enabled
serial8250.1: ttyS1 at MMIO 0xf1012100 (irq =3D 34) is a 16550A
brd: module loaded
sata_mv sata_mv.0: version 1.28
sata_mv sata_mv.0: slots 32 ports 2
scsi0 : sata_mv
scsi1 : sata_mv
ata1: SATA max UDMA/133 irq 21
ata2: SATA max UDMA/133 irq 21
m25p80 spi0.0: m25p128 (16384 Kbytes)
Creating 4 MTD partitions on "spi_flash":
0x000000000000-0x000000080000 : "U-Boot"
0x000000080000-0x0000000c0000 : "Config"
0x0000000c0000-0x0000002c0000 : "Kernel"
0x0000002c0000-0x000001000000 : "Rootfs"
MV-643xx 10/100/1000 ethernet driver version 1.4
mv643xx_eth smi: probed
net eth0: port 0 with MAC address 00:50:43:3c:3b:5d
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
orion-ehci orion-ehci.0: Marvell Orion EHCI
orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
orion-ehci orion-ehci.0: irq 19, io mem 0xf1050000
orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
input: gpio-keys as /devices/platform/gpio-keys/input/input0
i2c /dev entries driver
rtc-s35390a 0-0030: rtc core: registered rtc-s35390a as rtc0
md: raid1 personality registered for level 1
mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP cubic registered
NET: Registered protocol family 17
Gating clock of unused units
before: 0x00c7c1dd
 after: 0x00c7c1cd
rtc-s35390a 0-0030: setting system clock to 2010-03-16 18:42:48 UTC
(1268764968)
ata1: SATA link down (SStatus 0 SControl F300)
usb 1-1: new high speed USB device using orion-ehci and address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
ata1: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
ata1: edma_err_cause=3D00000010 pp_flags=3D00000000, dev connect
ata1: SError: { PHYRdyChg DevExch }
ata1: hard resetting link
ata2: link is slow to respond, please be patient (ready=3D0)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
ata2.00: ATA-8: WDC WD15EADS-00P8B0, 01.00A01, max UDMA/133
ata2.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      WDC WD15EADS-00P 01.0 PQ: 0 AN=
SI: 5
sd 1:0:0:0: [sda] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB=
)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't su=
pport
DPO or FUA
 sda: unknown partition table
sd 1:0:0:0: [sda] Attached SCSI disk
=46reeing init memory: 420K
ata1: link is slow to respond, please be patient (ready=3D0)
ata1: SRST failed (errno=3D-16)
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
ata1.00: ATA-8: WDC WD15EADS-00P8B0, 01.00A01, max UDMA/133
ata1.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      WDC WD15EADS-00P 01.0 PQ: 0 AN=
SI: 5
sd 0:0:0:0: [sdb] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB=
)
sd 0:0:0:0: [sdb] Write Protect is off
sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't su=
pport
DPO or FUA
 sdb: unknown partition table
sd 0:0:0:0: [sdb] Attached SCSI disk

