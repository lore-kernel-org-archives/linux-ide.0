From: Mark Paulus <mark.paulus@verizonbusiness.com>
Subject: problem with sata_nv and SATA<>PATA bridge (2.6.18/2.6.24)
Date: Fri, 30 May 2008 08:10:59 -0600
Message-ID: <g1p1tl$pas$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41809 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbYE3OaI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 10:30:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K25cI-0005LK-Cg
	for linux-ide@vger.kernel.org; Fri, 30 May 2008 14:30:02 +0000
Received: from xs117v6225578.vzbi.com ([166.34.132.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 30 May 2008 14:30:02 +0000
Received: from mark.paulus by xs117v6225578.vzbi.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 30 May 2008 14:30:02 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have a motherboard with Nvidia sata and
SIL3512 sata controllers.  I also have a 
brand spanking new 320GB IDE drive that I am
connecting to the mobo via a SATA<>PATA
bridge.  This combo is giving me fits with
the NV controller, but seems to work fine
with the SIL sata controller.

I had this problem on 2.6.22 on the Sil side,
but Tejun found the issue and created a patch.

The action I was trying to accomplish was:
mkfs.jfs -c /dev/sdb1.

Here are the messages from my messages
file:
May 27 16:42:45 storage1 kernel: ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 177
May 27 16:42:45 storage1 kernel: ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 177
May 27 16:42:45 storage1 kernel: scsi0 : sata_nv
May 27 16:42:45 storage1 kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:42:45 storage1 kernel: ata1.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth 0/32)
May 27 16:42:45 storage1 kernel: ata1.00: ata1: dev 0 multi count 16
May 27 16:42:45 storage1 kernel: ata1.00: configured for UDMA/133
May 27 16:42:45 storage1 kernel: scsi1 : sata_nv
May 27 16:42:45 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:42:45 storage1 kernel: ata2.00: ATA-8, max UDMA/100, 625142448 sectors: LBA48
May 27 16:42:45 storage1 kernel: ata2.00: ata2: dev 0 multi count 16
May 27 16:42:45 storage1 kernel: ata2.00: configured for UDMA/100
May 27 16:42:45 storage1 kernel:   Vendor: ATA       Model: HDT722516DLA380   Rev: V43O
May 27 16:42:45 storage1 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
May 27 16:42:45 storage1 kernel:   Vendor: ATA       Model: WDC WD3200AAJB-0  Rev: 00.0
May 27 16:42:45 storage1 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
May 27 16:42:45 storage1 kernel: ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
May 27 16:42:45 storage1 kernel: GSI 19 sharing vector 0xC9 and IRQ 19
May 27 16:42:45 storage1 kernel: ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 201
May 27 16:42:45 storage1 kernel: skge 1.6 addr 0xf5000000 irq 201 chip Yukon-Lite rev 9
May 27 16:42:45 storage1 kernel: skge eth0: addr 00:0f:ea:85:73:1c
May 27 16:42:45 storage1 kernel: ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
May 27 16:42:45 storage1 kernel: GSI 20 sharing vector 0xD1 and IRQ 20
May 27 16:42:45 storage1 kernel: ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 209
May 27 16:42:45 storage1 kernel: ata3: SATA max UDMA/100 cmd 0xFFFFC2000001A080 ctl 0xFFFFC2000001A08A bmdma 0xFFFFC2000001A000 irq 209
May 27 16:42:45 storage1 kernel: ata4: SATA max UDMA/100 cmd 0xFFFFC2000001A0C0 ctl 0xFFFFC2000001A0CA bmdma 0xFFFFC2000001A008 irq 209
May 27 16:42:45 storage1 kernel: scsi2 : sata_sil
May 27 16:42:45 storage1 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
May 27 16:42:45 storage1 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 27 16:42:45 storage1 kernel: ata3: SATA link down (SStatus 0 SControl 310) 
May 27 16:42:45 storage1 kernel: scsi3 : sata_sil
May 27 16:42:45 storage1 kernel: ata4: SATA link down (SStatus 0 SControl 310)
May 27 16:42:45 storage1 kernel: NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
May 27 16:42:45 storage1 kernel: NFORCE3-250: chipset revision 162
May 27 16:42:45 storage1 kernel: NFORCE3-250: not 100%% native mode: will probe irqs later
May 27 16:42:45 storage1 kernel: NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
May 27 16:42:45 storage1 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
May 27 16:42:45 storage1 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
May 27 16:42:45 storage1 kernel: SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
May 27 16:42:45 storage1 kernel: sda: Write Protect is off
May 27 16:42:45 storage1 kernel: SCSI device sda: drive cache: write back
May 27 16:42:45 storage1 kernel: SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
May 27 16:42:45 storage1 kernel: sda: Write Protect is off
May 27 16:42:45 storage1 kernel: SCSI device sda: drive cache: write back
May 27 16:42:45 storage1 kernel:  sda: sda1 sda2 < sda5 > sda3
May 27 16:42:45 storage1 kernel: sd 0:0:0:0: Attached scsi disk sda
May 27 16:42:45 storage1 kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
May 27 16:42:45 storage1 kernel: sdb: Write Protect is off
May 27 16:42:45 storage1 kernel: SCSI device sdb: drive cache: write back
May 27 16:42:45 storage1 kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
May 27 16:42:45 storage1 kernel: sdb: Write Protect is off
May 27 16:42:45 storage1 kernel: SCSI device sdb: drive cache: write back
May 27 16:42:45 storage1 kernel:  sdb: unknown partition table
May 27 16:42:45 storage1 kernel: sd 1:0:0:0: Attached scsi disk sdb

May 27 16:42:51 storage1 kernel: NFSD: starting 90-second grace period
May 27 16:47:50 storage1 kernel: ata2: EH complete
May 27 16:47:50 storage1 kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
May 27 16:47:50 storage1 kernel: sdb: Write Protect is off
May 27 16:47:50 storage1 kernel: SCSI device sdb: drive cache: write back
May 27 16:47:53 storage1 kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
May 27 16:47:53 storage1 kernel: sdb: Write Protect is off
May 27 16:47:53 storage1 kernel: SCSI device sdb: drive cache: write back
May 27 16:47:53 storage1 kernel:  sdb: sdb1
May 27 16:49:43 storage1 kernel: ata2: port is slow to respond, please be patient
May 27 16:50:06 storage1 kernel: ata2: soft resetting port
May 27 16:50:06 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:50:06 storage1 kernel: ata2.00: configured for UDMA/100
May 27 16:50:06 storage1 kernel: ata2: EH complete
May 27 16:50:43 storage1 kernel: ata2: port is slow to respond, please be patient
May 27 16:51:06 storage1 kernel: ata2: soft resetting port
May 27 16:51:06 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:51:06 storage1 kernel: ata2.00: configured for UDMA/100
May 27 16:51:06 storage1 kernel: ata2: EH complete
May 27 16:51:44 storage1 kernel: ata2: port is slow to respond, please be patient
May 27 16:52:07 storage1 kernel: ata2: soft resetting port
May 27 16:52:07 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:52:07 storage1 kernel: ata2.00: configured for UDMA/100
May 27 16:52:07 storage1 kernel: ata2: EH complete
May 27 16:52:37 storage1 kernel: ata2.00: limiting speed to UDMA/66
May 27 16:52:44 storage1 kernel: ata2: port is slow to respond, please be patient
May 27 16:53:07 storage1 kernel: ata2: soft resetting port
May 27 16:53:07 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:53:07 storage1 kernel: ata2.00: configured for UDMA/66
May 27 16:53:07 storage1 kernel: ata2: EH complete
May 27 16:53:37 storage1 kernel: ata2.00: limiting speed to UDMA/44
May 27 16:53:45 storage1 kernel: ata2: port is slow to respond, please be patient
May 27 16:54:08 storage1 kernel: ata2: soft resetting port
May 27 16:54:08 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:54:08 storage1 kernel: ata2.00: configured for UDMA/44
May 27 16:54:08 storage1 kernel: ata2: EH complete
May 27 16:54:38 storage1 kernel: ata2.00: limiting speed to UDMA/33
May 27 16:54:45 storage1 kernel: ata2: port is slow to respond, please be patient
May 27 16:55:08 storage1 kernel: ata2: soft resetting port
May 27 16:55:08 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:55:08 storage1 kernel: ata2.00: configured for UDMA/33
May 27 16:55:08 storage1 kernel: ata2: EH complete
May 27 16:55:38 storage1 kernel: ata2.00: limiting speed to UDMA/25
May 27 16:55:46 storage1 kernel: ata2: port is slow to respond, please be patient
May 27 16:56:02 storage1 shutdown[3403]: shutting down for system reboot
May 27 16:56:09 storage1 kernel: ata2: soft resetting port
May 27 16:56:09 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:56:09 storage1 kernel: ata2.00: configured for UDMA/25
May 27 16:56:09 storage1 kernel: ata2: EH complete
May 27 16:56:09 storage1 kernel: sd 1:0:0:0: SCSI error: return code = 0x08000002
May 27 16:56:09 storage1 kernel: sdb: Current: sense key: Aborted Command
May 27 16:56:09 storage1 kernel:     Additional sense: No additional sense information
May 27 16:56:09 storage1 kernel: end_request: I/O error, dev sdb, sector 76607
May 27 16:56:09 storage1 kernel: lost page write due to I/O error on sdb1
May 27 16:56:09 storage1 last message repeated 9 times
May 27 16:56:09 storage1 kernel: ata2: EH complete
May 27 16:56:09 storage1 kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
May 27 16:56:39 storage1 kernel: ata2.00: limiting speed to UDMA/16
May 27 16:56:46 storage1 kernel: ata2: port is slow to respond, please be patient
May 27 16:57:09 storage1 kernel: ata2: soft resetting port
May 27 16:57:09 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:57:09 storage1 kernel: ata2.00: configured for UDMA/16
May 27 16:57:09 storage1 kernel: ata2: EH complete
May 27 16:57:39 storage1 kernel: ata2.00: limiting speed to PIO4
May 27 16:57:47 storage1 kernel: ata2: port is slow to respond, please be patient
May 27 16:58:10 storage1 kernel: ata2: soft resetting port
May 27 16:58:10 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:58:10 storage1 kernel: ata2.00: configured for PIO4
May 27 16:58:10 storage1 kernel: ata2: EH complete
May 27 16:58:10 storage1 kernel: ata2.00: limiting speed to PIO3
May 27 16:58:10 storage1 kernel: ata2: soft resetting port
May 27 16:58:10 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:58:10 storage1 kernel: ata2.00: configured for PIO3
May 27 16:58:10 storage1 kernel: ata2: EH complete
May 27 16:58:10 storage1 kernel: ata2.00: limiting speed to PIO2
May 27 16:58:11 storage1 kernel: ata2: soft resetting port
May 27 16:58:11 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:58:11 storage1 kernel: ata2.00: configured for PIO2
May 27 16:58:11 storage1 kernel: ata2: EH complete
May 27 16:58:11 storage1 kernel: ata2.00: limiting speed to PIO1
May 27 16:58:11 storage1 kernel: ata2: soft resetting port
May 27 16:58:11 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:58:11 storage1 kernel: ata2.00: configured for PIO1
May 27 16:58:11 storage1 kernel: ata2: EH complete
May 27 16:58:11 storage1 kernel: ata2.00: limiting speed to PIO0
May 27 16:58:11 storage1 kernel: ata2: soft resetting port
May 27 16:58:12 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:58:12 storage1 kernel: ata2.00: configured for PIO0
May 27 16:58:12 storage1 kernel: sd 1:0:0:0: SCSI error: return code = 0x08000002
May 27 16:58:12 storage1 kernel: sdb: Current: sense key: Aborted Command
May 27 16:58:12 storage1 kernel:     Additional sense: No additional sense information
May 27 16:58:12 storage1 kernel: end_request: I/O error, dev sdb, sector 625071815
May 27 16:58:12 storage1 kernel: printk: 38 messages suppressed.
May 27 16:58:12 storage1 kernel: lost page write due to I/O error on sdb1
May 27 16:58:12 storage1 last message repeated 9 times
May 27 16:58:12 storage1 kernel: ata2: EH complete
May 27 16:58:12 storage1 kernel: sdb: Write Protect is off
May 27 16:58:12 storage1 kernel: ata2: soft resetting port
May 27 16:58:12 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:58:12 storage1 kernel: ata2.00: configured for PIO0
May 27 16:58:12 storage1 kernel: ata2: EH complete
May 27 16:58:12 storage1 kernel: ata2: soft resetting port
May 27 16:58:13 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:58:13 storage1 kernel: ata2.00: configured for PIO0
May 27 16:58:13 storage1 kernel: ata2: EH complete
May 27 16:58:13 storage1 kernel: ata2: soft resetting port
May 27 16:58:13 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:58:13 storage1 kernel: ata2.00: configured for PIO0
May 27 16:58:13 storage1 kernel: ata2: EH complete
May 27 16:58:13 storage1 kernel: ata2: soft resetting port
May 27 16:58:14 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 27 16:58:14 storage1 kernel: ata2.00: configured for PIO0
May 27 16:58:14 storage1 kernel: ata2: EH complete
May 27 16:58:14 storage1 kernel: ata2: soft resetting port
May 27 16:58:14 storage1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

and so on
and
so
on
ad nauseum

