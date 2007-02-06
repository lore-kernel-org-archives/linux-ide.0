From: "Art Haas" <ahaas@airmail.net>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't apply)
Date: Tue, 6 Feb 2007 10:33:03 -0600
Message-ID: <20070206163303.GA2185@artsapartment.org>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com> <45C4E6BB.6020307@pobox.com> <45C84650.3030703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:62638 "EHLO
	ms-smtp-01.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbXBFQdM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 11:33:12 -0500
Received: from pcdebian (cpe-68-201-223-150.houston.res.rr.com [68.201.223.150])
	by ms-smtp-01.texas.rr.com (8.13.6/8.13.6) with ESMTP id l16GX6ck005936
	for <linux-ide@vger.kernel.org>; Tue, 6 Feb 2007 10:33:10 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <45C84650.3030703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Tue, Feb 06, 2007 at 06:11:44PM +0900, Tejun Heo wrote:
> Mark Lord wrote:
> > Tejun Heo wrote:
> >> ..
> >> Then, PACKET_IDENTIFY after configuring transfer mode fails with
> >> -ENOENT.  Meaning it saw (status & (ATA_BUSY|ATA_DRQ|ATA_ERR|ATA_DF)) ==
> >> 0 in HSM_ST.
> > ..
> >> So, PATA gurus, can you bless us with enlightenment?  :-)
> > 
> > Heh.. guaranteeing detection of all the strange implementations out there
> > is part black magic.
> > 
> > But the simple thing to do here is, just for fun, hack the code
> > to do the infamous 50 millisecond hard wait before issuing the
> > PACKET_IDENTIFY.
> > If that fixes it, then it's just a matter of tuning to discover the real
> > amount of delay required, and a nicer way of doing the delay.
> 
> Okay.
> 
> > Also, zero out the features register before issuing PACKET_IDENTIFY,
> > if the code isn't already doing that.
> 
> Okay.
> 
> > After the drive asserts BUSY, and later deasserts BUSY,
> > there might be a slight delay before the drive asserts DRQ.
> > So, it is possible for the status to read zeros in the important bits.
> > 
> > My suggestion is to wait up to the infamous 50 milliseconds again here,
> > if needed.
> 
> Okay, the attached patch does what Mark suggested.  Art, can you please
> give it a shot and report dmesg?  My thanks for sticking around till now.
> 

SUCCESS!!!!!

$ dmesg
Linux version 2.6.20-ajh (arth@pcdebian) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 Tue Feb 6 08:36:33 CST 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end: 00000000000a0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fef0000 end: 000000001fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001fff0000 size: 0000000000003000 end: 000000001fff3000 type: 4
copy_e820_map() start: 000000001fff3000 size: 000000000000d000 end: 0000000020000000 type: 3
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
Entering add_active_range(0, 0, 131056) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131056
early_node_map[1] active PFN ranges
    0:        0 ->   131056
On node 0 totalpages: 131056
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 991 pages used for memmap
  Normal zone: 125969 pages, LIFO batch:31
