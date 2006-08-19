From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 20/20] libata: move scattered PCI ATA functions into liata-pci.c
Date: Sat, 19 Aug 2006 17:59:34 +0900
Message-ID: <11559779743118-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:35163 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751676AbWHSJ1k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 05:27:40 -0400
Received: by py-out-1112.google.com with SMTP id n25so1477492pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 02:27:40 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move remaining PCI ATA functions in libata-bmdma.c and libata-core.c
into libata-pci.c

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-bmdma.c |   40 ---------------
 drivers/ata/libata-core.c  |   89 ---------------------------------
 drivers/ata/libata-pci.c   |  117 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 129 deletions(-)

diff --git a/drivers/ata/libata-bmdma.c b/drivers/ata/libata-bmdma.c
index b8b393f..66f935a 100644
--- a/drivers/ata/libata-bmdma.c
+++ b/drivers/ata/libata-bmdma.c
@@ -444,43 +444,3 @@ void ata_bmdma_post_internal_cmd(struct 
 {
 	ata_bmdma_stop(qc);
 }
-
-#ifdef CONFIG_PCI
-/**
- *	ata_pci_clear_simplex	-	attempt to kick device out of simplex
- *	@pdev: PCI device
- *
- *	Some PCI ATA devices report simplex mode but in fact can be told to
- *	enter non simplex mode. This implements the neccessary logic to
- *	perform the task on such devices. Calling it on other devices will
- *	have -undefined- behaviour.
- */
-
-int ata_pci_clear_simplex(struct pci_dev *pdev)
-{
-	unsigned long bmdma = pci_resource_start(pdev, 4);
-	u8 simplex;
-
-	if (bmdma == 0)
-		return -ENOENT;
-
-	simplex = inb(bmdma + 0x02);
-	outb(simplex & 0x60, bmdma + 0x02);
-	simplex = inb(bmdma + 0x02);
-	if (simplex & 0x80)
-		return -EOPNOTSUPP;
-	return 0;
-}
-
-unsigned long ata_pci_default_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long xfer_mask)
-{
-	/* Filter out DMA modes if the device has been configured by
-	   the BIOS as PIO only */
-
-	if (ap->ioaddr.bmdma_addr == 0)
-		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-	return xfer_mask;
-}
-
-#endif /* CONFIG_PCI */
-
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d3597c7..b97b09e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6024,85 +6024,6 @@ void ata_std_ports(struct ata_ioports *i
 	ioaddr->command_addr = ioaddr->cmd_addr + ATA_REG_CMD;
 }
 
