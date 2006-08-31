From: "David Wang" <touch@sis.com>
Subject: [PATCH] libata: support for SiS AHCI controller in SiS966/SiS968
Date: Thu, 31 Aug 2006 17:56:36 +0800
Message-ID: <OFD4641DBA.8DD06DEC-ON482571DB.00364E08@sis.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sism02.sis.com ([203.67.208.23]:8878 "EHLO sism02.sis.com")
	by vger.kernel.org with ESMTP id S1751388AbWHaJx0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Aug 2006 05:53:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "inux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi all,
My name is David Wang, working for SiS now.
This is my first try to post mail here.

This patch, against 2.6.17.11, adds support for SiS AHCI controller.
Device IDs, 0x1184 and 0x1185 are 1.5Gbps AHCI in SiS966 south bridge.
Device ID 0x0186 is 3Gbps AHCI in next SiS968.

While I load the driver, dmesg gives:
ahci 0000:00:05.0: version 1.2
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKB] -> GSI 11 (level, low) ->
IR
ahci 0000:00:05.0: AHCI 0001.0000 32 slots 2 ports 1.5 Gbps 0x3 impl RAID
mode
ahci 0000:00:05.0: flags: ncq ilck led clo pmp pio slum part
ata3: SATA max UDMA/133 cmd 0xF8806900 ctl 0x0 bmdma 0x0 irq 11
ata4: SATA max UDMA/133 cmd 0xF8806980 ctl 0x0 bmdma 0x0 irq 11
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3c01 87:4763
88:007f
ata3: dev 0 ATA-7, max UDMA/133, 160836480 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci
  Vendor: ATA       Model: HDS728080PLA380   Rev: PF2O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)

It seems running well with my several SATA devices.
If you need more information about the hardware or request a motherboard for
testing,
Contact me or Hank lee (mlee08@sis.com).

Signed-off-by: David Wang <touch@sis.com >
---
diff -up a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c       2006-08-24 05:16:33.000000000 +0800
+++ b/drivers/scsi/ahci.c       2006-08-31 16:36:03.000000000 +0800
@@ -296,6 +296,12 @@
          board_ahci }, /* ATI SB600 non-raid */
        { PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_ahci }, /* ATI SB600 raid */
+       { PCI_VENDOR_ID_SI, 0x1184, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_ahci }, /* SiS 966, 1184 RAID */
+       { PCI_VENDOR_ID_SI, 0x1185, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_ahci }, /* SiS 966, 1185 AHCI */
+       { PCI_VENDOR_ID_SI, 0x0186, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_ahci }, /* SiS 968, 186 AHCI 3Gbps */
        { }     /* terminate list */
 };

