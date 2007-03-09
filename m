From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata: separate out ata_host_start()
Date: Fri, 9 Mar 2007 20:15:35 +0900
Message-ID: <1173438935774-git-send-email-htejun@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:10257 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767179AbXCILPf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:35 -0500
Received: by wx-out-0506.google.com with SMTP id h31so822124wxd
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:35 -0800 (PST)
In-Reply-To: <1173438935540-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out ata_host_start() from ata_device_add().  ata_host_start()
calls ->port_start on each port if available and freezes the port.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   74 +++++++++++++++++++++++++++++++++++++--------
 include/linux/libata.h    |    2 +
 2 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fab488c..6a4e7a4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5671,11 +5671,14 @@ static void ata_host_release(struct device *gendev, void *res)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-		if (ap && ap->ops->port_stop)
+		if (!ap)
+			continue;
+
+		if ((host->flags & ATA_HOST_STARTED) && ap->ops->port_stop)
 			ap->ops->port_stop(ap);
 	}
 
-	if (host->ops->host_stop)
+	if ((host->flags & ATA_HOST_STARTED) && host->ops->host_stop)
 		host->ops->host_stop(host);
 
 	for (i = 0; i < host->n_ports; i++) {
@@ -5695,6 +5698,56 @@ static void ata_host_release(struct device *gendev, void *res)
 }
 
 /**
+ *	ata_host_start - start and freeze ports of an ATA host
+ *	@host: ATA host to start ports for
+ *
+ *	Start and then freeze ports of @host.  Started status is
+ *	recorded in host->flags, so this function can be called
+ *	multiple times.  Ports are guaranteed to get started only
+ *	once.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 if all ports are started successfully, -errno otherwise.
+ */
+int ata_host_start(struct ata_host *host)
+{
+	int i, rc;
+
+	if (host->flags & ATA_HOST_STARTED)
+		return 0;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap->ops->port_start) {
+			rc = ap->ops->port_start(ap);
+			if (rc) {
+				ata_port_printk(ap, KERN_ERR, "failed to "
+						"start port (errno=%d)\n", rc);
+				goto err_out;
+			}
+		}
+
+		ata_eh_freeze_port(ap);
+	}
+
+	host->flags |= ATA_HOST_STARTED;
+	return 0;
+
+ err_out:
+	while (--i >= 0) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap->ops->port_stop)
+			ap->ops->port_stop(ap);
+	}
+	return rc;
+}
+
+/**
  *	ata_sas_host_init - Initialize a host struct
  *	@host:	host to initialize
  *	@dev:	device host is attached to
@@ -5783,14 +5836,6 @@ int ata_device_add(const struct ata_probe_ent *ent)
 			continue;
 		}
 
-		/* start port */
-		rc = ap->ops->port_start(ap);
-		if (rc) {
-			host->ports[i] = NULL;
-			scsi_host_put(ap->scsi_host);
-			goto err_out;
-		}
-
 		/* Report the secondary IRQ for second channel legacy */
 		if (i == 1 && ent->irq2)
 			irq_line = ent->irq2;
@@ -5808,11 +5853,13 @@ int ata_device_add(const struct ata_probe_ent *ent)
 				ap->ioaddr.ctl_addr,
 				ap->ioaddr.bmdma_addr,
 				irq_line);
-
-		/* freeze port before requesting IRQ */
-		ata_eh_freeze_port(ap);
 	}
 
+	/* start ports */
+	rc = ata_host_start(host);
+	if (rc)
+		goto err_out;
+
 	/* obtain irq, that may be shared between channels */
 	rc = devm_request_irq(dev, ent->irq, ent->port_ops->irq_handler,
 			      ent->irq_flags, DRV_NAME, host);
@@ -6367,6 +6414,7 @@ EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
+EXPORT_SYMBOL_GPL(ata_host_start);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_sg_init);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index cfdc617..296c9ef 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -210,6 +210,7 @@ enum {
 
 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host only */
+	ATA_HOST_STARTED	= (1 << 1),	/* Host started */
 
 	/* various lengths of time */
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
@@ -727,6 +728,7 @@ extern int ata_pci_device_resume(struct pci_dev *pdev);
 #endif
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
+extern int ata_host_start(struct ata_host *host);
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
-- 
1.5.0.1


