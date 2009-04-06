From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/07] sata_mv: workaround errata PCI#7
Date: Mon, 06 Apr 2009 15:24:14 -0400
Message-ID: <49DA56DE.3000200@rtr.ca>
References: <49DA2DFD.4010402@rtr.ca> <49DA2E33.4050704@rtr.ca> <49DA2E76.7000800@rtr.ca> <49DA566D.9040501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33189 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756750AbZDFTYQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 15:24:16 -0400
In-Reply-To: <49DA566D.9040501@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Saeed Bishara <saeed@marvell.com>

Workaround for 60x1-B2 errata PCI#7.

Write-combining may be unreliable when chip operates in PCI-X mode,
so disable write-combining when in PCI-X mode.

Also, update the errata comments at the top of sata_mv,
and include a note about errata PCI#11.

Signed-off-by: Mark Lord <mlord@pobox.com>
--

Expanding the original 3-part patch series to 7-parts now.


--- old/drivers/ata/sata_mv.c	2009-04-06 12:23:32.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-06 13:24:28.000000000 -0400
@@ -28,10 +28,6 @@
 /*
  * sata_mv TODO list:
  *
- * --> More errata workarounds for PCI-X.
- *
- * --> Complete a full errata audit for all chipsets to identify others.
- *
  * --> Develop a low-power-consumption strategy, and implement it.
  *
  * --> Add sysfs attributes for per-chip / per-HC IRQ coalescing thresholds.
@@ -44,6 +40,15 @@
  *       connect two SATA ports.
  */
 
+/*
+ * 80x1-B2 errata PCI#11:
+ *
+ * Users of the 6041/6081 Rev.B2 chips (current is C0)
+ * should be careful to insert those cards only onto PCI-X bus #0,
+ * and only in device slots 0..7, not higher.  The chips may not
+ * work correctly otherwise  (note: this is a pretty rare condition).
+ */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -181,6 +186,7 @@
 	/* PCI interface registers */
 
 	PCI_COMMAND_OFS		= 0xc00,
+	PCI_COMMAND_MWRCOM	= (1 << 4),	/* PCI Master Write Combining */
 	PCI_COMMAND_MRDTRIG	= (1 << 7),	/* PCI Master Read Trigger */
 
 	PCI_MAIN_CMD_STS_OFS	= 0xd30,
@@ -3527,6 +3533,18 @@
 	return 1; /* okay */
 }
 
+static void mv_60x1b2_errata_pci7(struct ata_host *host)
+{
+	struct mv_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->base;
+
+	/* workaround for 60x1-B2 errata PCI#7 */
+	if (mv_in_pcix_mode(host)) {
+		u32 reg = readl(mmio + PCI_COMMAND_OFS);
+		writelfl(reg & ~PCI_COMMAND_MWRCOM, mmio + PCI_COMMAND_OFS);
+	}
+}
+
 static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
@@ -3580,6 +3598,7 @@
 
 		switch (pdev->revision) {
 		case 0x7:
+			mv_60x1b2_errata_pci7(host);
 			hp_flags |= MV_HP_ERRATA_60X1B2;
 			break;
 		case 0x9:
