From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/8] libata: reimplement controller-wide PM
Date: Wed, 28 Jun 2006 15:23:05 +0900
Message-ID: <11514757852854-git-send-email-htejun@gmail.com>
References: <11514757842728-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:16818 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030450AbWF1GWs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 02:22:48 -0400
Received: by wr-out-0506.google.com with SMTP id i24so346494wra
        for <linux-ide@vger.kernel.org>; Tue, 27 Jun 2006 23:22:47 -0700 (PDT)
In-Reply-To: <11514757842728-git-send-email-htejun@gmail.com>
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

 drivers/scsi/libata-core.c |  160 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/libata-eh.c   |  128 +++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |   16 ++++
 3 files changed, 297 insertions(+), 7 deletions(-)

18ffcde45ad19c30b9cc7d7c3b33db62c698888b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e42a7f6..1a4afe8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4981,6 +4981,117 @@ int ata_port_offline(struct ata_port *ap
 	return 0;
 }
 
+static int ata_host_set_request_pm(struct ata_host_set *host_set,
+				   pm_message_t mesg, int wait)
+{
+	unsigned long flags;
+	int i, rc;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		/* Previous resume operation might still be in
+		 * progress.  Wait for PM_PENDING to clear.
+		 */
+		if (ap->flags & ATA_FLAG_PM_PENDING) {
+			ata_port_wait_eh(ap);
+			WARN_ON(ap->flags & ATA_FLAG_PM_PENDING);
+		}
+
+		/* request PM ops to EH */
+		spin_lock_irqsave(ap->lock, flags);
+
+		ap->pm_mesg = mesg;
+		if (wait) {
+			rc = 0;
+			ap->pm_result = &rc;
+		}
+
+		ap->flags |= ATA_FLAG_PM_PENDING;
+		ata_port_schedule_eh(ap);
+
+		spin_unlock_irqrestore(ap->lock, flags);
+
+		/* wait and check result */
+		if (wait) {
+			ata_port_wait_eh(ap);
+			WARN_ON(ap->flags & ATA_FLAG_PM_PENDING);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+/**
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
+	int i, j, rc;
+
+	rc = ata_host_set_request_pm(host_set, mesg, 1);
+	if (rc)
+		goto fail;
+
+	/* EH is quiescent now.  Fail if we have any ready device.
+	 * This happens if hotplug occurs between completion of device
+	 * suspension and here.
+	 */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		for (j = 0; j < ATA_MAX_DEVICES; j++) {
+			struct ata_device *dev = &ap->device[j];
+
+			if (ata_dev_ready(dev)) {
+				ata_port_printk(ap, KERN_WARNING,
+						"suspend failed, device %d "
+						"still active\n", dev->devno);
+				rc = -EBUSY;
+				goto fail;
+			}
+		}
+	}
+
+	host_set->dev->power.power_state = mesg;
+	return 0;
+
+ fail:
+	ata_host_set_resume(host_set);
+	return rc;
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
+	ata_host_set_request_pm(host_set, PMSG_ON, 0);
+	host_set->dev->power.power_state = PMSG_ON;
+}
+
 /**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
@@ -5621,20 +5732,55 @@ int pci_test_config_bits(struct pci_dev 
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
@@ -5814,6 +5960,8 @@ EXPORT_SYMBOL_GPL(sata_scr_write);
 EXPORT_SYMBOL_GPL(sata_scr_write_flush);
 EXPORT_SYMBOL_GPL(ata_port_online);
 EXPORT_SYMBOL_GPL(ata_port_offline);
+EXPORT_SYMBOL_GPL(ata_host_set_suspend);
+EXPORT_SYMBOL_GPL(ata_host_set_resume);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
@@ -5828,6 +5976,8 @@ EXPORT_SYMBOL_GPL(ata_pci_host_stop);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
+EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 EXPORT_SYMBOL_GPL(ata_pci_default_filter);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 1c2b48c..06294f0 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -47,6 +47,8 @@ #include "libata.h"
 
 static void __ata_port_freeze(struct ata_port *ap);
 static void ata_eh_finish(struct ata_port *ap);
+static void ata_eh_handle_port_suspend(struct ata_port *ap);
+static void ata_eh_handle_port_resume(struct ata_port *ap);
 
 static void ata_ering_record(struct ata_ering *ering, int is_io,
 			     unsigned int err_mask)
@@ -263,6 +265,9 @@ void ata_scsi_error(struct Scsi_Host *ho
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
+		/* process port resume request */
+		ata_eh_handle_port_resume(ap);
+
 		/* fetch & clear EH info */
 		spin_lock_irqsave(ap_lock, flags);
 
@@ -275,12 +280,15 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 		spin_unlock_irqrestore(ap_lock, flags);
 
-		/* invoke EH.  if unloading, just finish failed qcs */
-		if (!(ap->flags & ATA_FLAG_UNLOADING))
+		/* invoke EH, skip if unloading or suspended */
+		if (!(ap->flags & (ATA_FLAG_UNLOADING | ATA_FLAG_SUSPENDED)))
 			ap->ops->error_handler(ap);
 		else
 			ata_eh_finish(ap);
 
