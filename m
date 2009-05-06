From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/4] ata_piix: ICH7 does not support correct MWDMA timings
Date: Wed, 06 May 2009 17:08:44 +0100
Message-ID: <20090506160837.24191.22609.stgit@t61.ukuu.org.uk>
References: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58416 "EHLO
	t61.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759755AbZEFPK1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 May 2009 11:10:27 -0400
In-Reply-To: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

From: Alan Cox <alan@linux.intel.com>

See Errata documentation. The recommended workaround is to use PIO4 instead
which will we automatically do by flagging this mode not available.

Signed-off-by: Alan Cox <alan.cox@linux.intel.com>
---

 drivers/ata/ata_piix.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)


diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 942d14a..2b5700a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -72,6 +72,7 @@
  *	ICH2    spec c #20	- IDE PRD must not cross a 64K boundary
  *				  and must be dword aligned
  *	ICH2    spec c #24	- UDMA mode 4,5 t85/86 should be 6ns not 3.3
+ *	ICH7	errata #16	- MWDMA1 timings are incorrect
  *
  * Should have been BIOS fixed:
  *	450NX:	errata #19	- DMA hangs on old 450NX
@@ -94,7 +95,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"2.12"
+#define DRV_VERSION	"2.13"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
@@ -136,6 +137,7 @@ enum piix_controller_ids {
 	ich_pata_33,		/* ICH up to UDMA 33 only */
 	ich_pata_66,		/* ICH up to 66 Mhz */
 	ich_pata_100,		/* ICH up to UDMA 100 */
+	ich_pata_100_nomwdma1,	/* ICH up to UDMA 100 but with no MWDMA1*/
 	ich5_sata,
 	ich6_sata,
 	ich6m_sata,
@@ -216,8 +218,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	/* ICH6 (and 6) (i915) UDMA 100 */
 	{ 0x8086, 0x266F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* ICH7/7-R (i945, i975) UDMA 100*/
-	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100_nomwdma1 },
+	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100_nomwdma1 },
 	/* ICH8 Mobile PATA Controller */
 	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 
@@ -487,6 +489,15 @@ static struct ata_port_info piix_port_info[] = {
 		.port_ops	= &ich_pata_ops,
 	},
 
+	[ich_pata_100_nomwdma1] =
+	{
+		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
+		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2_ONLY,
+		.udma_mask	= ATA_UDMA5,
+		.port_ops	= &ich_pata_ops,
+	},
+
 	[ich5_sata] =
 	{
 		.flags		= PIIX_SATA_FLAGS,

