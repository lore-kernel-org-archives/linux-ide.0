From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/17] libata: update ata_pci_remove_one() using new PCI init helpers
Date: Mon, 7 Aug 2006 12:04:01 +0900
Message-ID: <1154919841585-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:16454 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750949AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855381pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:11 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_pci_remove_one() using new PCI init helpers.

* drvdata clearing is moved to ata_host_set_detach().

* if (!ops->host_stop) mmio_base is iounmapped.  This makes mmio_base
  release libata-pci's responsibility and will ease following
  host_stop and iomap updates.

* unused ata_host_set_remove() is killed.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   60 ++++++++------------------------------------
 include/linux/libata.h     |    1 -
 2 files changed, 11 insertions(+), 50 deletions(-)

d05753cf46cbd57821b724073778fa0f3aae5680
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index cb22c04..bc326b8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5959,6 +5959,8 @@ void ata_host_set_detach(struct ata_host
 
 	for (i = 0; i < host_set->n_ports; i++)
 		ata_port_detach(host_set->ports[i]);
+
+	dev_set_drvdata(host_set->dev, NULL);
 }
 
 /**
@@ -5992,48 +5994,6 @@ void ata_host_set_free(struct ata_host_s
 }
 
 /**
- *	ata_host_set_remove - PCI layer callback for device removal
- *	@host_set: ATA host set that was removed
- *
- *	Unregister all objects associated with this host set. Free those
- *	objects.
- *
- *	LOCKING:
- *	Inherited from calling layer (may sleep).
- */
-void ata_host_set_remove(struct ata_host_set *host_set)
-{
-	unsigned int i;
-
-	ata_host_set_detach(host_set);
-
-	free_irq(host_set->irq, host_set);
-	if (host_set->irq2)
-		free_irq(host_set->irq2, host_set);
-
-	ata_host_set_stop(host_set);
-
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap = host_set->ports[i];
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
-	if (host_set->ops->host_stop)
-		host_set->ops->host_stop(host_set);
-
-	ata_host_set_free(host_set);
-}
-
-/**
  *	ata_std_ports - initialize ioaddr with standard port offsets.
  *	@ioaddr: IO address structure to be initialized
  *
@@ -6082,17 +6042,20 @@ void ata_pci_host_stop (struct ata_host_
  *	LOCKING:
  *	Inherited from PCI layer (may sleep).
  */
-
-void ata_pci_remove_one (struct pci_dev *pdev)
+void ata_pci_remove_one(struct pci_dev *pdev)
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host_set *host_set = dev_get_drvdata(dev);
 
-	ata_host_set_remove(host_set);
+	ata_host_set_detach(host_set);
+	ata_host_set_stop(host_set);
+
+	if (host_set->ops->host_stop)
+		host_set->ops->host_stop(host_set);
+	else if (host_set->mmio_base)
+		pci_iounmap(pdev, host_set->mmio_base);
 
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-	dev_set_drvdata(dev, NULL);
+	ata_pci_host_set_destroy(host_set);
 }
 
 /* move to PCI subsystem */
@@ -6324,7 +6287,6 @@ EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_detach);
 EXPORT_SYMBOL_GPL(ata_host_set_stop);
 EXPORT_SYMBOL_GPL(ata_host_set_free);
-EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_hsm_move);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ed89959..1fe1b96 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -734,7 +734,6 @@ extern int ata_device_add(const struct a
 extern void ata_host_set_detach(struct ata_host_set *host_set);
 extern void ata_host_set_stop(struct ata_host_set *host_set);
 extern void ata_host_set_free(struct ata_host_set *host_set);
-extern void ata_host_set_remove(struct ata_host_set *host_set);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-- 
1.3.2


