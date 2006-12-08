From: "Art Haas" <ahaas@airmail.net>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Thu, 7 Dec 2006 19:06:26 -0600
Message-ID: <20061208010626.GA1856@artsapartment.org>
References: <20060924221020.GB2080@artsapartment.org> <4562C65C.2010802@gmail.com> <20061206181652.GA3107@artsapartment.org> <45779852.1030909@gmail.com> <20061207105525.4ebb4547@localhost.localdomain> <45780AF5.2020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wmail-1.airmail.net ([209.196.70.86]:62510 "EHLO
	wmail-1.airmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164303AbWLHBGe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Dec 2006 20:06:34 -0500
Received: from cpe-68-201-223-150.houston.res.rr.com ([68.201.223.150] helo=pcdebian)
	by wmail-1.airmail.net with esmtp (Exim 4.60)
	(envelope-from <ahaas@airmail.net>)
	id 1GsUC8-0006Ig-OA
	for linux-ide@vger.kernel.org; Thu, 07 Dec 2006 19:06:33 -0600
Content-Disposition: inline
In-Reply-To: <45780AF5.2020605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Thu, Dec 07, 2006 at 09:37:09PM +0900, Tejun Heo wrote:
> Alan wrote:
> > On Thu, 07 Dec 2006 13:28:02 +0900
> > Tejun Heo <htejun@gmail.com> wrote:
> > 
> >> Please test the attached patch.
> > 
> > That should be getting done automatically by the driver and used to work
> > with the old eh/probe code. It does rely on having done the initial PIO0
> > identify of both devices and the mode decision being made before mode
> > setting functions are called however, and that is/was documented as a
> > guarantee, and is relied upon all over.
> 
> I broke it in the following commit while implementing per-dev xfermode.
>  I have no idea what I was thinking.  :-(
> 
> commit 37deecb5139ee431233781a9a093d9fcaab54c5b
> [PATCH] libata: implement per-dev xfermask
> 
> > Definitely worth testing Art, especially if it shows something up.
> 
> Art, I attached the wrong patch and it won't apply to vanilla 2.6.19.
> Patch against 2.6.19 is attached here.  Please test this one.
> [ ... snip ... ]
> 
> Let's see if this patch fixes anything.
> [ ... snip patch ... ]

Hi.

Sorry to report that patch did not work. I applied the patch against
Linus's tree this morning, built and installed that kernel, and
the CD-ROM was not found. I also tried the patch with an update
from Linus's tree from this evening, and again the same result.

Here's the complete 'dmesg' output:

Linux version 2.6.19-ajh3 (arth@pcdebian) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)) #10 Thu Dec 7 17:46:08 CST 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end: 00000000000a0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 0000000007ef0000 end: 0000000007ff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 0000000007ff0000 size: 0000000000003000 end: 0000000007ff3000 type: 4
copy_e820_map() start: 0000000007ff3000 size: 000000000000d000 end: 0000000008000000 type: 3
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
Entering add_active_range(0, 0, 32752) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    32752
early_node_map[1] active PFN ranges
    0:        0 ->    32752
On node 0 totalpages: 32752
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 223 pages used for memmap
  Normal zone: 28433 pages, LIFO batch:7
