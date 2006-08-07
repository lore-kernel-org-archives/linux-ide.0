From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/17] libata: implement ata_host_set_start/stop()
Date: Mon, 7 Aug 2006 12:04:00 +0900
Message-ID: <11549198402749-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:60996 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750948AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855301pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:06 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement [de-]init helpers ata_host_set_start/stop().  start() will
start all ports in the host_set while stop() does the opposite.  These
helpers use ATA_PFLAG_STARTED to track whether a port is started or
not and thus can be called without too much caution.

ata_host_set_stop() replaces half of ata_scsi_release() and the other
half is merged into ata_host_set_detach().

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

 drivers/scsi/ahci.c        |    9 +--
 drivers/scsi/libata-core.c |  135 +++++++++++++++++++++++++++++---------------
 include/linux/libata.h     |   18 +++---
 3 files changed, 103 insertions(+), 59 deletions(-)

8b0d0dbdb69bea20d32d54e0ec07b24d51c91bb4
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 68fd766..305663b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1643,13 +1643,10 @@ static void ahci_remove_one (struct pci_
 	have_msi = hpriv->flags & AHCI_FLAG_MSI;
 	free_irq(host_set->irq, host_set);
 
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap = host_set->ports[i];
-
-		ata_scsi_release(ap->host);
-		scsi_host_put(ap->host);
-	}
+	ata_host_set_stop(host_set);
 
+	for (i = 0; i < host_set->n_ports; i++)
+		scsi_host_put(host_set->ports[i]->host);
 	kfree(hpriv);
 	pci_iounmap(pdev, host_set->mmio_base);
 	kfree(host_set);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0ce7cdc..b3cc2f5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5322,6 +5322,45 @@ static struct ata_port * ata_port_add(co
 }
 
 /**
+ *	ata_host_set_start - start ports of an ATA host_set
+ *	@host_set: ATA host_set to start ports for
+ *
+ *	Start ports of @host_set.  Port started status is recorded in
+ *	ap->pflags, so this function can be called multiple times.
+ *	Ports are guaranteed to get started only once.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 if all ports are started successfully, -errno otherwise.
+ */
+int ata_host_set_start(struct ata_host_set *host_set)
+{
+	unsigned long flags;
+	int i, rc;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
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
+		spin_lock_irqsave(ap->lock, flags);
+		ap->pflags |= ATA_PFLAG_STARTED;
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+
+	return 0;
+}
+
+/**
  *	ata_device_add - Register hardware device with ATA and SCSI layers
  *	@ent: Probe information describing hardware device to be registered
  *
@@ -5382,14 +5421,6 @@ int ata_device_add(const struct ata_prob
 			continue;
 		}
 
-		/* start port */
-		rc = ap->ops->port_start(ap);
-		if (rc) {
-			host_set->ports[i] = NULL;
-			scsi_host_put(ap->host);
-			goto err_out;
-		}
-
 		/* Report the secondary IRQ for second channel legacy */
 		if (i == 1 && ent->irq2)
 			irq_line = ent->irq2;
@@ -5407,6 +5438,16 @@ int ata_device_add(const struct ata_prob
 				ap->ioaddr.ctl_addr,
 				ap->ioaddr.bmdma_addr,
 				irq_line);
+	}
+
+	/* start ports */
+	rc = ata_host_set_start(host_set);
+	if (rc)
+		goto err_out;
+
+	/* freeze */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
 
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
@@ -5513,14 +5554,10 @@ int ata_device_add(const struct ata_prob
 err_out_free_irq:
 	free_irq(ent->irq, host_set);
 err_out:
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap = host_set->ports[i];
-		if (ap) {
-			ap->ops->port_stop(ap);
-			scsi_host_put(ap->host);
-		}
-	}
+	ata_host_set_stop(host_set);
 
+	for (i = 0; i < host_set->n_ports; i++)
+		scsi_host_put(host_set->ports[i]->host);
 	kfree(host_set);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
