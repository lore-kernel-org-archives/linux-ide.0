From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/11] libata: reimplement per-dev PM
Date: Mon, 3 Jul 2006 16:07:26 +0900
Message-ID: <1151910446178-git-send-email-htejun@gmail.com>
References: <11519104451998-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:59460 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750911AbWGCHGz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 03:06:55 -0400
Received: by wx-out-0102.google.com with SMTP id t10so500111wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Jul 2006 00:06:54 -0700 (PDT)
In-Reply-To: <11519104451998-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Reimplement per-dev PM.  The original implementation directly put the
device into suspended mode and didn't synchronize w/ EH operations
including hotplug.  This patch reimplements ata_scsi_device_suspend()
and ata_scsi_device_resume() such that they request EH to perform the
respective operations.  Both functions synchronize with hotplug such
that it doesn't operate on detached devices.

Suspend waits for completion but resume just issues request and
returns.  This allows parallel wake up of devices and thus speeds up
system resume.

Due to sdev detach synchronization, it's not feasible to separate out
EH requesting from sdev handling; thus, ata_device_suspend/resume()
are removed and everything is implemented in the respective
libata-scsi functions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   84 -------------------------------
 drivers/scsi/libata-scsi.c |  121 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/libata.h     |    2 -
 3 files changed, 115 insertions(+), 92 deletions(-)

99372db3336092bfb6d6dd3663a5d8dfec43da6b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7b21803..9703cbf 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5001,88 +5001,6 @@ int ata_flush_cache(struct ata_device *d
 	return 0;
 }
 
-static int ata_standby_drive(struct ata_device *dev)
-{
-	unsigned int err_mask;
-
-	err_mask = ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
-	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to standby drive "
-			       "(err_mask=0x%x)\n", err_mask);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int ata_start_drive(struct ata_device *dev)
-{
-	unsigned int err_mask;
-
-	err_mask = ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
-	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to start drive "
-			       "(err_mask=0x%x)\n", err_mask);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/**
- *	ata_device_resume - wakeup a previously suspended devices
- *	@dev: the device to resume
- *
- *	Kick the drive back into action, by sending it an idle immediate
- *	command and making sure its transfer mode matches between drive
- *	and host.
- *
- */
-int ata_device_resume(struct ata_device *dev)
-{
-	struct ata_port *ap = dev->ap;
-
-	if (ap->pflags & ATA_PFLAG_SUSPENDED) {
-		struct ata_device *failed_dev;
-
-		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
-		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
-
-		ap->pflags &= ~ATA_PFLAG_SUSPENDED;
-		while (ata_set_mode(ap, &failed_dev))
-			ata_dev_disable(failed_dev);
-	}
-	if (!ata_dev_enabled(dev))
-		return 0;
-	if (dev->class == ATA_DEV_ATA)
-		ata_start_drive(dev);
-
-	return 0;
-}
-
-/**
- *	ata_device_suspend - prepare a device for suspend
- *	@dev: the device to suspend
- *	@state: target power management state
- *
- *	Flush the cache on the drive, if appropriate, then issue a
- *	standbynow command.
- */
-int ata_device_suspend(struct ata_device *dev, pm_message_t state)
-{
-	struct ata_port *ap = dev->ap;
-
-	if (!ata_dev_enabled(dev))
-		return 0;
-	if (dev->class == ATA_DEV_ATA)
-		ata_flush_cache(dev);
-
-	if (state.event != PM_EVENT_FREEZE)
-		ata_standby_drive(dev);
-	ap->pflags |= ATA_PFLAG_SUSPENDED;
-	return 0;
-}
-
 /**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
@@ -5938,8 +5856,6 @@ EXPORT_SYMBOL_GPL(ata_pci_default_filter
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
-EXPORT_SYMBOL_GPL(ata_device_suspend);
-EXPORT_SYMBOL_GPL(ata_device_resume);
 EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 1ed89d8..31d30c6 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -399,20 +399,129 @@ void ata_dump_status(unsigned id, struct
 	}
 }
 
-int ata_scsi_device_resume(struct scsi_device *sdev)
+/**
+ *	ata_scsi_device_suspend - suspend ATA device associated with sdev
+ *	@sdev: the SCSI device to suspend
+ *	@state: target power management state
+ *
+ *	Request suspend EH action on the ATA device associated with
+ *	@sdev and wait for the operation to complete.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
+	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
+	unsigned long flags;
+	unsigned int action;
+	int rc = 0;
+
+	if (!dev)
+		goto out;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/* wait for the previous resume to complete */
+	while (dev->flags & ATA_DFLAG_SUSPENDED) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		ata_port_wait_eh(ap);
+		spin_lock_irqsave(ap->lock, flags);
+	}
+
+	/* if @sdev is already detached, nothing to do */
+	if (sdev->sdev_state == SDEV_OFFLINE ||
+	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
+		goto out_unlock;
+
+	/* request suspend */
+	action = ATA_EH_SUSPEND;
+	if (state.event != PM_EVENT_SUSPEND)
+		action |= ATA_EH_PM_FREEZE;
+	ap->eh_info.dev_action[dev->devno] |= action;
+	ap->eh_info.flags |= ATA_EHI_QUIET;
+	ata_port_schedule_eh(ap);
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	/* wait for EH to do the job */
+	ata_port_wait_eh(ap);
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/* If @sdev is still attached but the associated ATA device
+	 * isn't suspended, the operation failed.
+	 */
+	if (sdev->sdev_state != SDEV_OFFLINE &&
+	    sdev->sdev_state != SDEV_CANCEL && sdev->sdev_state != SDEV_DEL &&
+	    !(dev->flags & ATA_DFLAG_SUSPENDED))
+		rc = -EIO;
 
-	return ata_device_resume(dev);
+ out_unlock:
+	spin_unlock_irqrestore(ap->lock, flags);
+ out:
+	if (rc == 0)
+		sdev->sdev_gendev.power.power_state = state;
+	return rc;
 }
 
