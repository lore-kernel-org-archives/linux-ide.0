From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/13] libata-hp: implement unload-unplug
Date: Mon, 29 May 2006 15:38:56 +0900
Message-ID: <1148884736485-git-send-email-htejun@gmail.com>
References: <11488847352050-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:42609 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751310AbWE2GjS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:39:18 -0400
Received: by nz-out-0102.google.com with SMTP id s18so477101nze
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:39:17 -0700 (PDT)
In-Reply-To: <11488847352050-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement unload unplug - driver unloading / PCI removal via hot
unplug path.  This is done by ata_port_detach() which requests detach
of all devices, schedules EH and wait for it to complete.  EH path is
slightly modified to handle this (e.g. force zero eh_info during
unloading).  With this patch, EH and unloading are properly
synchronized and unloading should be safe under any circumstances.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |   10 ++-----
 drivers/scsi/libata-core.c |   59 ++++++++++++++++++++++++++++++++++++++++----
 drivers/scsi/libata-eh.c   |    7 +++--
 include/linux/libata.h     |    1 +
 4 files changed, 61 insertions(+), 16 deletions(-)

dc54139a72085d78f1fc35a721cff16cdeb38ef9
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index afb3805..60f455b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1389,21 +1389,17 @@ static void ahci_remove_one (struct pci_
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host_set *host_set = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host_set->private_data;
-	struct ata_port *ap;
 	unsigned int i;
 	int have_msi;
 
-	for (i = 0; i < host_set->n_ports; i++) {
-		ap = host_set->ports[i];
-
-		scsi_remove_host(ap->host);
-	}
+	for (i = 0; i < host_set->n_ports; i++)
+		ata_port_detach(host_set->ports[i]);
 
 	have_msi = hpriv->flags & AHCI_FLAG_MSI;
 	free_irq(host_set->irq, host_set);
 
 	for (i = 0; i < host_set->n_ports; i++) {
-		ap = host_set->ports[i];
+		struct ata_port *ap = host_set->ports[i];
 
 		ata_scsi_release(ap->host);
 		scsi_host_put(ap->host);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f45e04f..b622c61 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5613,6 +5613,55 @@ err_free_ret:
 }
 
 /**
+ *	ata_port_detach - Detach ATA port in prepration of device removal
+ *	@ap: ATA port to be detached
+ *
+ *	Detach all ATA devices and the associated SCSI devices of @ap;
+ *	then, remove the associated SCSI host.  @ap is guaranteed to
+ *	be quiescent on return from this function.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_port_detach(struct ata_port *ap)
+{
+	unsigned long flags;
+	int i;
+
+	if (!ap->ops->error_handler)
+		return;
+
+	/* tell EH to self-destruct */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	ap->flags |= ATA_FLAG_UNLOADING;
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ap->device[i].flags |= ATA_DFLAG_DETACH;
+
+	ata_port_schedule_eh(ap);
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	/* wait for EH */
+	while (scsi_host_in_recovery(ap->host))
+		msleep(100);
+
+	/* Flush hotplug task.  The sequence is similar to
+	 * ata_port_flush_task().  ATA_FLAG_UNLOADING prevents further
+	 * queueing of hotplug_task.
+	 */
+	flush_workqueue(ata_scsi_wq);
+	cancel_delayed_work(&ap->hotplug_task);
+	flush_workqueue(ata_scsi_wq);
+
+	/* freeze the port */
+	ata_eh_freeze_port(ap);
+
+	/* remove the associated SCSI host */
+	scsi_remove_host(ap->host);
+}
+
+/**
  *	ata_host_set_remove - PCI layer callback for device removal
  *	@host_set: ATA host set that was removed
  *
@@ -5625,18 +5674,15 @@ err_free_ret:
 
 void ata_host_set_remove(struct ata_host_set *host_set)
 {
-	struct ata_port *ap;
 	unsigned int i;
 
-	for (i = 0; i < host_set->n_ports; i++) {
-		ap = host_set->ports[i];
-		scsi_remove_host(ap->host);
-	}
+	for (i = 0; i < host_set->n_ports; i++)
+		ata_port_detach(host_set->ports[i]);
 
 	free_irq(host_set->irq, host_set);
 
 	for (i = 0; i < host_set->n_ports; i++) {
-		ap = host_set->ports[i];
+		struct ata_port *ap = host_set->ports[i];
 
 		ata_scsi_release(ap->host);
 
@@ -5904,6 +5950,7 @@ EXPORT_SYMBOL_GPL(sata_deb_timing_before
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
+EXPORT_SYMBOL_GPL(ata_port_detach);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7b5cb02..9eb73bb 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -234,7 +234,8 @@ void ata_scsi_error(struct Scsi_Host *ho
 		spin_lock_irqsave(hs_lock, flags);
 
 		memset(&ap->eh_context, 0, sizeof(ap->eh_context));
-		ap->eh_context.i = ap->eh_info;
+		if (!(ap->flags & ATA_FLAG_UNLOADING))
+			ap->eh_context.i = ap->eh_info;
 		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
 
 		ap->flags &= ~ATA_FLAG_EH_PENDING;
@@ -290,7 +291,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		int bit = fls(ATA_FLAG_LOADING) - 1;
 		clear_bit(bit, &ap->flags);
 		wake_up_bit(&ap->flags, bit);
-	} else {
+	} else if (!(ap->flags & ATA_FLAG_UNLOADING)) {
 		if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
 			queue_work(ata_scsi_wq, &ap->hotplug_task);
 		if (ap->flags & ATA_FLAG_RECOVERED)
@@ -1769,7 +1770,7 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 	       ata_postreset_fn_t postreset)
 {
-	if (!(ap->flags & ATA_FLAG_LOADING)) {
+	if (!(ap->flags & (ATA_FLAG_LOADING | ATA_FLAG_UNLOADING))) {
 		ata_eh_autopsy(ap);
 		ata_eh_report(ap);
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b216400..99a2b68 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -647,6 +647,7 @@ extern int ata_pci_device_resume(struct 
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
+extern void ata_port_detach(struct ata_port *ap);
 extern void ata_host_set_remove(struct ata_host_set *host_set);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
-- 
1.3.2