@@ -5582,6 +5619,40 @@ void ata_port_detach(struct ata_port *ap
  skip_eh:
 	/* remove the associated SCSI host */
 	scsi_remove_host(ap->host);
+
+	/* disable port */
+	ap->ops->port_disable(ap);
+}
+
+/**
+ *	ata_host_set_stop - stop ports of an ATA host_set
+ *	@host_set: ATA host_set to stop
+ *
+ *	Stop ports of @host_set.  Port started status is recorded in
+ *	ap->pflags, so this functio can be called multiple times.
+ *	Started ports are guranteed to be stopped only once.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_host_set_stop(struct ata_host_set *host_set)
+{
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		if (!ap || !(ap->pflags & ATA_PFLAG_STARTED))
+			continue;
+
+		if (ap->ops->port_stop)
+			ap->ops->port_stop(ap);
+
+		spin_lock_irqsave(ap->lock, flags);
+		ap->pflags &= ~ATA_PFLAG_STARTED;
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
 }
 
 /**
@@ -5606,11 +5677,11 @@ void ata_host_set_remove(struct ata_host
 	if (host_set->irq2)
 		free_irq(host_set->irq2, host_set);
 
+	ata_host_set_stop(host_set);
+
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
-		ata_scsi_release(ap->host);
-
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
 			struct ata_ioports *ioaddr = &ap->ioaddr;
 
@@ -5631,33 +5702,6 @@ void ata_host_set_remove(struct ata_host
 }
 
 /**
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
-int ata_scsi_release(struct Scsi_Host *host)
-{
-	struct ata_port *ap = ata_shost_to_port(host);
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
-/**
  *	ata_std_ports - initialize ioaddr with standard port offsets.
  *	@ioaddr: IO address structure to be initialized
  *
@@ -5935,8 +5979,10 @@ EXPORT_SYMBOL_GPL(sata_deb_timing_long);
 EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
+EXPORT_SYMBOL_GPL(ata_host_set_start);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_port_detach);
+EXPORT_SYMBOL_GPL(ata_host_set_stop);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
@@ -5996,7 +6042,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(sata_scr_valid);
 EXPORT_SYMBOL_GPL(sata_scr_read);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1b6283c..7f1d45a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -174,13 +174,14 @@ enum {
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
 	/* struct ata_port pflags */
-	ATA_PFLAG_EH_PENDING	= (1 << 0), /* EH pending */
-	ATA_PFLAG_EH_IN_PROGRESS = (1 << 1), /* EH in progress */
-	ATA_PFLAG_FROZEN	= (1 << 2), /* port is frozen */
-	ATA_PFLAG_RECOVERED	= (1 << 3), /* recovery action performed */
-	ATA_PFLAG_LOADING	= (1 << 4), /* boot/loading probe */
-	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
-	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
+	ATA_PFLAG_STARTED	= (1 << 0), /* port has been started */
+	ATA_PFLAG_EH_PENDING	= (1 << 1), /* EH pending */
+	ATA_PFLAG_EH_IN_PROGRESS = (1 << 2), /* EH in progress */
+	ATA_PFLAG_FROZEN	= (1 << 3), /* port is frozen */
+	ATA_PFLAG_RECOVERED	= (1 << 4), /* recovery action performed */
+	ATA_PFLAG_LOADING	= (1 << 5), /* boot/loading probe */
+	ATA_PFLAG_UNLOADING	= (1 << 6), /* module is unloading */
+	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 7), /* SCSI hotplug scheduled */
 
 	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
@@ -690,13 +691,14 @@ extern int ata_pci_device_suspend(struct
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
+extern int ata_host_set_start(struct ata_host_set *host_set);
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_port_detach(struct ata_port *ap);
+extern void ata_host_set_stop(struct ata_host_set *host_set);
 extern void ata_host_set_remove(struct ata_host_set *host_set);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int sata_scr_valid(struct ata_port *ap);
 extern int sata_scr_read(struct ata_port *ap, int reg, u32 *val);
-- 
1.3.2


