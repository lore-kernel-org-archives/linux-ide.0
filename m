From: Derek Taubert <taubert@geeks.org>
Subject: Bad write performance with libata-tj-stable-2.6.17.4-20060710, pcmcia based sata_sil24, PMP, and NCQ drive
Date: Mon, 28 Aug 2006 16:01:32 -0700
Message-ID: <20060828230132.GB20189@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jacobs.geeks.org ([204.153.247.1]:3542 "EHLO mail.geeks.org")
	by vger.kernel.org with ESMTP id S1750892AbWH1XBh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2006 19:01:37 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org
Cc: taubert@geeks.org


Greetings!

I'm using a 2.6.17.4 kernel (straight from kernel.org) patched with
libata-tj-stable-2.6.17.4-20060710 in an effort to make use of an external
drive bay with a Silicon Image port multipler and a bunch of SATA/PATA
drives.  For the most part, it's a success (more below) but the write
performance that I'm seeing to a new Seagate 750GB drive (with NCQ) is
terrible (on the order of 1.2MBytes/sec).

The host is an old Toshiba laptop (PIIX4 based) with a 550MHz Celeron
processor.  The SATA host interface is a PCMCIA based Silicon Image 3124
chip plugged into the Yenta PCMCIA controller.  A tulip based Linksys
10/100 card takes up the other slot.  From dmesg:

ACPI: PCI Interrupt 0000:00:04.1[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:00:04.1 [1179:ff00]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.1, mfunc 0x000c1722, devctl 0x66
usb 1-1: configuration #1 chosen from 1 choice
Yenta: ISA IRQ mask 0x0838, PCI irq 10
Socket status: 30000020
pccard: CardBus card inserted into slot 0
pccard: CardBus card inserted into slot 1
st: Version 20050830, fixed bufsize 32768, s/g segs 256
Adding 248996k swap on /dev/hda2.  Priority:42 extents:1 across:248996k
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:02:00.0 to 64
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #0 config 3000 status 7829 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 00011400, 00:E0:98:04:21:54, IRQ 10.
libata version 2.00 loaded.
sata_sil24 0000:06:00.0: version 0.3
PCI: Enabling device 0000:06:00.0 (0080 -> 0083)
ACPI: PCI Interrupt 0000:06:00.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:06:00.0 to 64
ata1: SATA max UDMA/100 cmd 0xC8CB0000 ctl 0x0 bmdma 0x0 irq 10
ata2: SATA max UDMA/100 cmd 0xC8CB2000 ctl 0x0 bmdma 0x0 irq 10
ata3: SATA max UDMA/100 cmd 0xC8CB4000 ctl 0x0 bmdma 0x0 irq 10
ata4: SATA max UDMA/100 cmd 0xC8CB6000 ctl 0x0 bmdma 0x0 irq 10
scsi0 : sata_sil24
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_sil24
ata2: SATA link down (SStatus 0 SControl 300)
scsi2 : sata_sil24
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_sil24
ata4: SATA link down (SStatus 0 SControl 300)


The /var/log/messages output after hotplugging the multiplier.  Note the
NCQ for ata1.00:

Aug 27 18:48:26 linux-srv kernel: ata1: soft resetting port
Aug 27 18:48:26 linux-srv kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 27 18:48:26 linux-srv kernel: ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
Aug 27 18:48:27 linux-srv kernel: ata1.00: hard resetting port
Aug 27 18:48:29 linux-srv kernel: ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Aug 27 18:48:29 linux-srv kernel: ata1.01: hard resetting port
Aug 27 18:48:30 linux-srv kernel: ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 27 18:48:30 linux-srv kernel: ata1.02: hard resetting port
Aug 27 18:48:31 linux-srv kernel: ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 27 18:48:31 linux-srv kernel: ata1.03: hard resetting port
Aug 27 18:48:31 linux-srv kernel: ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 27 18:48:31 linux-srv kernel: ata1.04: hard resetting port
Aug 27 18:48:32 linux-srv kernel: ata1.04: SATA link down (SStatus 0 SControl 300)
Aug 27 18:48:32 linux-srv kernel: ata1.00: ATA-7, max UDMA/133, 1465149168 sectors: LBA48 NCQ (depth 31/32)
Aug 27 18:48:32 linux-srv kernel: ata1.00: configured for UDMA/100
Aug 27 18:48:32 linux-srv kernel: ata1.01: ATA-7, max UDMA/133, 490234752 sectors: LBA48
Aug 27 18:48:32 linux-srv kernel: ata1.01: ata1: dev 0 multi count 0
Aug 27 18:48:32 linux-srv kernel: ata1.01: applying bridge limits
Aug 27 18:48:32 linux-srv kernel: ata1.01: configured for UDMA/100
Aug 27 18:48:32 linux-srv kernel: ata1.02: ATA-6, max UDMA/100, 488397168 sectors: LBA48
Aug 27 18:48:32 linux-srv kernel: ata1.02: ata1: dev 0 multi count 0
Aug 27 18:48:32 linux-srv kernel: ata1.02: applying bridge limits
Aug 27 18:48:32 linux-srv kernel: ata1.02: configured for UDMA/100
Aug 27 18:48:32 linux-srv kernel: ata1.03: ATA-6, max UDMA/100, 488397168 sectors: LBA48
Aug 27 18:48:32 linux-srv kernel: ata1.03: ata1: dev 0 multi count 0
Aug 27 18:48:32 linux-srv kernel: ata1.03: applying bridge limits
Aug 27 18:48:32 linux-srv kernel: ata1.03: configured for UDMA/100
Aug 27 18:48:32 linux-srv kernel: ata1: EH complete
Aug 27 18:48:32 linux-srv kernel:   Vendor: ATA       Model: ST3750640AS       Rev: 3.AA
Aug 27 18:48:32 linux-srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Aug 27 18:48:32 linux-srv kernel: SCSI device sda: 1465149168 512-byte hdwr sectors (750156 MB)
Aug 27 18:48:32 linux-srv kernel: sda: Write Protect is off
Aug 27 18:48:32 linux-srv kernel: sda: Mode Sense: 00 3a 00 00
Aug 27 18:48:32 linux-srv kernel: SCSI device sda: drive cache: write back
Aug 27 18:48:32 linux-srv kernel: SCSI device sda: 1465149168 512-byte hdwr sectors (750156 MB)
Aug 27 18:48:32 linux-srv kernel: sda: Write Protect is off
Aug 27 18:48:32 linux-srv kernel: sda: Mode Sense: 00 3a 00 00
Aug 27 18:48:32 linux-srv kernel: SCSI device sda: drive cache: write back
Aug 27 18:48:32 linux-srv kernel:  sda: sda1
Aug 27 18:48:32 linux-srv kernel: sd 0:0:0:0: Attached scsi disk sda
Aug 27 18:48:32 linux-srv kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Aug 27 18:48:32 linux-srv kernel:   Vendor: ATA       Model: Maxtor 6Y250P0    Rev: YAR4
Aug 27 18:48:32 linux-srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Aug 27 18:48:32 linux-srv kernel: SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
Aug 27 18:48:32 linux-srv kernel: sdb: Write Protect is off
Aug 27 18:48:32 linux-srv kernel: sdb: Mode Sense: 00 3a 00 00
Aug 27 18:48:32 linux-srv kernel: SCSI device sdb: drive cache: write back
Aug 27 18:48:32 linux-srv kernel: SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
Aug 27 18:48:32 linux-srv kernel: sdb: Write Protect is off
Aug 27 18:48:32 linux-srv kernel: sdb: Mode Sense: 00 3a 00 00
Aug 27 18:48:32 linux-srv kernel: SCSI device sdb: drive cache: write back
Aug 27 18:48:32 linux-srv kernel:  sdb: sdb1
Aug 27 18:48:32 linux-srv kernel: sd 0:0:1:0: Attached scsi disk sdb
Aug 27 18:48:32 linux-srv kernel: sd 0:0:1:0: Attached scsi generic sg1 type 0
Aug 27 18:48:32 linux-srv kernel:   Vendor: ATA       Model: WDC WD2500BB-00G  Rev: 08.0
Aug 27 18:48:32 linux-srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Aug 27 18:48:32 linux-srv kernel: SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
Aug 27 18:48:32 linux-srv kernel: sdc: Write Protect is off
Aug 27 18:48:32 linux-srv kernel: sdc: Mode Sense: 00 3a 00 00
Aug 27 18:48:32 linux-srv kernel: SCSI device sdc: drive cache: write back
Aug 27 18:48:32 linux-srv kernel: SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
Aug 27 18:48:32 linux-srv kernel: sdc: Write Protect is off
Aug 27 18:48:32 linux-srv kernel: sdc: Mode Sense: 00 3a 00 00
Aug 27 18:48:32 linux-srv kernel: SCSI device sdc: drive cache: write back
Aug 27 18:48:32 linux-srv kernel:  sdc: sdc1
Aug 27 18:48:32 linux-srv kernel: sd 0:0:2:0: Attached scsi disk sdc
Aug 27 18:48:32 linux-srv kernel: sd 0:0:2:0: Attached scsi generic sg2 type 0
Aug 27 18:48:32 linux-srv kernel:   Vendor: ATA       Model: WDC WD2500JB-00G  Rev: 08.0
Aug 27 18:48:32 linux-srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Aug 27 18:48:32 linux-srv kernel: SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
Aug 27 18:48:32 linux-srv kernel: sdd: Write Protect is off
Aug 27 18:48:32 linux-srv kernel: sdd: Mode Sense: 00 3a 00 00
Aug 27 18:48:32 linux-srv kernel: SCSI device sdd: drive cache: write back
Aug 27 18:48:32 linux-srv kernel: SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
Aug 27 18:48:32 linux-srv kernel: sdd: Write Protect is off
Aug 27 18:48:32 linux-srv kernel: sdd: Mode Sense: 00 3a 00 00
Aug 27 18:48:32 linux-srv kernel: SCSI device sdd: drive cache: write back
Aug 27 18:48:32 linux-srv kernel:  sdd: sdd1
Aug 27 18:48:32 linux-srv kernel: sd 0:0:3:0: Attached scsi disk sdd
Aug 27 18:48:32 linux-srv kernel: sd 0:0:3:0: Attached scsi generic sg3 type 0
Aug 27 18:48:33 linux-srv /etc/hotplug.d/block/50-hwscan.hotplug[16227]: new block device /block/sda
Aug 27 18:48:35 linux-srv /etc/hotplug.d/block/50-hwscan.hotplug[16437]: new block device /block/sdb
Aug 27 18:48:35 linux-srv /etc/hotplug.d/block/50-hwscan.hotplug[16467]: new block device /block/sdd
Aug 27 18:48:35 linux-srv /etc/hotplug.d/block/50-hwscan.hotplug[16487]: new block device /block/sdc
Aug 27 18:48:35 linux-srv /etc/hotplug.d/block/50-hwscan.hotplug[16587]: new block device /block/sdc/sdc1
Aug 27 18:48:35 linux-srv /etc/hotplug.d/block/50-hwscan.hotplug[16599]: new block device /block/sdd/sdd1
Aug 27 18:48:37 linux-srv /etc/hotplug.d/block/50-hwscan.hotplug[16611]: new block device /block/sdb/sdb1
Aug 27 18:48:38 linux-srv /etc/hotplug.d/block/50-hwscan.hotplug[16603]: new block device /block/sda/sda1
Aug 27 18:49:01 linux-srv hald[9182]: Timed out waiting for hotplug event 1950. Rebasing to 1930


What works:

1) Read performance to all 4 drives is ok (40-50 MBytes/sec as reported
   by iostat) and stable.  I've hammered a read-only software RAID5 spread
   across the last 3 drives with no problem.