DMI 2.1 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f6c60
ACPI: RSDT (v001 GBT    AWRDACPI 0x00000000  0x00000000) @ 0x07ff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x00000000  0x00000000) @ 0x07ff3040
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x01000007) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 10000000 (gap: 08000000:f7ff0000)
Detected 398.945 MHz processor.
Built 1 zonelists.  Total pages: 32497
Kernel command line: BOOT_IMAGE=2.6.19-ajh3 ro root=LABEL=/ root=/dev/sda1
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01101000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 127200k/131008k available (1469k kernel code, 3348k reserved, 469k data, 152k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffff7000 - 0xfffff000   (  32 kB)
    vmalloc : 0xc8800000 - 0xffff5000   ( 887 MB)
    lowmem  : 0xc0000000 - 0xc7ff0000   ( 127 MB)
      .init : 0xc02e8000 - 0xc030e000   ( 152 kB)
      .data : 0xc026f584 - 0xc02e4a30   ( 469 kB)
      .text : 0xc0100000 - 0xc026f584   (1469 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 798.26 BogoMIPS (lpj=399130)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 01
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 1c00)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
PCI quirk: region 4000-403f claimed by PIIX4 ACPI
PCI quirk: region 5000-500f claimed by PIIX4 SMB
Boot video device is 0000:00:08.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: Power Resource [PFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0A03
pnp: ACPI device : hid PNP0C01
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0700
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0400
pnp: ACPI device : hid PNP0303
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
libata version 2.00 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:02' and the driver 'system'
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:08' and the driver 'serial'
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:09' and the driver 'serial'
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ata_piix 0000:00:07.1: version 2.00ac7
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : ata_piix
ata1.00: ATA-2, max UDMA/33, 6303024 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATA-4, max UDMA/66, 16514064 sectors: LBA 
ata1.01: ata1: dev 1 multi count 16
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33
scsi1 : ata_piix
ata2.00: ATAPI, max MWDMA1
ata2.00: revalidation failed (errno=-2)
ata2.00: limiting speed to PIO4
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: revalidation failed (errno=-2)
ata2.00: limiting speed to PIO0
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: revalidation failed (errno=-2)
ata2.00: disabled
scsi 0:0:0:0: Direct-Access     ATA      ST33232A         3.02 PQ: 0 ANSI: 5
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
scsi 0:0:1:0: Direct-Access     ATA      FUJITSU MPD3084A DD-0 PQ: 0 ANSI: 5
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 < sdb5 sdb6 > sdb3
sd 0:0:1:0: Attached scsi disk sdb
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP cubic registered
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 152k freed
NET: Registered protocol family 1
Real Time Clock Driver v1.12ac
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
eth0: RealTek RTL8139 at 0xc8808000, 00:05:5d:45:47:96, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8139C'
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
Adding 100760k swap on /dev/sda7.  Priority:-1 extents:1 across:100760k
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 17
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ttyS3: LSR safety check engaged!
ttyS3: LSR safety check engaged!
EXT3 FS on sda5, internal journal
EXT3 FS on sda6, internal journal
EXT3 FS on sdb5, internal journal
EXT3 FS on sdb6, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

The patch you sent applies cleanly but with large offsets. The
diff against Linus's current tree if it can be of use is below.

Art Haas

P.S. Any suggestions on what to do to get rid of the 'LSR safety
check engaged' messages?


diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 011c0a8..62e4d48 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3394,6 +3394,7 @@ static void ata_dev_xfermask(struct ata_device *dev)
 	struct ata_port *ap = dev->ap;
 	struct ata_host *host = ap->host;
 	unsigned long xfer_mask;
+	int i;
 
 	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
@@ -3412,10 +3413,27 @@ static void ata_dev_xfermask(struct ata_device *dev)
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 
 
+	/* apply xfermask limits of this device */
 	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
 				       dev->mwdma_mask, dev->udma_mask);
 	xfer_mask &= ata_id_xfermask(dev->id);
 
+	/* PIO xfermask limits are shared by all devices on the same
+	 * channel to avoid violating device selection timing.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *d = &ap->device[i];
+		unsigned int pio_mask;
+
+		if (ata_dev_absent(d))
+			continue;
+
+		ata_unpack_xfermask(ata_id_xfermask(d->id),
+				    &pio_mask, NULL, NULL);
+		pio_mask &= d->pio_mask;
+		xfer_mask &= ata_pack_xfermask(pio_mask, UINT_MAX, UINT_MAX);
+	}
+
 	/*
 	 *	CFA Advanced TrueIDE timings are not allowed on a shared
 	 *	cable

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
