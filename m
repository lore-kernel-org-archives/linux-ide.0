From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: disable 64bit DMA by default on SB600s
Date: Sat, 03 Oct 2009 18:27:29 +0900
Message-ID: <4AC71901.6010005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53915 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131AbZJCJ0x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Oct 2009 05:26:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Shane Huang <Shane.Huang@amd.com>, stable@kernel.org, balducci@units.it, maierp@informatik.tu-muen

Till now only one board, ASUS M2A-VM, can do 64bit dma with recent
BIOSen.  Enabling 64bit DMA by default already broke three boards.
Enabling 64bit DMA isn't worth these regressions.  Disable 64bit DMA
by default and enable it only on boards which are known to work.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Gabriele Balducci <balducci@units.it>
Reported-by: maierp@informatik.tu-muenchen.de
Cc: Shane Huang <shane.huang@amd.com>
Cc: stable@kernel.org
---
 drivers/ata/ahci.c |   60 +++++++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index acd1162..c950159 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -447,7 +447,8 @@ static const struct ata_port_info ahci_port_info[] = {
 	[board_ahci_sb600] =
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
-				 AHCI_HFLAG_NO_MSI | AHCI_HFLAG_SECT255),
+				 AHCI_HFLAG_NO_MSI | AHCI_HFLAG_SECT255 |
+				 AHCI_HFLAG_32BIT_ONLY),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
@@ -2650,17 +2651,15 @@ static void ahci_p5wdh_workaround(struct ata_host *host)
 	}
 }
 
-/*
- * SB600 ahci controller on certain boards can't do 64bit DMA with
- * older BIOS.
- */
-static bool ahci_sb600_32bit_only(struct pci_dev *pdev)
+/* only some SB600 ahci controllers can do 64bit DMA */
+static bool ahci_sb600_enable_64bit(struct pci_dev *pdev)
 {
 	static const struct dmi_system_id sysids[] = {
 		/*
 		 * The oldest version known to be broken is 0901 and
 		 * working is 1501 which was released on 2007-10-26.
-		 * Force 32bit DMA on anything older than 1501.
+		 * Enable 64bit DMA on 1501 and anything newer.
+		 *
 		 * Please read bko#9412 for more info.
 		 */
 		{
@@ -2672,48 +2671,29 @@ static bool ahci_sb600_32bit_only(struct pci_dev *pdev)
 			},
 			.driver_data = "20071026",	/* yyyymmdd */
 		},
-		/*
-		 * It's yet unknown whether more recent BIOS fixes the
-		 * problem.  Blacklist the whole board for the time
-		 * being.  Please read the following thread for more
-		 * info.
-		 *
-		 * http://thread.gmane.org/gmane.linux.ide/42326
-		 */
-		{
-			.ident = "Gigabyte GA-MA69VM-S2",
-			.matches = {
-				DMI_MATCH(DMI_BOARD_VENDOR,
-					  "Gigabyte Technology Co., Ltd."),
-				DMI_MATCH(DMI_BOARD_NAME, "GA-MA69VM-S2"),
-			},
-		},
 		{ }
 	};
 	const struct dmi_system_id *match;
+	int year, month, date;
+	char buf[9];
 
 	match = dmi_first_match(sysids);
 	if (pdev->bus->number != 0 || pdev->devfn != PCI_DEVFN(0x12, 0) ||
 	    !match)
 		return false;
 
-	if (match->driver_data) {
-		int year, month, date;
-		char buf[9];
-
-		dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
-		snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
-
-		if (strcmp(buf, match->driver_data) >= 0)
-			return false;
+	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
+	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
 
+	if (strcmp(buf, match->driver_data) >= 0) {
+		dev_printk(KERN_WARNING, &pdev->dev, "%s: enabling 64bit DMA\n",
+			   match->ident);
+		return true;
+	} else {
 		dev_printk(KERN_WARNING, &pdev->dev, "%s: BIOS too old, "
 			   "forcing 32bit DMA, update BIOS\n", match->ident);
-	} else
-		dev_printk(KERN_WARNING, &pdev->dev, "%s: this board can't "
-			   "do 64bit DMA, forcing 32bit\n", match->ident);
-
-	return true;
+		return false;
+	}
 }
 
 static bool ahci_broken_system_poweroff(struct pci_dev *pdev)
@@ -2926,9 +2906,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (board_id == board_ahci_sb700 && pdev->revision >= 0x40)
 		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;
 
-	/* apply sb600 32bit only quirk */
-	if (ahci_sb600_32bit_only(pdev))
-		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
+	/* only some SB600s can do 64bit DMA */
+	if (ahci_sb600_enable_64bit(pdev))
+		hpriv->flags &= ~AHCI_HFLAG_32BIT_ONLY;
 
 	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
 		pci_intx(pdev, 1);
