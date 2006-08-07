From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/17] libata: implement ata_host_set_detach() and ata_host_set_free()
Date: Mon, 7 Aug 2006 12:04:00 +0900
Message-ID: <115491984090-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:54341 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750953AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855305pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:06 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement and use ata_host_set_detach() and ata_host_set_free().
ata_host_set_detach() detaches all ports in the host_set and
supercedes ata_port_detach().  ata_host_set() makes sure all ports are
stopped (LLDs may stop ports beforehand if necessary), frees all ports
and the host_set itself.  ata_host_set_free() can also be used in the
error handling path of init functions.

This patch moves several memory deallocations but doesn't introduce
any real behavior changes.

This is a part of efforts to improve [de-]init paths and simplify
LLDs.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |   13 +++------
 drivers/scsi/libata-core.c |   66 +++++++++++++++++++++++++++++++++++---------
 include/linux/libata.h     |    3 +-
 3 files changed, 60 insertions(+), 22 deletions(-)

39d12c9f4e34b2c220deec0c2dc774f7db1a2f65
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 305663b..980a63e 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1634,30 +1634,27 @@ static void ahci_remove_one (struct pci_
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host_set *host_set = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host_set->private_data;
-	unsigned int i;
 	int have_msi;
 
-	for (i = 0; i < host_set->n_ports; i++)
-		ata_port_detach(host_set->ports[i]);
+	ata_host_set_detach(host_set);
 
 	have_msi = hpriv->flags & AHCI_FLAG_MSI;
 	free_irq(host_set->irq, host_set);
 
 	ata_host_set_stop(host_set);
-
-	for (i = 0; i < host_set->n_ports; i++)
-		scsi_host_put(host_set->ports[i]->host);
-	kfree(hpriv);
 	pci_iounmap(pdev, host_set->mmio_base);
-	kfree(host_set);
 
 	if (have_msi)
 		pci_disable_msi(pdev);
 	else
 		pci_intx(pdev, 0);
+
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
+
+	ata_host_set_free(host_set);
+	kfree(hpriv);
 }
 
 static int __init ahci_init(void)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b3cc2f5..f8d6bc0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5554,11 +5554,7 @@ int ata_device_add(const struct ata_prob
 err_out_free_irq:
 	free_irq(ent->irq, host_set);
 err_out:
-	ata_host_set_stop(host_set);
-
-	for (i = 0; i < host_set->n_ports; i++)
-		scsi_host_put(host_set->ports[i]->host);
-	kfree(host_set);
+	ata_host_set_free(host_set);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
 }
@@ -5574,7 +5570,7 @@ err_out:
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_port_detach(struct ata_port *ap)
+static void ata_port_detach(struct ata_port *ap)
 {
 	unsigned long flags;
 	int i;
@@ -5656,6 +5652,53 @@ void ata_host_set_stop(struct ata_host_s
 }
 
 /**
+ *	ata_host_set_detach - Detach a host_set from the system
+ *	@host_set: ATA host set that was removed
+ *
+ *	Detach all objects associated with this host set.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_host_set_detach(struct ata_host_set *host_set)
+{
+	int i;
+
+	for (i = 0; i < host_set->n_ports; i++)
+		ata_port_detach(host_set->ports[i]);
+}
+
+/**
+ *	ata_host_set_free - Release a host_set
+ *	@host_set: ATA host set to be freed
+ *
+ *	Free all objects associated with this host set.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_host_set_free(struct ata_host_set *host_set)
+{
+	int i;
+
+	/* free(NULL) is supported */
+	if (!host_set)
+		return;
+
+	/* make sure it's stopped */
+	ata_host_set_stop(host_set);
+
+	/* free */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+		if (ap)
+			scsi_host_put(ap->host);
+	}
+
+	kfree(host_set);
+}
+
+/**
  *	ata_host_set_remove - PCI layer callback for device removal
  *	@host_set: ATA host set that was removed
  *
@@ -5665,13 +5708,11 @@ void ata_host_set_stop(struct ata_host_s
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  */
-
 void ata_host_set_remove(struct ata_host_set *host_set)
 {
 	unsigned int i;
 
-	for (i = 0; i < host_set->n_ports; i++)
-		ata_port_detach(host_set->ports[i]);
+	ata_host_set_detach(host_set);
 
 	free_irq(host_set->irq, host_set);
 	if (host_set->irq2)
@@ -5691,14 +5732,12 @@ void ata_host_set_remove(struct ata_host
 			else if (ioaddr->cmd_addr == ATA_SECONDARY_CMD)
 				release_region(ATA_SECONDARY_CMD, 8);
 		}
-
-		scsi_host_put(ap->host);
 	}
 
 	if (host_set->ops->host_stop)
 		host_set->ops->host_stop(host_set);
 
-	kfree(host_set);
+	ata_host_set_free(host_set);
 }
 
 /**
@@ -5981,8 +6020,9 @@ EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_set_start);
 EXPORT_SYMBOL_GPL(ata_device_add);
-EXPORT_SYMBOL_GPL(ata_port_detach);
+EXPORT_SYMBOL_GPL(ata_host_set_detach);
 EXPORT_SYMBOL_GPL(ata_host_set_stop);
+EXPORT_SYMBOL_GPL(ata_host_set_free);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7f1d45a..5436bd1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -693,8 +693,9 @@ extern int ata_pci_clear_simplex(struct 
 #endif /* CONFIG_PCI */
 extern int ata_host_set_start(struct ata_host_set *host_set);
 extern int ata_device_add(const struct ata_probe_ent *ent);
-extern void ata_port_detach(struct ata_port *ap);
+extern void ata_host_set_detach(struct ata_host_set *host_set);
 extern void ata_host_set_stop(struct ata_host_set *host_set);
+extern void ata_host_set_free(struct ata_host_set *host_set);
 extern void ata_host_set_remove(struct ata_host_set *host_set);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
-- 
1.3.2