DMI 2.1 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f6c60
ACPI: RSDT (v001 GBT    AWRDACPI 0x00000000  0x00000000) @ 0x1fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x00000000  0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x01000007) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Detected 398.959 MHz processor.
Built 1 zonelists.  Total pages: 130033
Kernel command line: BOOT_IMAGE=2.6.20-ajh ro root=LABEL=/ root=/dev/sda1
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01402000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 516956k/524224k available (1460k kernel code, 6724k reserved, 485k data, 148k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffff7000 - 0xfffff000   (  32 kB)
    vmalloc : 0xe0800000 - 0xffff5000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc02ea000 - 0xc030f000   ( 148 kB)
      .data : 0xc026d38f - 0xc02e6a50   ( 485 kB)
      .text : 0xc0100000 - 0xc026d38f   (1460 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 798.30 BogoMIPS (lpj=399150)
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
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
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
ata2.00: configured for MWDMA1
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
scsi 1:0:0:0: CD-ROM                     ATAPI CDROM      1.80 PQ: 0 ANSI: 5
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
TCP cubic registered
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 148k freed
NET: Registered protocol family 1
sr0: scsi3-mmc drive: 4x/24x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
Real Time Clock Driver v1.12ac
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
eth0: RealTek RTL8139 at 0xe0840000, 00:05:5d:45:47:96, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8139C'
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
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
$

Yay!

In addition to the patch above, the working kernel also has the
'ata_piix.c' patch applied. The combined diffs are listed below.

Thanks for fixing the problems, and I'm glad I could help test patches.
I hope these changes can make it into the 2.6.21 kernel.

Art Haas

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 47701b2..71f5756 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -723,8 +723,14 @@ static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 	if (adev->class == ATA_DEV_ATA)
 		control |= 4;	/* PPE enable */
 
+	/* PIO configuration clears DTE unconditionally.  It will be
+	 * programmed in set_dmamode which is guaranteed to be called
+	 * after set_piomode if any DMA mode is available.
+	 */
 	pci_read_config_word(dev, master_port, &master_data);
 	if (is_slave) {
+		/* clear TIME1|IE1|PPE1|DTE1 */
+		master_data &= 0xff0f;
 		/* Enable SITRE (seperate slave timing register) */
 		master_data |= 0x4000;
 		/* enable PPE1, IE1 and TIME1 as needed */
@@ -732,12 +738,14 @@ static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 		pci_read_config_byte(dev, slave_port, &slave_data);
 		slave_data &= (ap->port_no ? 0x0f : 0xf0);
 		/* Load the timing nibble for this slave */
-		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
+		slave_data |= ((timings[pio][0] << 2) | timings[pio][1])
+						<< (ap->port_no ? 4 : 0);
 	} else {
-		/* Master keeps the bits in a different format */
-		master_data &= 0xccf8;
+		/* clear ISP|RCT|TIME0|IE0|PPE0|DTE0 */
+		master_data &= 0xccf0;
 		/* Enable PPE, IE and TIME as appropriate */
 		master_data |= control;
+		/* load ISP and RCT */
 		master_data |=
 			(timings[pio][0] << 12) |
 			(timings[pio][1] << 8);
@@ -853,7 +861,7 @@ static void do_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev, i
 			master_data &= 0xFF4F;  /* Mask out IORDY|TIME1|DMAONLY */
 			master_data |= control << 4;
 			pci_read_config_byte(dev, 0x44, &slave_data);
-			slave_data &= (0x0F + 0xE1 * ap->port_no);
+			slave_data &= (ap->port_no ? 0x0f : 0xf0);
 			/* Load the matching timing */
 			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
 			pci_write_config_byte(dev, 0x44, slave_data);
@@ -865,8 +873,11 @@ static void do_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev, i
 				(timings[pio][0] << 12) |
 				(timings[pio][1] << 8);
 		}
-		udma_enable &= ~(1 << devid);
-		pci_write_config_word(dev, master_port, master_data);
+
+		if (ap->udma_mask) {
+			udma_enable &= ~(1 << devid);
+			pci_write_config_word(dev, master_port, master_data);
+		}
 	}
 	/* Don't scribble on 0x48 if the controller does not support UDMA */
 	if (ap->udma_mask)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 667acd2..4c81433 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1478,7 +1478,8 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	}
 
 	tf.protocol = ATA_PROT_PIO;
-	tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */
+	/* POLLING for polling detection, ISADDR|DEVICE to clear TF */
+	tf.flags |= ATA_TFLAG_POLLING | ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
@@ -4477,6 +4478,18 @@ fsm_start:
 				goto fsm_start;
 
 		} else {
+			unsigned long timeout = jiffies + msecs_to_jiffies(50);
+
+			while (time_before(jiffies, timeout)) {
+				if (status & ATA_DRQ)
+					break;
+				ata_dev_printk(qc->dev, KERN_INFO,
+					"XXX: waiting for DRQ, status=0x%x\n",
+					status);
+				msleep(10);
+				status = ata_chk_status(ap);
+			}
+
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
 				/* handle BSY=0, DRQ=0 as error */

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
