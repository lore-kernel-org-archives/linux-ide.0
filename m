From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/13] libata-hp: implement unload-unplug
Date: Fri, 12 May 2006 00:32:07 +0900
Message-ID: <11473615271023-git-send-email-htejun@gmail.com>
References: <11473615261297-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.206]:56391 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030271AbWEKPcU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:32:20 -0400
Received: by wx-out-0102.google.com with SMTP id i29so19904wxd
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:32:19 -0700 (PDT)
In-Reply-To: <11473615261297-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement unload unplug - driver unloading / PCI removal via hot
unplug path.  This is done by ata_port_detach() which requests detach
of all devices, schedules EH and wait for it to complete.  EH path is
slightly modified to handle this (e.g. force zero eh_info during
unloading).  With this patch, EH and unloading are properly
synchronized and unloading should be safe under any circumstances.

---

 drivers/scsi/ahci.c        |    1 +
 drivers/scsi/libata-core.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-eh.c   |    7 ++++---
 include/linux/libata.h     |    1 +
 4 files changed, 53 insertions(+), 3 deletions(-)

8c2ce9c4c4f5499bc88b1514a791a6038cfaf80e
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index a3189ea..d977055 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1390,6 +1390,7 @@ static void ahci_remove_one (struct pci_
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
 
+		ata_port_detach(ap);
 		scsi_remove_host(ap->host);
 	}
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 17b1782..3bce69d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5558,6 +5558,51 @@ err_free_ret:
 }
 
 /**
+ *	ata_port_detach - Detach ATA port in prepration of device removal
+ *	@ap: ATA port to be detached
+ *
+ *	Detach all ATA devices and associated SCSI devices.  @ap is
+ *	guaranteed to be quiescent on return from this function.
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
+	flush_workqueue(ata_hotplug_wq);
+	cancel_delayed_work(&ap->hotplug_task);
+	flush_workqueue(ata_hotplug_wq);
+
+	/* freeze the port */
+	ata_eh_freeze_port(ap);
+}
+
+/**
  *	ata_host_set_remove - PCI layer callback for device removal
  *	@host_set: ATA host set that was removed
  *
@@ -5575,6 +5620,7 @@ void ata_host_set_remove(struct ata_host
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
+		ata_port_detach(ap);
 		scsi_remove_host(ap->host);
 	}
 
@@ -5846,6 +5892,7 @@ u32 ata_wait_register(void __iomem *reg,
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
+EXPORT_SYMBOL_GPL(ata_port_detach);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 694e063..629b855 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -239,7 +239,8 @@ void ata_scsi_error(struct Scsi_Host *ho
 		spin_lock_irqsave(hs_lock, flags);
 
 		memset(&ap->eh_context, 0, sizeof(ap->eh_context));
-		ap->eh_context.i = ap->eh_info;
+		if (!(ap->flags & ATA_FLAG_UNLOADING))
+			ap->eh_context.i = ap->eh_info;
 		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
 
 		ap->flags &= ~ATA_FLAG_EH_PENDING;
@@ -295,7 +296,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		int bit = fls(ATA_FLAG_LOADING) - 1;
 		clear_bit(bit, &ap->flags);
 		wake_up_bit(&ap->flags, bit);
-	} else {
+	} else if (!(ap->flags & ATA_FLAG_UNLOADING)) {
 		if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
 			queue_work(ata_hotplug_wq, &ap->hotplug_task);
 		if (ap->flags & ATA_FLAG_RECOVERED)
@@ -1826,7 +1827,7 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 	       ata_postreset_fn_t postreset)
 {
-	if (!(ap->flags & ATA_FLAG_LOADING)) {
+	if (!(ap->flags & (ATA_FLAG_LOADING | ATA_FLAG_UNLOADING))) {
 		ata_eh_autopsy(ap);
 		ata_eh_report(ap);
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3c86067..85a634e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -635,6 +635,7 @@ extern int ata_pci_device_resume(struct 
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
+extern void ata_port_detach(struct ata_port *ap);
 extern void ata_host_set_remove(struct ata_host_set *host_set);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
-- 
1.2.4


