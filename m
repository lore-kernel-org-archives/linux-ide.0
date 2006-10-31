From: "Rune Torgersen" <runet@innovsys.com>
Subject: SATA HSM error
Date: Tue, 31 Oct 2006 16:53:13 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DFF9@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.innovsys.com ([66.115.232.196]:6883 "EHLO
	mail.innovsys.com") by vger.kernel.org with ESMTP id S1423787AbWJaWxO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 17:53:14 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

I get the followin gerros once in a while on 2.6.18, running on a
Freescale 8260 PPC.
The controller is  Silicon Image SiI3124 , and the drive a seagate
NL35.2 drive

Any idea if this is hardware or software?


ata2: illegal qc_active transition (00000002->000001f8)
ata2.00: exception Emask 0x2 SAct 0x2 SErr 0x0 action 0x2 frozen
ata2.00: tag 1 cmd 0x61 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/100
ata2: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back


kernel startup msg:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ata1: SATA max UDMA/100 cmd 0xE1060000 ctl 0x0 bmdma 0x0 irq 69
ata2: SATA max UDMA/100 cmd 0xE1062000 ctl 0x0 bmdma 0x0 irq 69
ata3: SATA max UDMA/100 cmd 0xE1064000 ctl 0x0 bmdma 0x0 irq 69
ata4: SATA max UDMA/100 cmd 0xE1066000 ctl 0x0 bmdma 0x0 irq 69
scsi0 : sata_sil24
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_sil24
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/100
scsi2 : sata_sil24
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_sil24
ata4: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: ST3250624NS       Rev: 3.AE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0

>lspci -v -s 0:11
00:11.0 Unknown mass storage controller: CMD Technology Inc: Unknown
device 3124 (rev 01)
        Subsystem: CMD Technology Inc: Unknown device 3124
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 128,
IRQ 69
        Memory at 97ffff80 (64-bit, non-prefetchable) [size=128]
        Memory at 97ff0000 (64-bit, non-prefetchable) [size=32K]
        I/O ports at 9800fff0 [size=16]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [64] Power Management version 2
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [54] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
