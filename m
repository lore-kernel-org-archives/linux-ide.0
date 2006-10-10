From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [RFT PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use
 it in pata_via
Date: Tue, 10 Oct 2006 20:45:17 +0200
Message-ID: <452BEA3D.4020204@free.fr>
References: <20060928111151.GN25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040404090306070800040203"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6-g19.free.fr ([212.27.42.36]:59337 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030318AbWJJXN2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Oct 2006 19:13:28 -0400
In-Reply-To: <20060928111151.GN25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

This is a multi-part message in MIME format.
--------------040404090306070800040203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Sorry for the delay.

Tejun Heo wrote:
> This patch implements ATA_FLAG_SETXFER_POLLING and use in pata_via.
> If this flag is set, transfer mode setting performed by polling not by
> interrupt.  This should help those controllers which raise interrupt
> before the command is actually complete on SETXFER.
> 
> Rationale for this approach.
> 
> * uses existing facility and relatively simple
> * no busy sleep in the interrupt handler
> * updating drivers is easy
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> Matthieu Castet, can you please test this patch?  It's against
> libata-dev#upstream, but -mm might work too.  If you want a patch
> against -mm, just let me know.

With the attached patch against 19-rc1-mm1 (I had to remove pata irq 
handler), it seems to work (see the attached log).


Matthieu

--------------040404090306070800040203
Content-Type: text/plain;
 name="pata-ng"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pata-ng"

Linux version 2.6.19-rc1-mm1 (mat@mat-pc) (gcc version 4.1.2 20060928 (prerelease) (Debian 4.1.1-15)) #13 PREEMPT Tue Oct 10 19:45:53 CEST 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000003fef0000 end: 000000003fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000003fff0000 size: 0000000000008000 end: 000000003fff8000 type: 3
copy_e820_map() start: 000000003fff8000 size: 0000000000008000 end: 0000000040000000 type: 4
copy_e820_map() start: 00000000fec00000 size: 0000000000001000 end: 00000000fec01000 type: 2
copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end: 00000000fee01000 type: 2
copy_e820_map() start: 00000000fff80000 size: 0000000000080000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fb940
Entering add_active_range(0, 0, 262128) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262128
early_node_map[1] active PFN ranges
    0:        0 ->   262128
On node 0 totalpages: 262128
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 255 pages used for memmap
  HighMem zone: 32497 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa8e0
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x3fff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x3fff0030
ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x3fff00c0
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 1533.476 MHz processor.
Built 1 zonelists.  Total pages: 260081
Kernel command line: root=/dev/sdc3 ro ide=reverse init=/bin/sh log_buf_len=32M
log_buf_len: 33554432
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Clock event device pit configured with caps set: 07
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:failed|failed|  ok  |failed|failed|failed|
                 A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
                    double unlock:failed|failed|failed|  ok  |failed|failed|
                  initialize held:failed|failed|failed|failed|failed|failed|
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |failed|
           recursive read-lock #2:             |  ok  |             |failed|
            mixed read-write-lock:             |failed|             |failed|
            mixed write-read-lock:             |failed|             |failed|
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
         hard-safe-A + irqs-on/12:failed|failed|  ok  |
         soft-safe-A + irqs-on/12:failed|failed|  ok  |
         hard-safe-A + irqs-on/21:failed|failed|  ok  |
         soft-safe-A + irqs-on/21:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
      hard-irq lock-inversion/123:failed|failed|  ok  |
      soft-irq lock-inversion/123:failed|failed|  ok  |
      hard-irq lock-inversion/132:failed|failed|  ok  |
      soft-irq lock-inversion/132:failed|failed|  ok  |
      hard-irq lock-inversion/213:failed|failed|  ok  |
      soft-irq lock-inversion/213:failed|failed|  ok  |
      hard-irq lock-inversion/231:failed|failed|  ok  |
      soft-irq lock-inversion/231:failed|failed|  ok  |
      hard-irq lock-inversion/312:failed|failed|  ok  |
      soft-irq lock-inversion/312:failed|failed|  ok  |
      hard-irq lock-inversion/321:failed|failed|  ok  |
      soft-irq lock-inversion/321:failed|failed|  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
--------------------------------------------------------
144 out of 218 testcases failed, as expected. |
----------------------------------------------------
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1003472k/1048512k available (1682k kernel code, 44400k reserved, 605k data, 152k init, 131008k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffa9000 - 0xfffff000   ( 344 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0340000 - 0xc0366000   ( 152 kB)
      .data : 0xc02a49d8 - 0xc033c034   ( 605 kB)
      .text : 0xc0100000 - 0xc02a49d8   (1682 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3069.84 BogoMIPS (lpj=6139682)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Clock event device pit new caps set: 03
Clock event device lapic configured with caps set: 04
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0800-087f claimed by vt8235 PM
PCI quirk: region 0400-040f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ddd00000-dfdfffff
  PREFETCH window: cda00000-ddbfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
libata version 2.00 loaded.
pata_sil680 0000:00:07.0: version 0.3.2
sil680: BA5_EN = 1 clock = 00
sil680: BA5_EN = 1 clock = 10
sil680: 133MHz clock.
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 16
ata1: PATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD800 irq 16
ata2: PATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD808 irq 16
scsi0 : pata_sil680
ata1.00: ATA-7, max UDMA/133, 156368016 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : pata_sil680
ATA: abnormal status 0x7F on port 0xE007
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP0802N  TK10 PQ: 0 ANSI: 5
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
pata_via 0000:00:11.1: version 0.1.14
ACPI: Unable to derive IRQ for device 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
scsi2 : pata_via
ata3.00: ATA-7, max UDMA/100, 156368016 sectors: LBA48 
ata3.00: ata3: dev 0 multi count 16
ata3.01: ATA-5, max UDMA/100, 80418240 sectors: LBA 
ata3.01: ata3: dev 1 multi count 16
ata3.00: configured for UDMA/100
ata3.01: configured for UDMA/100
scsi3 : pata_via
ata4.00: ATAPI, max UDMA/33
ata4.01: ATAPI, max UDMA/33
ata4.00: configured for UDMA/33
ata4.01: configured for UDMA/33
scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG SP0802N  TK10 PQ: 0 ANSI: 5
SCSI device sdb: 156368016 512-byte hdwr sectors (80060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156368016 512-byte hdwr sectors (80060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 >
sd 2:0:0:0: Attached scsi disk sdb
sd 2:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:1:0: Direct-Access     ATA      IC35L040AVVA07-0 VA2O PQ: 0 ANSI: 5
SCSI device sdc: 80418240 512-byte hdwr sectors (41174 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 80418240 512-byte hdwr sectors (41174 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 sdc8 >
sd 2:0:1:0: Attached scsi disk sdc
sd 2:0:1:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1612 1004 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
sr 3:0:0:0: Attached scsi generic sg3 type 5
scsi 3:0:1:0: CD-ROM            CD-RW    CDR-6S48         SSG5 PQ: 0 ANSI: 5
sr1: scsi3-mmc drive: 175x/48x writer cd/rw xa/form2 cdda tray
sr 3:0:1:0: Attached scsi CD-ROM sr1
sr 3:0:1:0: Attached scsi generic sg4 type 5
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Time: acpi_pm clocksource has been installed.
Clock event device pit disabled
Clock event device lapic configured with caps set: 08
Switched to high resolution mode on CPU 0
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--------------040404090306070800040203
Content-Type: text/plain;
 name="pata_via-ng"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pata_via-ng"

Index: linux-2.6.16/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.16.orig/drivers/ata/libata-core.c	2006-10-10 19:40:35.000000000 +0200
+++ linux-2.6.16/drivers/ata/libata-core.c	2006-10-10 19:40:48.000000000 +0200
@@ -4122,7 +4122,8 @@
 
 fsm_start:
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+		ap->id, qc->tf.protocol, ap->hsm_task_state, status,
+		qc->tf.flags & ATA_TFLAG_POLLING);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -4712,6 +4713,14 @@
 		}
 	}
 
+	/* Some controllers show flaky interrupt behavior after
+	 * setting xfer mode.  Use polling instead.
+	 */
+	if (unlikely(qc->tf.command == ATA_CMD_SET_FEATURES &&
+		     qc->tf.feature == SETFEATURES_XFER) &&
+	    (ap->flags & ATA_FLAG_SETXFER_POLLING))
+		qc->tf.flags |= ATA_TFLAG_POLLING;
+
 	/* select the device */
 	ata_dev_select(ap, qc->dev->devno, 1, 0);
 
Index: linux-2.6.16/drivers/ata/pata_via.c
===================================================================
--- linux-2.6.16.orig/drivers/ata/pata_via.c	2006-10-10 19:40:35.000000000 +0200
+++ linux-2.6.16/drivers/ata/pata_via.c	2006-10-10 19:42:43.000000000 +0200
@@ -398,7 +398,7 @@
 
 	.data_xfer	= ata_pio_data_xfer,
 
-	.irq_handler	= pata_via_interrupt,
+	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 
 	.port_start	= ata_port_start,
@@ -433,7 +433,7 @@
 
 	.data_xfer	= ata_pio_data_xfer_noirq,
 
-	.irq_handler	= pata_via_interrupt,
+	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 
 	.port_start	= ata_port_start,
@@ -455,7 +455,8 @@
 	/* Early VIA without UDMA support */
 	static struct ata_port_info via_mwdma_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops
@@ -463,7 +464,8 @@
 	/* Ditto with IRQ masking required */
 	static struct ata_port_info via_mwdma_info_borked = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops_noirq,
@@ -471,7 +473,8 @@
 	/* VIA UDMA 33 devices (and borked 66) */
 	static struct ata_port_info via_udma33_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7,
@@ -480,7 +483,8 @@
 	/* VIA UDMA 66 devices */
 	static struct ata_port_info via_udma66_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
@@ -489,7 +493,8 @@
 	/* VIA UDMA 100 devices */
 	static struct ata_port_info via_udma100_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -498,7 +503,8 @@
 	/* UDMA133 with bad AST (All current 133) */
 	static struct ata_port_info via_udma133_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,	/* FIXME: should check north bridge */
Index: linux-2.6.16/include/linux/libata.h
===================================================================
--- linux-2.6.16.orig/include/linux/libata.h	2006-10-10 19:40:54.000000000 +0200
+++ linux-2.6.16/include/linux/libata.h	2006-10-10 19:41:00.000000000 +0200
@@ -178,6 +178,7 @@
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_DETECT_POLLING	= (1 << 14), /* detect device presence by
 					      * polling IDENTIFY */
+	ATA_FLAG_SETXFER_POLLING= (1 << 14), /* use polling for SETXFER */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be

--------------040404090306070800040203--