+		/* process port suspend request */
+		ata_eh_handle_port_suspend(ap);
+
 		/* Exception might have happend after ->error_handler
 		 * recovered the port but before this point.  Repeat
 		 * EH in such case.
@@ -2126,3 +2134,119 @@ void ata_do_eh(struct ata_port *ap, ata_
 	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
 	ata_eh_finish(ap);
 }
+
+/**
+ *	ata_eh_handle_port_suspend - perform port suspend operation
+ *	@ap: port to suspend
+ *
+ *	Suspend @ap.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_handle_port_suspend(struct ata_port *ap)
+{
+	unsigned long flags;
+	int rc = 0;
+
+	/* are we suspending? */
+	spin_lock_irqsave(ap->lock, flags);
+	if (!(ap->flags & ATA_FLAG_PM_PENDING) ||
+	    ap->pm_mesg.event == PM_EVENT_ON) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	WARN_ON(ap->flags & ATA_FLAG_SUSPENDED);
+
+	/* suspend */
+	ata_eh_freeze_port(ap);
+
+	if (ap->ops->port_suspend)
+		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
+
+	/* report result */
+	spin_lock_irqsave(ap->lock, flags);
+
+	ap->flags &= ~ATA_FLAG_PM_PENDING;
+	if (rc == 0)
+		ap->flags |= ATA_FLAG_SUSPENDED;
+	else
+		ata_port_schedule_eh(ap);
+
+	if (ap->pm_result) {
+		*ap->pm_result = rc;
+		ap->pm_result = NULL;
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return;
+}
+
+/**
+ *	ata_eh_handle_port_resume - perform port resume operation
+ *	@ap: port to resume
+ *
+ *	Resume @ap.
+ *
+ *	This function also waits upto one second until all devices
+ *	hanging off this port requests resume EH action.  This is to
+ *	prevent invoking EH and thus reset multiple times on resume.
+ *
+ *	On DPM resume, where some of devices might not be resumed
+ *	together, this may delay port resume upto one second, but such
+ *	DPM resumes are rare and 1 sec delay isn't too bad.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_handle_port_resume(struct ata_port *ap)
+{
+	unsigned long timeout;
+	unsigned long flags;
+	int i, rc = 0;
+
+	/* are we resuming? */
+	spin_lock_irqsave(ap->lock, flags);
+	if (!(ap->flags & ATA_FLAG_PM_PENDING) ||
+	    ap->pm_mesg.event != PM_EVENT_ON) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	/* spurious? */
+	if (!(ap->flags & ATA_FLAG_SUSPENDED))
+		goto done;
+
+	if (ap->ops->port_resume)
+		rc = ap->ops->port_resume(ap);
+
+	/* give devices time to request EH */
+	timeout = jiffies + HZ; /* 1s max */
+	while (1) {
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			struct ata_device *dev = &ap->device[i];
+			unsigned int action = ata_eh_dev_action(dev);
+
+			if ((dev->flags & ATA_DFLAG_SUSPENDED) &&
+			    !(action & ATA_EH_RESUME))
+				break;
+		}
+
+		if (i == ATA_MAX_DEVICES || time_after(jiffies, timeout))
+			break;
+		msleep(10);
+	}
+
+ done:
+	spin_lock_irqsave(ap->lock, flags);
+	ap->flags &= ~(ATA_FLAG_PM_PENDING | ATA_FLAG_SUSPENDED);
+	if (ap->pm_result) {
+		*ap->pm_result = rc;
+		ap->pm_result = NULL;
+	}
+	spin_unlock_irqrestore(ap->lock, flags);
+}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 33943e9..e840265 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -176,6 +176,11 @@ enum {
 	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
 
+	/* XXX - Bit 31 is reserved for LLDD but no LLDD is using it
+	 * ATM.  Steal it for the time being.  The following flag must
+	 * be updated once above obsolete flags are removed. */
+	ATA_FLAG_PM_PENDING	= (1 << 31), /* PM operation pending */
+
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
 
 	/* struct ata_queued_cmd flags */
@@ -540,6 +545,9 @@ struct ata_port {
 	struct list_head	eh_done_q;
 	wait_queue_head_t	eh_wait_q;
 
+	pm_message_t		pm_mesg;
+	int			*pm_result;
+
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
@@ -594,6 +602,9 @@ struct ata_port_operations {
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
 			   u32 val);
 
+	int (*port_suspend) (struct ata_port *ap, pm_message_t mesg);
+	int (*port_resume) (struct ata_port *ap);
+
 	int (*port_start) (struct ata_port *ap);
 	void (*port_stop) (struct ata_port *ap);
 
@@ -649,6 +660,8 @@ #ifdef CONFIG_PCI
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
+extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t state);
+extern void ata_pci_device_do_resume(struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
@@ -669,6 +682,9 @@ extern int ata_port_online(struct ata_po
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


