From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/15] libata: reimplement controller-wide PM
Date: Sat, 24 Jun 2006 20:30:20 +0900
Message-ID: <11511486203395-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:55427 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933057AbWFXLaT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:19 -0400
Received: by nz-out-0102.google.com with SMTP id z31so964567nzd
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:19 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Reimplement controller-wide PM.  ata_host_set_suspend/resume() are
defined to suspend and resume a host_set.  While suspended, EHs for
all ports in the host_set are pegged using ATA_FLAG_SUSPENDED and
frozen.

Because SCSI device hotplug is done asynchronously against the rest of
libata EH and the same mutex is used when adding new device, suspend
cannot wait for hotplug to complete.  So, if SCSI device hotplug is in
progress, suspend fails with -EBUSY.

In most cases, host_set resume is followed by device resume.  As each
resume operation requires a reset, a single host_set-wide resume
operation may result in multiple resets.  To avoid this, resume waits
upto 1 second giving PM to request resume for devices.

There is no room left for additional port flag, but several bits are
schedueled to be removed.  This patch adds ATA_FLAG_RESUME as bit 31
which is reserved for LLD flags.  No in-kernel LLD uses bit 31 now, so
this works for the time being and we can change it once some of the
obsolete bits are removed.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  138 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/libata-eh.c   |   52 ++++++++++++++++-
 include/linux/libata.h     |   10 +++
 3 files changed, 192 insertions(+), 8 deletions(-)

5d5811d2d817853e94a5b7be2f7554c5109b5047
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1aa8a03..91f34ac 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4975,6 +4975,95 @@ int ata_port_offline(struct ata_port *ap
 }
 
 /**
+ *	ata_host_set_suspend - suspend host_set
+ *	@host_set: host_set to suspend
+ *	@mesg: PM message
+ *
+ *	Suspend @host_set.  Actual operation is performed by EH.  This
+ *	function requests EH to perform PM operations and waits for EH
+ *	to finish.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int ata_host_set_suspend(struct ata_host_set *host_set, pm_message_t mesg)
+{
+	unsigned long flags;
+	int i, j;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		/* set SUSPENDED and make sure EH sees it */
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		ap->flags |= ATA_FLAG_SUSPENDED;
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		ata_port_wait_eh(ap);
+
+		/* EH is quiescent now.  Fail if we have any ready
+		 * device.  This happens if hotplug occurs between
+		 * completion of device suspension and here.
+		 */
+		for (j = 0; j < ATA_MAX_DEVICES; j++) {
+			struct ata_device *dev = &ap->device[j];
+
+			if (ata_dev_ready(dev)) {
+				ata_port_printk(ap, KERN_INFO,
+						"suspend failed, device %d "
+						"still active\n", dev->devno);
+				goto fail;
+			}
+		}
+
+		/* freeze, won't be thawed until resume */
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		ata_port_freeze(ap);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	}
+
+	host_set->dev->power.power_state = mesg;
+	return 0;
+
+ fail:
+	ata_host_set_resume(host_set);
+	return -EBUSY;
+}
+
+/**
+ *	ata_host_set_resume - resume host_set
+ *	@host_set: host_set to resume
+ *
+ *	Resume @host_set.  Actual operation is performed by EH.  This
+ *	function requests EH to perform PM operations and returns.
+ *	Note that all resume operations are performed parallely.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_host_set_resume(struct ata_host_set *host_set)
+{
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		/* request resume & kick EH in the ass */
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		ap->flags |= ATA_FLAG_RESUME;
+		ata_port_schedule_eh(ap);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	}
+
+	host_set->dev->power.power_state = PMSG_ON;
+	return;
+}
+
+/**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
  *
@@ -5614,20 +5703,55 @@ int pci_test_config_bits(struct pci_dev 
 	return (tmp == bits->val) ? 1 : 0;
 }
 
-int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
-	return 0;
+
+	if (state.event == PM_EVENT_SUSPEND) {
+		pci_disable_device(pdev);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
 }
 
-int ata_pci_device_resume(struct pci_dev *pdev)
+void ata_pci_device_do_resume(struct pci_dev *pdev)
 {
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_enable_device(pdev);
 	pci_set_master(pdev);
+}
+
+int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	int rc = 0;
+
+	rc = ata_host_set_suspend(host_set, state);
+	if (rc)
+		return rc;
+
+	if (host_set->next) {
+		rc = ata_host_set_suspend(host_set->next, state);
+		if (rc) {
+			ata_host_set_resume(host_set);
+			return rc;
+		}
+	}
+
+	ata_pci_device_do_suspend(pdev, state);
+
+	return 0;
+}
+
+int ata_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+
+	ata_pci_device_do_resume(pdev);
+	ata_host_set_resume(host_set);
+	if (host_set->next)
+		ata_host_set_resume(host_set->next);
+
 	return 0;
 }
 #endif /* CONFIG_PCI */