-int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
+/**
+ *	ata_scsi_device_resume - resume ATA device associated with sdev
+ *	@sdev: the SCSI device to resume
+ *
+ *	Request resume EH action on the ATA device associated with
+ *	@sdev and return immediately.  This enables parallel
+ *	wakeup/spinup of devices.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0.
+ */
+int ata_scsi_device_resume(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
+	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
+	struct ata_eh_info *ehi = &ap->eh_info;
+	unsigned long flags;
+	unsigned int action;
+
+	if (!dev)
+		goto out;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/* if @sdev is already detached, nothing to do */
+	if (sdev->sdev_state == SDEV_OFFLINE ||
+	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
+		goto out_unlock;
 
-	return ata_device_suspend(dev, state);
+	/* request resume */
+	action = ATA_EH_RESUME;
+	if (sdev->sdev_gendev.power.power_state.event == PM_EVENT_SUSPEND)
+		__ata_ehi_hotplugged(ehi);
+	else
+		action |= ATA_EH_PM_FREEZE | ATA_EH_SOFTRESET;
+	ehi->dev_action[dev->devno] |= action;
+
+	/* We don't want autopsy and verbose EH messages.  Disable
+	 * those if we're the only device on this link.
+	 */
+	if (ata_port_max_devices(ap) == 1)
+		ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
+
+	ata_port_schedule_eh(ap);
+
+ out_unlock:
+	spin_unlock_irqrestore(ap->lock, flags);
+ out:
+	sdev->sdev_gendev.power.power_state = PMSG_ON;
+	return 0;
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 363c750..5ac2626 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -687,8 +687,6 @@ extern int ata_port_online(struct ata_po
 extern int ata_port_offline(struct ata_port *ap);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
-extern int ata_device_resume(struct ata_device *);
-extern int ata_device_suspend(struct ata_device *, pm_message_t state);
 extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
-- 
1.3.2


