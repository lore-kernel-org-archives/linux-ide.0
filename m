From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/20] libata: reimplement ata_pci_remove_one() using new PCI init helpers
Date: Sat, 19 Aug 2006 17:59:32 +0900
Message-ID: <11559779721874-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:63322 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751677AbWHSJ1k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 05:27:40 -0400
Received: by py-out-1112.google.com with SMTP id n25so1477495pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 02:27:40 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Reimplement ata_pci_remove_one() using new PCI init helpers.

* drvdata clearing is moved to ata_host_detach().

* if (!ops->host_stop) mmio_base is iounmapped.  This makes mmio_base
  release libata-pci's responsibility and will ease following
  host_stop and iomap updates.  This behavior is temporary.

* unused ata_host_remove() is killed.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   72 +--------------------------------------------
 drivers/ata/libata-pci.c  |   29 ++++++++++++++++++
 include/linux/libata.h    |    1 -
 3 files changed, 31 insertions(+), 71 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0509935..ad32d35 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6108,6 +6108,8 @@ void ata_host_detach(struct ata_host *ho
 
 	for (i = 0; i < host->n_ports; i++)
 		ata_port_detach(host->ports[i]);
+
+	dev_set_drvdata(host->dev, NULL);
 }
 
 /**
@@ -6212,48 +6214,6 @@ void ata_host_free(struct ata_host *host
 	kfree(host);
 }
 
-/**
- *	ata_host_remove - PCI layer callback for device removal
- *	@host: ATA host set that was removed
- *
- *	Unregister all objects associated with this host set. Free those
- *	objects.
- *
- *	LOCKING:
- *	Inherited from calling layer (may sleep).
- */
-void ata_host_remove(struct ata_host *host)
-{
-	unsigned int i;
-
-	ata_host_detach(host);
-
-	free_irq(host->irq, host);
-	if (host->irq2)
-		free_irq(host->irq2, host);
-
-	ata_host_stop(host);
-
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
-			struct ata_ioports *ioaddr = &ap->ioaddr;
-
-			/* FIXME: Add -ac IDE pci mods to remove these special cases */
-			if (ioaddr->cmd_addr == ATA_PRIMARY_CMD)
-				release_region(ATA_PRIMARY_CMD, 8);
-			else if (ioaddr->cmd_addr == ATA_SECONDARY_CMD)
-				release_region(ATA_SECONDARY_CMD, 8);
-		}
-	}
-
-	if (host->ops->host_stop)
-		host->ops->host_stop(host);
-
-	ata_host_free(host);
-}
-
 struct ata_probe_ent *
 ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
 {
@@ -6315,32 +6275,6 @@ void ata_pci_host_stop (struct ata_host 
 	pci_iounmap(pdev, host->mmio_base);
 }
 
-/**
- *	ata_pci_remove_one - PCI layer callback for device removal
- *	@pdev: PCI device that was removed
- *
- *	PCI layer indicates to libata via this hook that
- *	hot-unplug or module unload event has occurred.
- *	Handle this by unregistering all objects associated
- *	with this PCI device.  Free those objects.  Then finally
- *	release PCI resources and disable device.
- *
- *	LOCKING:
- *	Inherited from PCI layer (may sleep).
- */
-
-void ata_pci_remove_one (struct pci_dev *pdev)
-{
-	struct device *dev = pci_dev_to_dev(pdev);
-	struct ata_host *host = dev_get_drvdata(dev);
-
-	ata_host_remove(host);
-
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-	dev_set_drvdata(dev, NULL);
-}
-
 /* move to PCI subsystem */
 int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 {
@@ -6572,7 +6506,6 @@ EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_host_free_irqs);
 EXPORT_SYMBOL_GPL(ata_host_free);
-EXPORT_SYMBOL_GPL(ata_host_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_hsm_move);
@@ -6651,7 +6584,6 @@ #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(ata_pci_host_stop);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
-EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
diff --git a/drivers/ata/libata-pci.c b/drivers/ata/libata-pci.c
index 9649a8c..6e2c454 100644
--- a/drivers/ata/libata-pci.c
+++ b/drivers/ata/libata-pci.c
@@ -619,6 +619,34 @@ int ata_pci_init_one(struct pci_dev *pde
 	return rc;
 }
 
+/**
+ *	ata_pci_remove_one - PCI layer callback for device removal
+ *	@pdev: PCI device that was removed
+ *
+ *	PCI layer indicates to libata via this hook that
+ *	hot-unplug or module unload event has occurred.
+ *	Handle this by unregistering all objects associated
+ *	with this PCI device.  Free those objects.  Then finally
+ *	release PCI resources and disable device.
+ *
+ *	LOCKING:
+ *	Inherited from PCI layer (may sleep).
+ */
+void ata_pci_remove_one(struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
+
+	ata_host_detach(host);
+
+	if (host->mmio_base) {
+		ata_host_stop(host);
+		pci_iounmap(pdev, host->mmio_base);
+	}
+
+	ata_pci_host_destroy(host);
+}
+
 EXPORT_SYMBOL_GPL(ata_pci_legacy_mask);
 EXPORT_SYMBOL_GPL(ata_pci_set_dma_mask);
 EXPORT_SYMBOL_GPL(ata_pci_acquire_resources);
@@ -631,3 +659,4 @@ EXPORT_SYMBOL_GPL(ata_pci_free_msix_irqs
 EXPORT_SYMBOL_GPL(ata_pci_host_prepare);
 EXPORT_SYMBOL_GPL(ata_pci_host_destroy);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
+EXPORT_SYMBOL_GPL(ata_pci_remove_one);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3705d09..e96c257 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -767,7 +767,6 @@ extern void ata_host_free_irqs(struct at
 extern void ata_host_free(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
 			  unsigned long, const struct ata_port_operations *);
-extern void ata_host_remove(struct ata_host *host);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-- 
1.4.1.1