2) "smartctl -d ata -a" works nicely to all 4 drives.
3) hdparm -S makes the drives spin down when idle as expected.
4) Hotplug seems to work quite well.  I'm even able to power down and
   remove a drive from the port multiplier while the other 3 are reading
   data (during a "e2fsck -f -n /dev/md0").


What doesn't work so well:

1) Writing to sda1.

# dd if=/dev/zero of=/dev/sda1 count=4M
<ctrl-c, then wait 30 seconds>
264205+0 records in
264204+0 records out
135272448 bytes (135 MB) copied, 111.373 seconds, 1.2 MB/s

>From iostat -k 10:
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda            2428.64      2422.46       667.66      24273       6690
sda              36.84        23.72      1667.87        237      16662
sda            2440.60      2434.90       616.00      24349       6160
The read rate is curious (should be 0)...

Top shows 1% user, 3% system, 93% wait.

If I "cat /proc/scsi/sg/devices" during this test, the next to last column
seems to indicate that the queue fills up and pretty much stays that way:

# cat /proc/scsi/sg/devices
0       0       0       0       0       1       31      0       1
0       0       1       0       0       1       1       0       1
0       0       2       0       0       1       1       0       1
0       0       3       0       0       1       1       0       1
# cat /proc/scsi/sg/devices
0       0       0       0       0       1       31      29      1
0       0       1       0       0       1       1       0       1
0       0       2       0       0       1       1       1       1
0       0       3       0       0       1       1       1       1
# cat /proc/scsi/sg/devices
0       0       0       0       0       1       31      31      1
0       0       1       0       0       1       1       0       1
0       0       2       0       0       1       1       0       1
0       0       3       0       0       1       1       0       1
# cat /proc/scsi/sg/devices
0       0       0       0       0       1       31      30      1
0       0       1       0       0       1       1       0       1
0       0       2       0       0       1       1       1       1
0       0       3       0       0       1       1       0       1

2) hdparm -C for all 4 drives always shows "drive state is:  standby"
   even when I'm certain that the drives are active.


I'd really like some assistance debugging the write performance issue.
The "hdparm -C" issue would be gravy...

Thanks,
Derek
