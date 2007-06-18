From: Petr Janecek <janecek@ucw.cz>
Subject: pata_via.c 80w cable detection problem
Date: Mon, 18 Jun 2007 05:50:02 +0200
Message-ID: <20070618035002.GA19040@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36342 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbXFRDuE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Jun 2007 23:50:04 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
      I tried libata driver in 2.6.22-rc5 on VIA KT133A mb.
It doesn't detect the 80 wire cable (on the first port):
(via82cxxx does)

scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001d000 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001d008 irq 15
ata1.00: ata_hpa_resize 1: sectors = 156355584, hpa_sectors = 156355584
ata1.00: ATA-5: MAXTOR 6L080J4, A93.0500, max UDMA/133
ata1.00: 156355584 sectors, multi 16: LBA
ata1.00: limited to UDMA/33 due to 40-wire cable
ata1.00: ata_hpa_resize 1: sectors = 156355584, hpa_sectors = 156355584
ata1.00: configured for UDMA/33
ata2.00: ATAPI: HL-DT-ST DVDRAM GSA-H10N, JL10, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      MAXTOR 6L080J4   A93. PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156355584 512-byte hardware sectors (80054 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 156355584 512-byte hardware sectors (80054 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-H10N  JL10 PQ: 0 ANSI: 5


lspci -vnnxxx -s 00:07.1
00:07.1 IDE interface [0101]: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C
[1106:0571] PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
        [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
        [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
        [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
        I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00
40: 0b 02 09 3a 1c 10 c0 00 a8 20 a8 20 77 00 20 20
50: 03 e4 03 e4 14 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 00 d2 37 00 00 00 00 00 20 d2 37 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


In via_cable_detect(), l. 178 pci_read_config_dword(pdev, 0x50, &ata66);
reads 0xe0030303
When real 40 wire cable is used instead, it reads 0xe4030303.



Petr Janecek
