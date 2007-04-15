From: "Rodrigo Severo" <rodrigo@fabricadeideias.com>
Subject: Fwd: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen on SATA hd
Date: Sun, 15 Apr 2007 11:08:05 -0300
Message-ID: <a7108f870704150708g741b7e2fmd52be8b53b358113@mail.gmail.com>
References: <a7108f870704150703p1f0da000k22f7b70605cec595@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:28156 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbXDOOIN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Apr 2007 10:08:13 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1209972wra
        for <linux-ide@vger.kernel.org>; Sun, 15 Apr 2007 07:08:12 -0700 (PDT)
In-Reply-To: <a7108f870704150703p1f0da000k22f7b70605cec595@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,


I have this cheap SATA addon card with an ULI chipset.

A have a linear raid over 3 disks one PATA, hda and two SATAs, sda and sdb.

When copying data to the raid device I get log messages like the following:

Apr 15 10:54:20 [kernel] ata1.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2 frozen
Apr 15 10:54:20 [kernel] ata1.00: cmd
35/00:00:df:90:0e/00:04:0b:00:00/e0 tag 0 cdb 0x0 data 524288 out
Apr 15 10:54:20 [kernel]          res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Apr 15 10:54:27 [kernel] ata1: port is slow to respond, please be
patient (Status 0xd0)
Apr 15 10:54:48 [kernel] ata1: port failed to respond (30 secs, Status 0xd0)
Apr 15 10:54:48 [kernel] ata1: soft resetting port
Apr 15 10:54:48 [kernel] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Apr 15 10:54:48 [kernel] ATA: abnormal status 0xD0 on port 0x9007
                - Last output repeated 6 times -
Apr 15 10:54:48 [kernel] ata1.00: configured for UDMA/133
Apr 15 10:54:48 [kernel] ata1: EH complete
Apr 15 10:54:48 [kernel] SCSI device sda: 488397168 512-byte hdwr
sectors (250059 MB)
Apr 15 10:54:48 [kernel] sda: Write Protect is off
Apr 15 10:54:48 [kernel] SCSI device sda: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA

All references I found to this kind of message where related to some
driver issue and not hardware problems. Can this be the case?

Some extra info on my system:

kernel:
Linux version 2.6.20.7 (root@cameron) (gcc version 4.1.1 (Gentoo
4.1.1-r3)) #1 Sun Apr 15 10:23:37 BRT 2007

lspci:
01:07.0 Mass storage controller: ALi Corporation ALi M5281 Serial ATA
/ RAID Host Controller (rev a1)
01:07.1 Mass storage controller: ALi Corporation M5228 ALi ATA/RAID
Controller (rev c6)

dmesg:
sata_uli 0000:01:07.0: version 1.0
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [APC4] -> GSI 19 (level,
high) -> IRQ 16
ata1: SATA max UDMA/133 cmd 0x9000 ctl 0x9402 bmdma 0xA000 irq 16
ata2: SATA max UDMA/133 cmd 0x9800 ctl 0x9C02 bmdma 0xA008 irq 16
scsi0 : sata_uli
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi1 : sata_uli
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3250820AS      3.AA PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6L300S0   BACE PQ: 0 ANSI: 5
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb

Please let me know if there is any extra info or tests necessary.


Regards,

Rodrigo Severo
