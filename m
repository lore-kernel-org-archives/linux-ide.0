From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/20] libata: implement ata_host_start/stop()
Date: Sat, 19 Aug 2006 17:59:30 +0900
Message-ID: <1155977970528-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:38148 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751564AbWHSI7h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:37 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465941pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:37 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement [de-]init helpers ata_host_start/stop().  start() will start
all ports in the host while stop() does the opposite.  These helpers
use ATA_PFLAG_STARTED to track whether a port is started or not and
thus can be called without side effect.

ata_host_stop() replaces half of ata_scsi_release() and the other half
is merged into ata_host_detach().

This patch introduces the follwing behavior changes.

* ->port_start/stop() can be omitted.  This will be used to simplify
  port initialization.

* ->port_disable() callback is reordered w.r.t. freeing IRQs.  The
  callback's roll and usefulness are questionable.  All LLDs use
  ata_port_disable() and libata-core directly calls ata_port_disable()
  in several places.  ->port_disable() invocation during port deinit
  doesn't provide any feature.  All are already done by EH.  The
  relocation doesn't cause any real behavior change.

This is a part of efforts to improve [de-]init paths and simplify
LLDs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    9 +--
 drivers/ata/libata-core.c |  129 +++++++++++++++++++++++++++++----------------
 include/linux/libata.h    |    5 +-
 3 files changed, 91 insertions(+), 52 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3f1106f..eb6ceb3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1643,13 +1643,10 @@ static void ahci_remove_one (struct pci_
 	have_msi = hpriv->flags & AHCI_FLAG_MSI;
 	free_irq(host->irq, host);
 
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		ata_scsi_release(ap->scsi_host);
-		scsi_host_put(ap->scsi_host);
-	}
+	ata_host_stop(host);
 
+	for (i = 0; i < host->n_ports; i++)
+		scsi_host_put(host->ports[i]->scsi_host);
 	kfree(hpriv);
 	pci_iounmap(pdev, host->mmio_base);
 	kfree(host);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e8bbbaa..8472ec9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5394,6 +5394,42 @@ void ata_host_init(struct ata_host *host
 }
 
 /**
+ *	ata_host_start - start ports of an ATA host
+ *	@host: ATA host to start ports for
+ *
+ *	Start ports of @host.  Port started status is recorded in
+ *	ap->pflags, so this function can be called multiple times.
+ *	Ports are guaranteed to get started only once.
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
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap->pflags & ATA_PFLAG_STARTED)
+			continue;
+
+		if (ap->ops->port_start) {
+			rc = ap->ops->port_start(ap);
+			if (rc)
+				return rc;
+		}
+
+		ap->pflags |= ATA_PFLAG_STARTED;
+	}
+
+	return 0;
+}
+
+/**
  *	ata_device_add - Register hardware device with ATA and SCSI layers
  *	@ent: Probe information describing hardware device to be registered
  *
@@ -5451,14 +5487,6 @@ int ata_device_add(const struct ata_prob
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
@@ -5476,6 +5504,16 @@ int ata_device_add(const struct ata_prob
 				ap->ioaddr.ctl_addr,
 				ap->ioaddr.bmdma_addr,
 				irq_line);
+	}
+
+	/* start ports */
+	rc = ata_host_start(host);
+	if (rc)
+		goto err_out;
+
+	/* freeze */
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
 
 		ata_chk_status(ap);
 		host->ops->irq_clear(ap);
@@ -5582,14 +5620,10 @@ int ata_device_add(const struct ata_prob
 err_out_free_irq:
 	free_irq(ent->irq, host);
 err_out:
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-		if (ap) {
-			ap->ops->port_stop(ap);
-			scsi_host_put(ap->scsi_host);
-		}
-	}
+	ata_host_stop(host);
 
+	for (i = 0; i < host->n_ports; i++)
+		scsi_host_put(host->ports[i]->scsi_host);
 	kfree(host);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
@@ -5651,6 +5685,37 @@ void ata_port_detach(struct ata_port *ap
  skip_eh:
 	/* remove the associated SCSI host */
 	scsi_remove_host(ap->scsi_host);
+
+	/* disable port */
+	ap->ops->port_disable(ap);
+}
+
+/**
+ *	ata_host_stop - stop ports of an ATA host
+ *	@host: ATA host to stop
+ *
+ *	Stop ports of @host.  Port started status is recorded in
+ *	ap->pflags, so this functio can be called multiple times.
+ *	Started ports are guranteed to be stopped only once.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_host_stop(struct ata_host *host)
+{
+	int i;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (!ap || !(ap->pflags & ATA_PFLAG_STARTED))
+			continue;
+
+		if (ap->ops->port_stop)
+			ap->ops->port_stop(ap);
+
+		ap->pflags &= ~ATA_PFLAG_STARTED;
+	}
 }
 
 /**
@@ -5675,11 +5740,11 @@ void ata_host_remove(struct ata_host *ho
 	if (host->irq2)
 		free_irq(host->irq2, host);
 
+	ata_host_stop(host);
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-		ata_scsi_release(ap->scsi_host);
-
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
 			struct ata_ioports *ioaddr = &ap->ioaddr;
 
@@ -5699,33 +5764,6 @@ void ata_host_remove(struct ata_host *ho
 	kfree(host);
 }
 
-/**
- *	ata_scsi_release - SCSI layer callback hook for host unload
- *	@host: libata host to be unloaded
- *
- *	Performs all duties necessary to shut down a libata port...
- *	Kill port kthread, disable port, and release resources.
- *
- *	LOCKING:
- *	Inherited from SCSI layer.
- *
- *	RETURNS:
- *	One.
- */
-
-int ata_scsi_release(struct Scsi_Host *shost)
-{
-	struct ata_port *ap = ata_shost_to_port(shost);
-
-	DPRINTK("ENTER\n");
-
-	ap->ops->port_disable(ap);
-	ap->ops->port_stop(ap);
-
-	DPRINTK("EXIT\n");
-	return 1;
-}
-
 struct ata_probe_ent *
 ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
 {
@@ -6030,8 +6068,10 @@ EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
+EXPORT_SYMBOL_GPL(ata_host_start);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_port_detach);
+EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_host_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
@@ -6090,7 +6130,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(sata_scr_valid);
 EXPORT_SYMBOL_GPL(sata_scr_read);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8fd8851..e098d32 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -184,6 +184,8 @@ enum {
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 
+	ATA_PFLAG_STARTED	= (1 << 24), /* port has been started */
+
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 1), /* have s/g table? */
@@ -688,15 +690,16 @@ extern int ata_pci_device_suspend(struct
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
+extern int ata_host_start(struct ata_host *host);
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_port_detach(struct ata_port *ap);
+extern void ata_host_stop(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
 			  unsigned long, const struct ata_port_operations *);
 extern void ata_host_remove(struct ata_host *host);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-extern int ata_scsi_release(struct Scsi_Host *host);
 extern void ata_sas_port_destroy(struct ata_port *);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 					   struct ata_port_info *, struct Scsi_Host *);
-- 
1.4.1.1


