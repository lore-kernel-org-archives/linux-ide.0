From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.4.x libata update
Date: Thu, 6 Jan 2005 23:38:20 -0500
Message-ID: <20050107043820.GA11858@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([63.115.148.101]:36488 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261236AbVAGEiW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2005 23:38:22 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ide@vger.kernel.org


Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.4

This will update the following files:

 drivers/scsi/ahci.c     |    8 ++++++--
 drivers/scsi/ata_piix.c |   15 +++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

through these ChangeSets:

<jason.d.gaston@intel.com> (05/01/06 1.1547)
   [PATCH] SATA support for Intel ICH7
     
   Reposting patch with word wrap turned off.  Please let me know if
   this is still not formated correctly.
     
   This patch adds the Intel ICH7 DID's to the ata_piix.c SATA driver, ahci.c SATA
   AHCI driver and quirks.c for ICH7 SATA support.
   
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-01-06 23:37:31 -05:00
+++ b/drivers/scsi/ahci.c	2005-01-06 23:37:31 -05:00
@@ -241,9 +241,13 @@
 
 static struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },
+	  board_ahci }, /* ICH6 */
 	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },
+	  board_ahci }, /* ICH6M */
+	{ PCI_VENDOR_ID_INTEL, 0x27c1, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7 */
+	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7M */
 	{ }	/* terminate list */
 };
 
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2005-01-06 23:37:31 -05:00
+++ b/drivers/scsi/ata_piix.c	2005-01-06 23:37:31 -05:00
@@ -60,6 +60,7 @@
 	piix4_pata		= 2,
 	ich6_sata		= 3,
 	ich6_sata_rm		= 4,
+	ich7_sata		= 5,
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -90,6 +91,8 @@
 	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
 	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
 	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
+	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 
 	{ }	/* terminate list */
 };
@@ -227,6 +230,18 @@
 	},
 
 	/* ich6_sata_rm */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
+				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
+				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
+
+	/* ich7_sata */
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
