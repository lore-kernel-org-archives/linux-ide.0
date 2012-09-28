From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] ATA: sata_mv: Fix warnings when no PCI
Date: Fri, 28 Sep 2012 17:04:10 +0200
Message-ID: <1348844650-2957-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:34410 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932148Ab2I1PEW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2012 11:04:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Dove can be configured with PCI. We then get a number of warnings:

warning: 'msi' defined but not used
warning: 'mv5_sht' defined but not used
warning: 'mv_dump_pci_cfg' defined but not used.

Move around variables and add #ifdef as necassary to fix the warnings.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/ata/sata_mv.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 311be18..68f4fb5 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -79,8 +79,8 @@
  * module options
  */
 
-static int msi;
 #ifdef CONFIG_PCI
+static int msi;
 module_param(msi, int, S_IRUGO);
 MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
 #endif
@@ -652,12 +652,13 @@ static u8 mv_sff_check_status(struct ata_port *ap);
  * because we have to allow room for worst case splitting of
  * PRDs for 64K boundaries in mv_fill_sg().
  */
+#ifdef CONFIG_PCI
 static struct scsi_host_template mv5_sht = {
 	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
 	.dma_boundary		= MV_DMA_BOUNDARY,
 };
-
+#endif
 static struct scsi_host_template mv6_sht = {
 	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= MV_MAX_Q_DEPTH - 1,
@@ -1252,7 +1253,7 @@ static void mv_dump_mem(void __iomem *start, unsigned bytes)
 	}
 }
 #endif
-
+#if defined(ATA_DEBUG) || defined(CONFIG_PCI)
 static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
 {
 #ifdef ATA_DEBUG
@@ -1269,6 +1270,7 @@ static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
 	}
 #endif
 }
+#endif
 static void mv_dump_all_regs(void __iomem *mmio_base, int port,
 			     struct pci_dev *pdev)
 {
-- 
1.7.10.4