-
-#ifdef CONFIG_PCI
-/* move to PCI subsystem */
-int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
-{
-	unsigned long tmp = 0;
-
-	switch (bits->width) {
-	case 1: {
-		u8 tmp8 = 0;
-		pci_read_config_byte(pdev, bits->reg, &tmp8);
-		tmp = tmp8;
-		break;
-	}
-	case 2: {
-		u16 tmp16 = 0;
-		pci_read_config_word(pdev, bits->reg, &tmp16);
-		tmp = tmp16;
-		break;
-	}
-	case 4: {
-		u32 tmp32 = 0;
-		pci_read_config_dword(pdev, bits->reg, &tmp32);
-		tmp = tmp32;
-		break;
-	}
-
-	default:
-		return -EINVAL;
-	}
-
-	tmp &= bits->mask;
-
-	return (tmp == bits->val) ? 1 : 0;
-}
-
-void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
-{
-	pci_save_state(pdev);
-
-	if (mesg.event == PM_EVENT_SUSPEND) {
-		pci_disable_device(pdev);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
-}
-
-void ata_pci_device_do_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	pci_enable_device(pdev);
-	pci_set_master(pdev);
-}
-
-int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	int rc = 0;
-
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
-
-	ata_pci_device_do_suspend(pdev, mesg);
-
-	return 0;
-}
-
-int ata_pci_device_resume(struct pci_dev *pdev)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-
-	ata_pci_device_do_resume(pdev);
-	ata_host_resume(host);
-	return 0;
-}
-#endif /* CONFIG_PCI */
-
-
 static int __init ata_init(void)
 {
 	ata_probe_timeout *= HZ;
@@ -6329,16 +6250,6 @@ EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 EXPORT_SYMBOL_GPL(ata_timing_compute);
 EXPORT_SYMBOL_GPL(ata_timing_merge);
 
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
-EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
-EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
-EXPORT_SYMBOL_GPL(ata_pci_device_resume);
-EXPORT_SYMBOL_GPL(ata_pci_default_filter);
-EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
-#endif /* CONFIG_PCI */
-
 EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
 
diff --git a/drivers/ata/libata-pci.c b/drivers/ata/libata-pci.c
index d3f619c..9bf41d6 100644
--- a/drivers/ata/libata-pci.c
+++ b/drivers/ata/libata-pci.c
@@ -37,6 +37,65 @@ #include <linux/libata.h>
 
 #include "libata.h"
 
+/* move to PCI subsystem */
+int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
+{
+	unsigned long tmp = 0;
+
+	switch (bits->width) {
+	case 1: {
+		u8 tmp8 = 0;
+		pci_read_config_byte(pdev, bits->reg, &tmp8);
+		tmp = tmp8;
+		break;
+	}
+	case 2: {
+		u16 tmp16 = 0;
+		pci_read_config_word(pdev, bits->reg, &tmp16);
+		tmp = tmp16;
+		break;
+	}
+	case 4: {
+		u32 tmp32 = 0;
+		pci_read_config_dword(pdev, bits->reg, &tmp32);
+		tmp = tmp32;
+		break;
+	}
+
+	default:
+		return -EINVAL;
+	}
+
+	tmp &= bits->mask;
+
+	return (tmp == bits->val) ? 1 : 0;
+}
+
+/**
+ *	ata_pci_clear_simplex	-	attempt to kick device out of simplex
+ *	@pdev: PCI device
+ *
+ *	Some PCI ATA devices report simplex mode but in fact can be told to
+ *	enter non simplex mode. This implements the neccessary logic to
+ *	perform the task on such devices. Calling it on other devices will
+ *	have -undefined- behaviour.
+ */
+int ata_pci_clear_simplex(struct pci_dev *pdev)
+{
+	unsigned long bmdma = pci_resource_start(pdev, 4);
+	u8 simplex;
+
+	if (bmdma == 0)
+		return -ENOENT;
+
+	simplex = inb(bmdma + 0x02);
+	outb(simplex & 0x60, bmdma + 0x02);
+	simplex = inb(bmdma + 0x02);
+	if (simplex & 0x80)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 /**
  *	ata_pci_legacy_mask - obatin legacy mask from PCI IDE device
  *	@pdev: target PCI device
@@ -685,6 +744,59 @@ void ata_pci_remove_one(struct pci_dev *
 	ata_pci_host_destroy(host);
 }
 
+unsigned long ata_pci_default_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long xfer_mask)
+{
+	/* Filter out DMA modes if the device has been configured by
+	   the BIOS as PIO only */
+
+	if (ap->ioaddr.bmdma_addr == 0)
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+	return xfer_mask;
+}
+
+void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+	pci_save_state(pdev);
+
+	if (mesg.event == PM_EVENT_SUSPEND) {
+		pci_disable_device(pdev);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+}
+
+void ata_pci_device_do_resume(struct pci_dev *pdev)
+{
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_device(pdev);
+	pci_set_master(pdev);
+}
+
+int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc = 0;
+
+	rc = ata_host_suspend(host, mesg);
+	if (rc)
+		return rc;
+
+	ata_pci_device_do_suspend(pdev, mesg);
+
+	return 0;
+}
+
+int ata_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+
+	ata_pci_device_do_resume(pdev);
+	ata_host_resume(host);
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(pci_test_config_bits);
+EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 EXPORT_SYMBOL_GPL(ata_pci_legacy_mask);
 EXPORT_SYMBOL_GPL(ata_pci_set_dma_mask);
 EXPORT_SYMBOL_GPL(ata_pci_acquire_resources);
@@ -698,3 +810,8 @@ EXPORT_SYMBOL_GPL(ata_pci_host_prepare);
 EXPORT_SYMBOL_GPL(ata_pci_host_destroy);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+EXPORT_SYMBOL_GPL(ata_pci_default_filter);
+EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
+EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
+EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
+EXPORT_SYMBOL_GPL(ata_pci_device_resume);
-- 
1.4.1.1


