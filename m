From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/20] libata: implement ata_host_detach() and ata_host_free()
Date: Sat, 19 Aug 2006 17:59:31 +0900
Message-ID: <1155977971165-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:43525 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751640AbWHSI7h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:37 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465942pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:37 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement and use ata_host_detach() and ata_host_free().
ata_host_detach() detaches all ports in the host and supercedes
ata_port_detach().  ata_host_free() makes sure all ports are stopped
(LLDs may stop ports beforehand if necessary), frees all ports and the
host itself.  ata_host_free() can also be used in the error handling
path of init functions.

This patch moves several memory deallocations but doesn't introduce
any real behavior changes.

This is a part of efforts to improve [de-]init paths and simplify
LLDs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |   13 +++------
 drivers/ata/libata-core.c |   65 +++++++++++++++++++++++++++++++++++++--------
 include/linux/libata.h    |    3 +-
 3 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index eb6ceb3..08ecc69 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1634,30 +1634,27 @@ static void ahci_remove_one (struct pci_
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	unsigned int i;
 	int have_msi;
 
-	for (i = 0; i < host->n_ports; i++)
-		ata_port_detach(host->ports[i]);
+	ata_host_detach(host);
 
 	have_msi = hpriv->flags & AHCI_FLAG_MSI;
 	free_irq(host->irq, host);
 
 	ata_host_stop(host);
-
-	for (i = 0; i < host->n_ports; i++)
-		scsi_host_put(host->ports[i]->scsi_host);
-	kfree(hpriv);
 	pci_iounmap(pdev, host->mmio_base);
-	kfree(host);
 
 	if (have_msi)
 		pci_disable_msi(pdev);
 	else
 		pci_intx(pdev, 0);
+
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
+
+	ata_host_free(host);
+	kfree(hpriv);
 }
 
 static int __init ahci_init(void)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8472ec9..d7bf4a1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5621,10 +5621,7 @@ err_out_free_irq:
 	free_irq(ent->irq, host);
 err_out:
 	ata_host_stop(host);
-
-	for (i = 0; i < host->n_ports; i++)
-		scsi_host_put(host->ports[i]->scsi_host);
-	kfree(host);
+	ata_host_free(host);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
 }
@@ -5640,7 +5637,7 @@ err_out:
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_port_detach(struct ata_port *ap)
+static void ata_port_detach(struct ata_port *ap)
 {
 	unsigned long flags;
 	int i;
@@ -5691,6 +5688,23 @@ void ata_port_detach(struct ata_port *ap
 }
 
 /**
+ *	ata_host_detach - Detach a host from the system
+ *	@host: ATA host set that was removed
+ *
+ *	Detach all objects associated with this host set.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_host_detach(struct ata_host *host)
+{
+	int i;
+
+	for (i = 0; i < host->n_ports; i++)
+		ata_port_detach(host->ports[i]);
+}
+
+/**
  *	ata_host_stop - stop ports of an ATA host
  *	@host: ATA host to stop
  *
@@ -5719,6 +5733,36 @@ void ata_host_stop(struct ata_host *host
 }
 
 /**
+ *	ata_host_free - Release a host
+ *	@host: ATA host set to be freed
+ *
+ *	Free all objects associated with this host set.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_host_free(struct ata_host *host)
+{
+	int i;
+
+	/* free(NULL) is supported */
+	if (!host)
+		return;
+
+	/* make sure all ports are stopped */
+	ata_host_stop(host);
+
+	/* free */
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		if (ap)
+			scsi_host_put(ap->scsi_host);
+	}
+
+	kfree(host);
+}
+
+/**
  *	ata_host_remove - PCI layer callback for device removal
  *	@host: ATA host set that was removed
  *
@@ -5728,13 +5772,11 @@ void ata_host_stop(struct ata_host *host
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  */
-
 void ata_host_remove(struct ata_host *host)
 {
 	unsigned int i;
 
-	for (i = 0; i < host->n_ports; i++)
-		ata_port_detach(host->ports[i]);
+	ata_host_detach(host);
 
 	free_irq(host->irq, host);
 	if (host->irq2)
@@ -5754,14 +5796,12 @@ void ata_host_remove(struct ata_host *ho
 			else if (ioaddr->cmd_addr == ATA_SECONDARY_CMD)
 				release_region(ATA_SECONDARY_CMD, 8);
 		}
-
-		scsi_host_put(ap->scsi_host);
 	}
 
 	if (host->ops->host_stop)
 		host->ops->host_stop(host);
 
-	kfree(host);
+	ata_host_free(host);
 }
 
 struct ata_probe_ent *
@@ -6070,8 +6110,9 @@ EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_host_start);
 EXPORT_SYMBOL_GPL(ata_device_add);
-EXPORT_SYMBOL_GPL(ata_port_detach);
+EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_host_stop);
+EXPORT_SYMBOL_GPL(ata_host_free);
 EXPORT_SYMBOL_GPL(ata_host_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e098d32..5263e6b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -692,8 +692,9 @@ extern int ata_pci_clear_simplex(struct 
 #endif /* CONFIG_PCI */
 extern int ata_host_start(struct ata_host *host);
 extern int ata_device_add(const struct ata_probe_ent *ent);
-extern void ata_port_detach(struct ata_port *ap);
+extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_stop(struct ata_host *host);
+extern void ata_host_free(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
 			  unsigned long, const struct ata_port_operations *);
 extern void ata_host_remove(struct ata_host *host);
-- 
1.4.1.1