@@ -5806,6 +5930,8 @@ EXPORT_SYMBOL_GPL(sata_scr_write);
 EXPORT_SYMBOL_GPL(sata_scr_write_flush);
 EXPORT_SYMBOL_GPL(ata_port_online);
 EXPORT_SYMBOL_GPL(ata_port_offline);
+EXPORT_SYMBOL_GPL(ata_host_set_suspend);
+EXPORT_SYMBOL_GPL(ata_host_set_resume);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
@@ -5820,6 +5946,8 @@ EXPORT_SYMBOL_GPL(ata_pci_host_stop);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
+EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 EXPORT_SYMBOL_GPL(ata_pci_default_filter);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 1c2b48c..eecda0d 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -176,6 +176,43 @@ enum scsi_eh_timer_return ata_scsi_timed
 }
 
 /**
+ *	ata_eh_wait_device_resume_request - wait for device resume request
+ *	@ap: target host port
+ *
+ *	This function is called before beginning EH on port resume.
+ *	It waits upto one second until all devices hanging off this
+ *	port requests resume EH action.  This is to prevent invoking
+ *	EH and thus reset multiple times on resume.
+ *
+ *	On DPM resume, where some of devices might not be resumed
+ *	together, this may delay port resume upto one second, but such
+ *	DPM resumes are rare and 1 sec delay isn't too bad.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_wait_device_resume_request(struct ata_port *ap)
+{
+	unsigned long timeout = jiffies + HZ;	/* 1s max */
+	int i;
+
+ repeat:
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		unsigned int action = ata_eh_dev_action(dev);
+
+		if ((dev->flags & ATA_DFLAG_SUSPENDED) &&
+		    !(action & ATA_EH_RESUME))
+			break;
+	}
+
+	if (i < ATA_MAX_DEVICES && time_before(jiffies, timeout)) {
+		msleep(10);
+		goto repeat;
+	}
+}
+
+/**
  *	ata_scsi_error - SCSI layer error handler callback
  *	@host: SCSI host on which error occurred
  *
@@ -263,9 +300,18 @@ void ata_scsi_error(struct Scsi_Host *ho
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
-		/* fetch & clear EH info */
 		spin_lock_irqsave(ap_lock, flags);
 
+		/* are we resuming? */
+		if (ap->flags & ATA_FLAG_RESUME) {
+			ap->flags &= ~(ATA_FLAG_RESUME | ATA_FLAG_SUSPENDED);
+			spin_unlock_irqrestore(ap_lock, flags);
+			/* give devices time to request EH */
+			ata_eh_wait_device_resume_request(ap);
+			spin_lock_irqsave(ap_lock, flags);
+		}
+
+		/* fetch & clear EH info */
 		memset(&ap->eh_context, 0, sizeof(ap->eh_context));
 		ap->eh_context.i = ap->eh_info;
 		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
@@ -275,8 +321,8 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 		spin_unlock_irqrestore(ap_lock, flags);
 
-		/* invoke EH.  if unloading, just finish failed qcs */
-		if (!(ap->flags & ATA_FLAG_UNLOADING))
+		/* invoke EH, skip if unloading or suspended */
+		if (!(ap->flags & (ATA_FLAG_UNLOADING | ATA_FLAG_SUSPENDED)))
 			ap->ops->error_handler(ap);
 		else
 			ata_eh_finish(ap);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0bd3abe..16c8fcc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -175,6 +175,11 @@ enum {
 	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
 
+	/* XXX - Bit 31 is reserved for LLDD but no LLDD is using it
+	 * ATM.  Steal it for the time being.  The following flag must
+	 * be updated once above obsolete flags are removed. */
+	ATA_FLAG_RESUME		= (1 << 31), /* resume */
+
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
 
 	/* struct ata_queued_cmd flags */
@@ -648,6 +653,8 @@ #ifdef CONFIG_PCI
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
+extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t state);
+extern void ata_pci_device_do_resume(struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
@@ -668,6 +675,9 @@ extern int ata_port_online(struct ata_po
 extern int ata_port_offline(struct ata_port *ap);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
+extern int ata_host_set_suspend(struct ata_host_set *host_set,
+				pm_message_t mesg);
+extern void ata_host_set_resume(struct ata_host_set *host_set);
 extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
-- 
1.3.2


