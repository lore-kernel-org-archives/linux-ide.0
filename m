From: idurdanovic@comcast.net (Igor Durdanovic)
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 4 Oct 2007 01:35:31 -0400
Message-ID: <18180.31651.305092.579581@kitty1.shrimp.net>
References: <18180.26625.216781.626572@kitty1.shrimp.net>
	<470468EE.909@gmail.com>
	<18180.30643.554165.292012@kitty1.shrimp.net>
	<4704790C.7060901@gmail.com>
Reply-To: idurdanovic@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:51513 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbXJDFfs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 01:35:48 -0400
In-Reply-To: <4704790C.7060901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


Tejun Heo writes:
> Igor Durdanovic wrote:
> > Tejun Heo writes:
> >> PMP patchset is not in mainline yet.  You need to apply patches from the
> >> following page.
> >>
> >>   http://home-tj.org/wiki/index.php/Libata-tj-stable
> > 
> > Yes! it works now (though there were tons of hard and soft resets
> > during booting, if you need log I can email it).
> 
> Yeah, please post the log.  Also, please cc linux-ide@vger.kernel.org.

No problem, here is the log of sata_sil24 while booting the kernel
2.6.22.1 on Dell latitude D820 with SIIG SC-SAE512-S1 SATA II
ExpressCard 54 connected to DS-2350S 5-BAY enclosure.

Regards, Igor

sata_sil24 0000:0d:00.0: version 1.0
ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:0d:00.0 to 64
scsi2 : sata_sil24
scsi3 : sata_sil24
ata3: SATA max UDMA/100 cmd 0xf8d08000 ctl 0x00000000 bmdma 0x00000000 irq 16
ata4: SATA max UDMA/100 cmd 0xf8d0a000 ctl 0x00000000 bmdma 0x00000000 irq 16
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata4.00: hard resetting link
ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.01: hard resetting link
ata4.01: softreset failed (SRST command error)
ata4.01: reset failed (errno=-5), retrying in 10 secs
ata4.01: hard resetting link
ata4.02: hard resetting link
ata4.02: COMRESET failed (errno=-5)
ata4.02: reset failed, giving up
ata4.15: hard resetting link
ata4: controller in dubious state, performing PORT_RST
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.00: hard resetting link
ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.01: hard resetting link
ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.02: hard resetting link
ata4.02: softreset failed (SRST command error)
ata4.02: reset failed (errno=-5), retrying in 10 secs
ata4.02: hard resetting link
ata4.03: hard resetting link
ata4.03: COMRESET failed (errno=-5)
ata4.03: reset failed, giving up
ata4.15: hard resetting link
ata4: controller in dubious state, performing PORT_RST
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.00: hard resetting link
ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.01: hard resetting link
ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.02: hard resetting link
ata4.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.03: hard resetting link
ata4.03: softreset failed (SRST command error)
ata4.03: reset failed (errno=-5), retrying in 10 secs
ata4.03: hard resetting link
ata4.04: hard resetting link
ata4.04: COMRESET failed (errno=-5)
ata4.04: reset failed, giving up
ata4.15: hard resetting link
ata4: controller in dubious state, performing PORT_RST
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.00: hard resetting link
ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.01: hard resetting link
ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.02: hard resetting link
ata4.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.03: hard resetting link
ata4.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.04: hard resetting link
ata4.04: softreset failed (SRST command error)
ata4.04: reset failed (errno=-5), retrying in 10 secs
ata4.04: hard resetting link
ata4.05: hard resetting link
ata4.05: COMRESET failed (errno=-5)
ata4.05: reset failed, giving up
ata4.15: hard resetting link
ata4: controller in dubious state, performing PORT_RST
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.00: hard resetting link
ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.01: hard resetting link
ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.02: hard resetting link
ata4.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.03: hard resetting link
ata4.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.04: hard resetting link
ata4.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.05: hard resetting link
ata4.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.06: hard resetting link
ata4.06: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
ata4.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/100
ata4.01: ATA-7: ST3750640AS, 3.AAD, max UDMA/133
ata4.01: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.01: configured for UDMA/100
ata4.02: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
ata4.02: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.02: configured for UDMA/100
ata4.03: ATA-7: ST3750640AS, 3.AAD, max UDMA/133
ata4.03: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.03: configured for UDMA/100
ata4.04: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
ata4.04: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.04: configured for UDMA/100
ata4.05: ATA-6: Config  Disk, PLS12052, max UDMA/133
ata4.05: 640 sectors, multi 1: LBA 
ata4.05: device is on DMA blacklist, disabling DMA
ata4.05: configured for PIO4
ata4: EH complete
scsi 3:0:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdb: unknown partition table
sd 3:0:0:0: [sdb] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg2 type 0
scsi 3:1:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:1:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:1:0:0: [sdc] Write Protect is off
sd 3:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:1:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:1:0:0: [sdc] Write Protect is off
sd 3:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 3:1:0:0: [sdc] Attached SCSI disk
sd 3:1:0:0: Attached scsi generic sg3 type 0
scsi 3:2:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:2:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:2:0:0: [sdd] Write Protect is off
sd 3:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:2:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:2:0:0: [sdd] Write Protect is off
sd 3:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 3:2:0:0: [sdd] Attached SCSI disk
sd 3:2:0:0: Attached scsi generic sg4 type 0
scsi 3:3:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:3:0:0: [sde] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:3:0:0: [sde] Write Protect is off
sd 3:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 3:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:3:0:0: [sde] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:3:0:0: [sde] Write Protect is off
sd 3:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 3:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 3:3:0:0: [sde] Attached SCSI disk
sd 3:3:0:0: Attached scsi generic sg5 type 0
scsi 3:4:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:4:0:0: [sdf] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:4:0:0: [sdf] Write Protect is off
sd 3:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 3:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:4:0:0: [sdf] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:4:0:0: [sdf] Write Protect is off
sd 3:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 3:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1 sdf2 sdf3 sdf4 < sdf5 sdf6 sdf7 sdf8 sdf9 sdf10 sdf11 >
sd 3:4:0:0: [sdf] Attached SCSI disk
sd 3:4:0:0: Attached scsi generic sg6 type 0
scsi 3:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 3:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
sd 3:5:0:0: [sdg] Write Protect is off
sd 3:5:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 3:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 3:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
sd 3:5:0:0: [sdg] Write Protect is off
sd 3:5:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 3:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdg: unknown partition table
sd 3:5:0:0: [sdg] Attached SCSI disk
sd 3:5:0:0: Attached scsi generic sg7 type 0
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
eth1394: eth1: IPv4 over IEEE 1394 (fw-host0)
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
input: PC Speaker as /class/input/input4
i2c /dev entries driver
i2c-core: driver [dev_driver] registered
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 18
i801_smbus 0000:00:1f.3: SMBus using interrupt SMI#
i2c-adapter i2c-0: adapter [SMBus I801 adapter at 10c0] registered
i2c-dev: adapter [SMBus I801 adapter at 10c0] registered as minor 0
raid6: int32x1    750 MB/s
raid6: int32x2    800 MB/s
raid6: int32x4    593 MB/s
raid6: int32x8    632 MB/s
raid6: mmxx1     2296 MB/s
raid6: mmxx2     2871 MB/s
raid6: sse1x1    1546 MB/s
raid6: sse1x2    2125 MB/s
raid6: sse2x1    2941 MB/s
raid6: sse2x2    3375 MB/s
raid6: using algorithm sse2x2 (3375 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  7112.000 MB/sec
raid5: using function: pIII_sse (7112.000 MB/sec)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
