From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] IDE: compile fix for sff_dma_ops
Date: Thu, 21 Aug 2008 14:23:43 -0700
Message-ID: <1219353824-31246-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:33421 "EHLO grasse"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754855AbYHUWq6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Aug 2008 18:46:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

The sff_dma_ops struct should be wrapped by BLK_DEV_IDEDMA_SFF instead
of BLK_DEV_IDEDMA_PCI.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 include/linux/ide.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index 87c12ed..fac67e6 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1111,7 +1111,6 @@ void ide_setup_pci_noise(struct pci_dev *, const struct ide_port_info *);
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 int ide_pci_set_master(struct pci_dev *, const char *);
 unsigned long ide_pci_dma_base(ide_hwif_t *, const struct ide_port_info *);
-extern const struct ide_dma_ops sff_dma_ops;
 int ide_pci_check_simplex(ide_hwif_t *, const struct ide_port_info *);
 int ide_hwif_setup_dma(ide_hwif_t *, const struct ide_port_info *);
 #else
@@ -1122,6 +1121,10 @@ static inline int ide_hwif_setup_dma(ide_hwif_t *hwif,
 }
 #endif
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_SFF
+extern const struct ide_dma_ops sff_dma_ops;
+#endif
+
 typedef struct ide_pci_enablebit_s {
 	u8	reg;	/* byte pci reg holding the enable-bit */
 	u8	mask;	/* mask to isolate the enable-bit */
-- 
1.5.6.4

