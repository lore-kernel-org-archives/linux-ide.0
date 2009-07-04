From: Zdenek Kaspar <zkaspar82@gmail.com>
Subject: AHCI: connection status changed + hard resetting link with 2.6.30+
Date: Sun, 05 Jul 2009 00:02:10 +0200
Message-ID: <4A4FD162.30604@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040808070201030400090506"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:62750 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbZGDWCN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Jul 2009 18:02:13 -0400
Received: by bwz25 with SMTP id 25so57847bwz.37
        for <linux-ide@vger.kernel.org>; Sat, 04 Jul 2009 15:02:15 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040808070201030400090506
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Hi, when booted latest -stable kernel (2.6.30.1) got this in dmesg:

[    1.521856] ata8: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[    1.521908] ata8: irq_stat 0x00400040, connection status changed
[    1.521962] ata8: hard resetting link

Same result with 2.6.31-rc2, with 2.6.29.6 it works OK.

Could this cause any trouble ?

TIA, Z.




--------------040808070201030400090506
Content-Type: text/plain;
 name="dmesg-excerptions-2.6.31-rc2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-excerptions-2.6.31-rc2"

[    1.004429] ahci 0000:00:1f.2: version 3.0
[    1.004437]   alloc irq_desc for 19 on node 0
[    1.004439]   alloc kstat_irqs on node 0
[    1.004442] ahci 0000:00:1f.2: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.004513]   alloc irq_desc for 28 on node 0
[    1.004515]   alloc kstat_irqs on node 0
[    1.004522] ahci 0000:00:1f.2: irq 28 for MSI/MSI-X
[    1.004573] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl SATA mode
[    1.004641] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part ems 
[    1.004706] ahci 0000:00:1f.2: setting latency timer to 64
[    1.060086] scsi2 : ahci
[    1.060536] scsi3 : ahci
[    1.060918] scsi4 : ahci
[    1.061311] scsi5 : ahci
[    1.061717] scsi6 : ahci
[    1.062141] scsi7 : ahci
[    1.062287] ata3: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221100 irq 28
[    1.062352] ata4: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221180 irq 28
[    1.062416] ata5: DUMMY
[    1.062455] ata6: DUMMY
[    1.062494] ata7: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221300 irq 28
[    1.062558] ata8: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221380 irq 28

...

[    1.411284] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.411353] ata4: SATA link down (SStatus 0 SControl 300)
[    1.412138] ata3.00: ATA-8: WDC WD2502ABYS-01B7A0, 02.03B02, max UDMA/133
[    1.412192] ata3.00: 490350672 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.413221] ata3.00: configured for UDMA/133
[    1.413351] scsi 2:0:0:0: Direct-Access     ATA      WDC WD2502ABYS-0 02.0 PQ: 0 ANSI: 5
[    1.421264] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.430076] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.463476] ata8.00: ATA-7: ST3400620NS, 3.AEG, max UDMA/133
[    1.463527] ata8.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.476751] ata7.00: ATA-7: ST3400620NS, 3.AEG, max UDMA/133
[    1.476801] ata7.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.521804] ata8.00: configured for UDMA/133
[    1.521856] ata8: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[    1.521908] ata8: irq_stat 0x00400040, connection status changed
[    1.521962] ata8: hard resetting link
[    1.535080] ata7.00: configured for UDMA/133
[    1.535132] ata7: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[    1.535183] ata7: irq_stat 0x00400040, connection status changed
[    1.535237] ata7: hard resetting link
[    2.270032] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.280074] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.363041] ata8.00: configured for UDMA/133
[    2.363088] ata8: EH complete
[    2.368005] ata7.00: configured for UDMA/133
[    2.368051] ata7: EH complete

--------------040808070201030400090506--
