From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/17] libata: kill unused ->host_stop() operation and related functions
Date: Mon, 7 Aug 2006 12:04:01 +0900
Message-ID: <11549198413242-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:36166 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750958AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855408pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:13 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that ata_port_operations->host_stop() is replaced by
pci_driver->remove_one(), kill the method and related functions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   19 +------------------
 include/linux/libata.h     |    4 ----
 2 files changed, 1 insertions(+), 22 deletions(-)

db0ca25f110082290e507ad3a26cbe44677cbdda
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 2350c34..f944ca0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5161,12 +5161,6 @@ void ata_port_stop (struct ata_port *ap)
 	ata_pad_free(ap, dev);
 }
 
-void ata_host_stop (struct ata_host_set *host_set)
-{
-	if (host_set->mmio_base)
-		iounmap(host_set->mmio_base);
-}
-
 /**
  *	ata_dev_init - Initialize an ata_device structure
  *	@dev: Device structure to initialize
@@ -5902,13 +5896,6 @@ void ata_std_ports(struct ata_ioports *i
 
 #ifdef CONFIG_PCI
 
-void ata_pci_host_stop (struct ata_host_set *host_set)
-{
-	struct pci_dev *pdev = to_pci_dev(host_set->dev);
-
-	pci_iounmap(pdev, host_set->mmio_base);
-}
-
 /**
  *	ata_pci_remove_one - PCI layer callback for device removal
  *	@pdev: PCI device that was removed
@@ -5930,9 +5917,7 @@ void ata_pci_remove_one(struct pci_dev *
 	ata_host_set_detach(host_set);
 	ata_host_set_stop(host_set);
 
-	if (host_set->ops->host_stop)
-		host_set->ops->host_stop(host_set);
-	else if (host_set->mmio_base)
+	if (host_set->mmio_base)
 		pci_iounmap(pdev, host_set->mmio_base);
 
 	ata_pci_host_set_destroy(host_set);
@@ -6183,7 +6168,6 @@ EXPORT_SYMBOL_GPL(ata_altstatus);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
-EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_mmio_data_xfer);
 EXPORT_SYMBOL_GPL(ata_pio_data_xfer);
@@ -6243,7 +6227,6 @@ EXPORT_SYMBOL_GPL(ata_timing_merge);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_host_stop);
 EXPORT_SYMBOL_GPL(ata_pci_host_set_init_native);
 EXPORT_SYMBOL_GPL(ata_pci_legacy_mask);
 EXPORT_SYMBOL_GPL(ata_pci_set_dma_mask);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 523a5e2..02ac266 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -618,8 +618,6 @@ struct ata_port_operations {
 	int (*port_start) (struct ata_port *ap);
 	void (*port_stop) (struct ata_port *ap);
 
-	void (*host_stop) (struct ata_host_set *host_set);
-
 	void (*bmdma_stop) (struct ata_queued_cmd *qc);
 	u8   (*bmdma_status) (struct ata_port *ap);
 };
@@ -752,7 +750,6 @@ extern u8 ata_altstatus(struct ata_port 
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
-extern void ata_host_stop (struct ata_host_set *host_set);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
 			       unsigned int buflen, int write_data);
@@ -838,7 +835,6 @@ struct pci_bits {
 	unsigned long		val;
 };
 
-extern void ata_pci_host_stop (struct ata_host_set *host_set);
 extern void ata_pci_host_set_init_native(struct ata_host_set *host_set);
 extern unsigned int ata_pci_legacy_mask(struct pci_dev *pdev);
 extern int ata_pci_set_dma_mask(struct pci_dev *pdev, u64 dma_mask,
-- 
1.3.2


