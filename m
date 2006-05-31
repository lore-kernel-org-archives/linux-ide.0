From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/13] libata-hp: update unload-unplug
Date: Wed, 31 May 2006 20:25:45 +0900
Message-ID: <11490747451246-git-send-email-htejun@gmail.com>
References: <11490747443727-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:47256 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964994AbWEaLZ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:25:58 -0400
Received: by nz-out-0102.google.com with SMTP id s18so8510nze
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:25:57 -0700 (PDT)
In-Reply-To: <11490747443727-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update unload unplug - driver unloading / PCI removal.  This is done
by ata_port_detach() which short-circuits EH, disables all devices and
freezes the port.  With this patch, EH and unloading/unplugging are
properly synchronized.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |   10 ++-----
 drivers/scsi/libata-core.c |   67 ++++++++++++++++++++++++++++++++++++++++----
 drivers/scsi/libata-eh.c   |    8 ++++-
 include/linux/libata.h     |    1 +
 4 files changed, 71 insertions(+), 15 deletions(-)

720ba12620ee09dce269adf4ad50958adac7bb54
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
index a42877e..01f2c59 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5610,6 +5610,63 @@ err_free_ret:
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
+	/* tell EH we're leaving & flush EH */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags |= ATA_FLAG_UNLOADING;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	ata_port_wait_eh(ap);
+
+	/* EH is now guaranteed to see UNLOADING, so no new device
+	 * will be attached.  Disable all existing devices.
+	 */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ata_dev_disable(&ap->device[i]);
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	/* Final freeze & EH.  All in-flight commands are aborted.  EH
+	 * will be skipped and retrials will be terminated with bad
+	 * target.
+	 */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ata_port_freeze(ap);	/* won't be thawed */
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	ata_port_wait_eh(ap);
+
+	/* Flush hotplug task.  The sequence is similar to
+	 * ata_port_flush_task().
+	 */
+	flush_workqueue(ata_aux_wq);
+	cancel_delayed_work(&ap->hotplug_task);
+	flush_workqueue(ata_aux_wq);
+
+	/* remove the associated SCSI host */
+	scsi_remove_host(ap->host);
+}
+
+/**
  *	ata_host_set_remove - PCI layer callback for device removal
  *	@host_set: ATA host set that was removed
  *
@@ -5622,18 +5679,15 @@ err_free_ret:
 
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
 
@@ -5901,6 +5955,7 @@ EXPORT_SYMBOL_GPL(sata_deb_timing_before
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
+EXPORT_SYMBOL_GPL(ata_port_detach);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 70c132b..30a83a5 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -46,6 +46,7 @@ #include <linux/libata.h>
 #include "libata.h"
 
 static void __ata_port_freeze(struct ata_port *ap);
+static void ata_eh_finish(struct ata_port *ap);
 
 static void ata_ering_record(struct ata_ering *ering, int is_io,
 			     unsigned int err_mask)
@@ -242,8 +243,11 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 		spin_unlock_irqrestore(hs_lock, flags);
 
-		/* invoke EH */
-		ap->ops->error_handler(ap);
+		/* invoke EH.  if unloading, just finish failed qcs */
+		if (!(ap->flags & ATA_FLAG_UNLOADING))
+			ap->ops->error_handler(ap);
+		else
+			ata_eh_finish(ap);
 
 		/* Exception might have happend after ->error_handler
 		 * recovered the port but before this point.  Repeat
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 74786c3..f11ba27 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -649,6 +649,7 @@ extern int ata_pci_device_resume(struct 
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
+extern void ata_port_detach(struct ata_port *ap);
 extern void ata_host_set_remove(struct ata_host_set *host_set);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
-- 
1.3.2


