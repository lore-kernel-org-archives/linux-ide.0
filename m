From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/27] libata: move ata_pci_default_filter() out of CONFIG_PCI
Date: Tue, 25 Mar 2008 22:16:42 +0900
Message-ID: <12064510262139-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:16486 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbYCYNRX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:23 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2257952wra.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:22 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

ata_pci_default_filter() doesn't really have anything to do with PCI.
It's generally applicable to BMDMA controllers.  Move it out of
CONFIG_PCI.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-sff.c |   22 +++++++++++-----------
 include/linux/libata.h   |    4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 37e7cac..add54f5 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2118,6 +2118,16 @@ void ata_std_ports(struct ata_ioports *ioaddr)
 	ioaddr->command_addr = ioaddr->cmd_addr + ATA_REG_CMD;
 }
 
+unsigned long ata_pci_default_filter(struct ata_device *adev, unsigned long xfer_mask)
+{
+	/* Filter out DMA modes if the device has been configured by
+	   the BIOS as PIO only */
+
+	if (adev->link->ap->ioaddr.bmdma_addr == NULL)
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+	return xfer_mask;
+}
+
 /**
  *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
@@ -2336,16 +2346,6 @@ int ata_pci_clear_simplex(struct pci_dev *pdev)
 	return 0;
 }
 
-unsigned long ata_pci_default_filter(struct ata_device *adev, unsigned long xfer_mask)
-{
-	/* Filter out DMA modes if the device has been configured by
-	   the BIOS as PIO only */
-
-	if (adev->link->ap->ioaddr.bmdma_addr == NULL)
-		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-	return xfer_mask;
-}
-
 /**
  *	ata_pci_init_bmdma - acquire PCI BMDMA resources and init ATA host
  *	@host: target ATA host
@@ -2726,6 +2726,7 @@ EXPORT_SYMBOL_GPL(ata_sff_port_ops);
 EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_dumb_qc_prep);
+EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_altstatus);
@@ -2761,7 +2762,6 @@ EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
-EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_pci_init_bmdma);
 EXPORT_SYMBOL_GPL(ata_pci_init_sff_host);
 EXPORT_SYMBOL_GPL(ata_pci_prepare_sff_host);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9bfc3b2..3884285 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1397,6 +1397,8 @@ extern void ata_bmdma_error_handler(struct ata_port *ap);
 extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
 extern int ata_sff_port_start(struct ata_port *ap);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
+extern unsigned long ata_pci_default_filter(struct ata_device *dev,
+					    unsigned long xfer_mask);
 extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
 extern void ata_bmdma_start(struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
@@ -1405,8 +1407,6 @@ extern void ata_bus_reset(struct ata_port *ap);
 
 #ifdef CONFIG_PCI
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
-extern unsigned long ata_pci_default_filter(struct ata_device *dev,
-					    unsigned long xfer_mask);
 extern int ata_pci_init_bmdma(struct ata_host *host);
 extern int ata_pci_init_sff_host(struct ata_host *host);
 extern int ata_pci_prepare_sff_host(struct pci_dev *pdev,
-- 
1.5.2.4

