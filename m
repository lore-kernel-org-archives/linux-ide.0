From: "Rune Torgersen" <runet@innovsys.com>
Subject: SiI3124 PCI master Abort error
Date: Tue, 21 Nov 2006 14:20:07 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189E028@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.innovsys.com ([66.115.232.196]:6173 "EHLO
	mail.innovsys.com") by vger.kernel.org with ESMTP id S1031387AbWKUUUI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 15:20:08 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

We ahave a embedded board with a SII3124 controller and four TI
6455DSP's connected to a Freescale 8280. 
DSP's are behind a PCI bridge, and the PCI runs at 50MHz.

When we do data transfers from the DSP's to the CPU (DSP's are bus
master) we get errors on the disk controller.
The datarate is not horribly high (23Mbyte/s in 40k chunks)

We're pretty sure that there is no data corruption on the PCI bus, as we
can transfer gigabytes worh of data to/from the dsp's or to/from the
disk (with no activity to the dsp's)

Here is the relevant sections from the kernel log.
We are running 2.6.18.
The disk is a Hitachi Deskstar T7K500 320GB sata 3.0.

Nov 20 19:38:37 oem_default_cpu1 kernel: ata1.00: exception Emask 0x20
SAct 0x1 SErr 0x0 action 0x2
Nov 20 19:38:37 oem_default_cpu1 kernel: ata1.00: (irq_stat 0x00020002,
PCI master abort while fetching PRB)
Nov 20 19:38:37 oem_default_cpu1 kernel: ata1.00: tag 0 cmd 0x61 Emask
0x20 stat 0x50 err 0x0 (host bus error)
Nov 20 19:38:37 oem_default_cpu1 kernel: ata1: soft resetting port
Nov 20 19:38:37 oem_default_cpu1 kernel: ata1: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Nov 20 19:38:37 oem_default_cpu1 kernel: ata1.00: configured for
UDMA/100
Nov 20 19:38:37 oem_default_cpu1 kernel: ata1: EH complete
Nov 20 19:38:37 oem_default_cpu1 kernel: SCSI device sda: 625142448
512-byte hdwr sectors (320073 MB)
Nov 20 19:38:37 oem_default_cpu1 kernel: sda: Write Protect is off
Nov 20 19:38:37 oem_default_cpu1 kernel: sda: Mode Sense: 00 3a 00 00
Nov 20 19:38:37 oem_default_cpu1 kernel: SCSI device sda: drive cache:
write back
Nov 20 19:39:09 oem_default_cpu1 kernel: ata1.00: exception Emask 0x20
SAct 0x1 SErr 0x0 action 0x2
Nov 20 19:39:09 oem_default_cpu1 kernel: ata1.00: (irq_stat 0x00020002,
PCI master abort while fetching PRB)
Nov 20 19:39:09 oem_default_cpu1 kernel: ata1.00: tag 0 cmd 0x61 Emask
0x20 stat 0x50 err 0x0 (host bus error)
Nov 20 19:39:09 oem_default_cpu1 kernel: ata1: soft resetting port
Nov 20 19:39:09 oem_default_cpu1 kernel: ata1: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Nov 20 19:39:09 oem_default_cpu1 kernel: ata1.00: configured for
UDMA/100
Nov 20 19:39:09 oem_default_cpu1 kernel: ata1: EH complete
Nov 20 19:39:09 oem_default_cpu1 kernel: SCSI device sda: 625142448
512-byte hdwr sectors (320073 MB)
Nov 20 19:39:09 oem_default_cpu1 kernel: sda: Write Protect is off
Nov 20 19:39:09 oem_default_cpu1 kernel: sda: Mode Sense: 00 3a 00 00
Nov 20 19:39:09 oem_default_cpu1 kernel: SCSI device sda: drive cache:
write back
Nov 20 19:39:14 oem_default_cpu1 kernel: ata1.00: exception Emask 0x20
SAct 0x1 SErr 0x0 action 0x2
Nov 20 19:39:14 oem_default_cpu1 kernel: ata1.00: (irq_stat 0x00020002,
PCI master abort while fetching PRB)
Nov 20 19:39:14 oem_default_cpu1 kernel: ata1.00: tag 0 cmd 0x61 Emask
0x20 stat 0x50 err 0x0 (host bus error)
Nov 20 19:39:14 oem_default_cpu1 kernel: ata1: soft resetting port
Nov 20 19:39:14 oem_default_cpu1 kernel: ata1: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Nov 20 19:39:14 oem_default_cpu1 kernel: ata1.00: configured for
UDMA/100
Nov 20 19:39:14 oem_default_cpu1 kernel: ata1: EH complete
Nov 20 19:39:14 oem_default_cpu1 kernel: SCSI device sda: 625142448
512-byte hdwr sectors (320073 MB)
Nov 20 19:39:14 oem_default_cpu1 kernel: sda: Write Protect is off
Nov 20 19:39:14 oem_default_cpu1 kernel: sda: Mode Sense: 00 3a 00 00
Nov 20 19:39:14 oem_default_cpu1 kernel: SCSI device sda: drive cache:
write back
Nov 20 19:41:58 oem_default_cpu1 kernel: ata1.00: exception Emask 0x20
SAct 0x1 SErr 0x0 action 0x2
Nov 20 19:41:58 oem_default_cpu1 kernel: ata1.00: (irq_stat 0x00020002,
PCI master abort while fetching PRB)
Nov 20 19:41:58 oem_default_cpu1 kernel: ata1.00: tag 0 cmd 0x61 Emask
0x20 stat 0x50 err 0x0 (host bus error)
Nov 20 19:41:58 oem_default_cpu1 kernel: ata1: soft resetting port
Nov 20 19:41:58 oem_default_cpu1 kernel: ata1: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Nov 20 19:41:58 oem_default_cpu1 kernel: ata1.00: configured for
UDMA/100
Nov 20 19:41:58 oem_default_cpu1 kernel: ata1: EH complete
Nov 20 19:41:58 oem_default_cpu1 kernel: SCSI device sda: 625142448
512-byte hdwr sectors (320073 MB)
Nov 20 19:41:58 oem_default_cpu1 kernel: sda: Write Protect is off
Nov 20 19:41:58 oem_default_cpu1 kernel: sda: Mode Sense: 00 3a 00 00
Nov 20 19:41:58 oem_default_cpu1 kernel: SCSI device sda: drive cache:
write back
Nov 20 19:42:03 oem_default_cpu1 kernel: ata1.00: exception Emask 0x20
SAct 0x1 SErr 0x0 action 0x2
Nov 20 19:42:03 oem_default_cpu1 kernel: ata1.00: (irq_stat 0x00020002,
PCI master abort while fetching PRB)
Nov 20 19:42:03 oem_default_cpu1 kernel: ata1.00: tag 0 cmd 0x61 Emask
0x20 stat 0x50 err 0x0 (host bus error)
Nov 20 19:42:03 oem_default_cpu1 kernel: ata1: soft resetting port
Nov 20 19:42:03 oem_default_cpu1 kernel: ata1: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Nov 20 19:42:03 oem_default_cpu1 kernel: ata1.00: configured for
UDMA/100
Nov 20 19:42:03 oem_default_cpu1 kernel: ata1: EH complete
Nov 20 19:42:03 oem_default_cpu1 kernel: SCSI device sda: 625142448
512-byte hdwr sectors (320073 MB)
Nov 20 19:42:03 oem_default_cpu1 kernel: sda: Write Protect is off
Nov 20 19:42:03 oem_default_cpu1 kernel: sda: Mode Sense: 00 3a 00 00
Nov 20 19:42:03 oem_default_cpu1 kernel: SCSI device sda: drive cache:
write back

reboot

Nov 20 19:57:32 oem_default_cpu1 kernel: Uniform Multi-Platform E-IDE
driver Revision: 7.00alpha2
Nov 20 19:57:32 oem_default_cpu1 kernel: ide: Assuming 33MHz system bus
speed for PIO modes; override with idebus=xx
Nov 20 19:57:32 oem_default_cpu1 kernel: libata version 2.00 loaded.
Nov 20 19:57:32 oem_default_cpu1 kernel: sata_sil24 0000:00:11.0:
version 0.3
Nov 20 19:57:32 oem_default_cpu1 kernel: ata1: SATA max UDMA/100 cmd
0xE1060000 ctl 0x0 bmdma 0x0 irq 69
Nov 20 19:57:32 oem_default_cpu1 kernel: ata2: SATA max UDMA/100 cmd
0xE1062000 ctl 0x0 bmdma 0x0 irq 69
Nov 20 19:57:32 oem_default_cpu1 kernel: ata3: SATA max UDMA/100 cmd
0xE1064000 ctl 0x0 bmdma 0x0 irq 69
Nov 20 19:57:32 oem_default_cpu1 kernel: ata4: SATA max UDMA/100 cmd
0xE1066000 ctl 0x0 bmdma 0x0 irq 69
Nov 20 19:57:32 oem_default_cpu1 kernel: scsi0 : sata_sil24
Nov 20 19:57:32 oem_default_cpu1 kernel: ata1: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Nov 20 19:57:32 oem_default_cpu1 kernel: ata1.00: ATA-7, max UDMA/133,
625142448 sectors: LBA48 NCQ (depth 31/32)
Nov 20 19:57:32 oem_default_cpu1 kernel: ata1.00: ata1: dev 0 multi
count 0
Nov 20 19:57:32 oem_default_cpu1 kernel: ata1.00: configured for
UDMA/100
Nov 20 19:57:32 oem_default_cpu1 kernel: scsi1 : sata_sil24
Nov 20 19:57:32 oem_default_cpu1 kernel: ata2: SATA link down (SStatus 0
SControl 300)
Nov 20 19:57:32 oem_default_cpu1 kernel: scsi2 : sata_sil24
Nov 20 19:57:32 oem_default_cpu1 kernel: ata3: SATA link down (SStatus 0
SControl 300)
Nov 20 19:57:32 oem_default_cpu1 kernel: scsi3 : sata_sil24
Nov 20 19:57:32 oem_default_cpu1 kernel: ata4: SATA link down (SStatus 0
SControl 300)
Nov 20 19:57:32 oem_default_cpu1 kernel:   Vendor: ATA       Model:
Hitachi HDT72503  Rev: V54O
Nov 20 19:57:32 oem_default_cpu1 kernel:   Type:   Direct-Access
ANSI SCSI revision: 05
Nov 20 19:57:32 oem_default_cpu1 kernel: SCSI device sda: 625142448
512-byte hdwr sectors (320073 MB)
Nov 20 19:57:32 oem_default_cpu1 kernel: sda: Write Protect is off
Nov 20 19:57:32 oem_default_cpu1 kernel: sda: Mode Sense: 00 3a 00 00
Nov 20 19:57:32 oem_default_cpu1 kernel: SCSI device sda: drive cache:
write back
Nov 20 19:57:32 oem_default_cpu1 kernel: SCSI device sda: 625142448
512-byte hdwr sectors (320073 MB)
Nov 20 19:57:32 oem_default_cpu1 kernel: sda: Write Protect is off
Nov 20 19:57:32 oem_default_cpu1 kernel: sda: Mode Sense: 00 3a 00 00
Nov 20 19:57:32 oem_default_cpu1 kernel: SCSI device sda: drive cache:
write back
Nov 20 19:57:32 oem_default_cpu1 kernel:  sda: sda1 sda2 sda3 sda4 <
sda5 sda6 sda7 >
Nov 20 19:57:32 oem_default_cpu1 kernel: sd 0:0:0:0: Attached scsi disk
sda
Nov 20 19:57:32 oem_default_cpu1 kernel: sd 0:0:0:0: Attached scsi
generic sg0 type 0
