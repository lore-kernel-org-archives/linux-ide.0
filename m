From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] libata: reimplement suspend/resume support using sdev->manage_start_stop
Date: Tue, 24 Apr 2007 04:12:02 +0900
Message-ID: <20070423191202.GO10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:38257 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbXDWTMR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 15:12:17 -0400
Received: by an-out-0708.google.com with SMTP id b33so1935330ana
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 12:12:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, liml@rtr.ca, hancockr@shaw.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, linux-ide@vger.kernel.org, Stephen.Clark@seclark.us, fabio.comolli@gmail.com, a.p.zijlstra@chello.nl

Reimplement suspend/resume support using sdev->manage_start_stop.

* Device suspend/resume is now SCSI layer's responsibility and the
  code is simplified a lot.

* DPM is dropped.  This also simplifies code a lot.  Suspend/resume
  status is port-wide now.

* ata_scsi_device_suspend/resume() and ata_dev_ready() removed.

* Resume now has to wait for disk to spin up before proceeding.  I
  couldn't find easy way out as libata is in EH waiting for the
  disk to be ready and sd is waiting for EH to complete to issue
  START_STOP.

* sdev->manage_start_stop is set to 1 in ata_scsi_slave_config().
  This fixes spindown on shutdown and suspend-to-disk.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

This and the following patch should fix all the spindown problems both
on shutdown and STD.  These patches are against v2.6.21-rc7 + updates
from scsi-misc-2.6.  The git tree is available at the following URL.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=spindown
  git://htj.dyndns.org/libata-tj spindown

I'll post combined patch against 2.6.21-rc7 as a reply to this thread.
Please test the combined patch and verify it works.

Thanks.

 drivers/ata/ahci.c              |    4 -
 drivers/ata/ata_generic.c       |    6 +-
 drivers/ata/ata_piix.c          |    4 -
 drivers/ata/libata-core.c       |   39 +------
 drivers/ata/libata-eh.c         |  237 +--------------------------------------
 drivers/ata/libata-scsi.c       |  129 +---------------------
 drivers/ata/pata_ali.c          |    4 -
 drivers/ata/pata_amd.c          |    4 -
 drivers/ata/pata_atiixp.c       |    4 -
 drivers/ata/pata_cmd640.c       |    2 -
 drivers/ata/pata_cmd64x.c       |    4 -
 drivers/ata/pata_cs5520.c       |    4 -
 drivers/ata/pata_cs5530.c       |    4 -
 drivers/ata/pata_cs5535.c       |    4 -
 drivers/ata/pata_cypress.c      |    4 -
 drivers/ata/pata_efar.c         |    4 -
 drivers/ata/pata_hpt366.c       |    4 -
 drivers/ata/pata_hpt3x3.c       |    4 -
 drivers/ata/pata_it8213.c       |    4 -
 drivers/ata/pata_it821x.c       |    4 -
 drivers/ata/pata_ixp4xx_cf.c    |    2 +-
 drivers/ata/pata_jmicron.c      |    4 -
 drivers/ata/pata_marvell.c      |    4 -
 drivers/ata/pata_mpc52xx.c      |    4 -
 drivers/ata/pata_mpiix.c        |    4 -
 drivers/ata/pata_netcell.c      |    4 -
 drivers/ata/pata_ns87410.c      |    4 -
 drivers/ata/pata_oldpiix.c      |    4 -
 drivers/ata/pata_opti.c         |    4 -
 drivers/ata/pata_optidma.c      |    4 -
 drivers/ata/pata_pdc202xx_old.c |    4 -
 drivers/ata/pata_radisys.c      |    4 -
 drivers/ata/pata_rz1000.c       |    6 +-
 drivers/ata/pata_sc1200.c       |    4 -
 drivers/ata/pata_scc.c          |    4 -
 drivers/ata/pata_serverworks.c  |    4 -
 drivers/ata/pata_sil680.c       |    4 -
 drivers/ata/pata_sis.c          |    4 -
 drivers/ata/pata_triflex.c      |    4 -
 drivers/ata/pata_via.c          |    4 -
 drivers/ata/sata_inic162x.c     |    4 -
 drivers/ata/sata_nv.c           |    8 --
 drivers/ata/sata_sil.c          |    4 -
 drivers/ata/sata_sil24.c        |    4 -
 include/linux/libata.h          |   14 +--
 45 files changed, 14 insertions(+), 573 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7c61bc7..72c286e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -246,10 +246,6 @@ static struct scsi_host_template ahci_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static const struct ata_port_operations ahci_ops = {
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 92a491d..0f19e32 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -54,7 +54,7 @@ static int generic_set_mode(struct ata_port *ap, struct ata_device **unused)
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		if (ata_dev_ready(dev)) {
+		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
 			dev->dma_mode = XFER_MW_DMA_0;
@@ -90,10 +90,6 @@ static struct scsi_host_template generic_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations generic_port_ops = {
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 55d306a..8421742 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -275,10 +275,6 @@ static struct scsi_host_template piix_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations piix_pata_ops = {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6d0a946..1c00526 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2823,7 +2823,7 @@ int ata_do_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 		dev = &ap->device[i];
 
 		/* don't update suspended devices' xfer mode */
-		if (!ata_dev_ready(dev))
+		if (!ata_dev_enabled(dev))
 			continue;
 
 		rc = ata_dev_set_mode(dev);
@@ -5758,37 +5758,11 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
  */
 int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
 {
-	int i, j, rc;
+	int rc;
 
 	rc = ata_host_request_pm(host, mesg, 0, ATA_EHI_QUIET, 1);
-	if (rc)
-		goto fail;
-
-	/* EH is quiescent now.  Fail if we have any ready device.
-	 * This happens if hotplug occurs between completion of device
-	 * suspension and here.
-	 */
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		for (j = 0; j < ATA_MAX_DEVICES; j++) {
-			struct ata_device *dev = &ap->device[j];
-
-			if (ata_dev_ready(dev)) {
-				ata_port_printk(ap, KERN_WARNING,
-						"suspend failed, device %d "
-						"still active\n", dev->devno);
-				rc = -EBUSY;
-				goto fail;
-			}
-		}
-	}
-
-	host->dev->power.power_state = mesg;
-	return 0;
-
- fail:
-	ata_host_resume(host);
+	if (rc == 0)
+		host->dev->power.power_state = mesg;
 	return rc;
 }
 
@@ -6801,11 +6775,6 @@ EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
-#ifdef CONFIG_PM
-EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
-EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
-#endif /* CONFIG_PM */
-
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 EXPORT_SYMBOL_GPL(ata_port_abort);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0dbee55..59d0fb5 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -55,29 +55,12 @@ static void ata_eh_finish(struct ata_port *ap);
 #ifdef CONFIG_PM
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
 static void ata_eh_handle_port_resume(struct ata_port *ap);
-static int ata_eh_suspend(struct ata_port *ap,
-			  struct ata_device **r_failed_dev);
-static void ata_eh_prep_resume(struct ata_port *ap);
-static int ata_eh_resume(struct ata_port *ap, struct ata_device **r_failed_dev);
 #else /* CONFIG_PM */
 static void ata_eh_handle_port_suspend(struct ata_port *ap)
 { }
 
 static void ata_eh_handle_port_resume(struct ata_port *ap)
 { }
-
-static int ata_eh_suspend(struct ata_port *ap, struct ata_device **r_failed_dev)
-{
-	return 0;
-}
-
-static void ata_eh_prep_resume(struct ata_port *ap)
-{ }
-
-static int ata_eh_resume(struct ata_port *ap, struct ata_device **r_failed_dev)
-{
-	return 0;
-}
 #endif /* CONFIG_PM */
 
 static void ata_ering_record(struct ata_ering *ering, int is_io,
@@ -1764,7 +1747,7 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 		if (ehc->i.flags & ATA_EHI_DID_RESET)
 			readid_flags |= ATA_READID_POSTRESET;
 
-		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
+		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
 			if (ata_port_offline(ap)) {
 				rc = -EIO;
 				goto err;
@@ -1841,166 +1824,6 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 	return rc;
 }
 
-#ifdef CONFIG_PM
-/**
- *	ata_eh_suspend - handle suspend EH action
- *	@ap: target host port
- *	@r_failed_dev: result parameter to indicate failing device
- *
- *	Handle suspend EH action.  Disk devices are spinned down and
- *	other types of devices are just marked suspended.  Once
- *	suspended, no EH action to the device is allowed until it is
- *	resumed.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno otherwise
- */
-static int ata_eh_suspend(struct ata_port *ap, struct ata_device **r_failed_dev)
-{
-	struct ata_device *dev;
-	int i, rc = 0;
-
-	DPRINTK("ENTER\n");
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		unsigned long flags;
-		unsigned int action, err_mask;
-
-		dev = &ap->device[i];
-		action = ata_eh_dev_action(dev);
-
-		if (!ata_dev_enabled(dev) || !(action & ATA_EH_SUSPEND))
-			continue;
-
-		WARN_ON(dev->flags & ATA_DFLAG_SUSPENDED);
-
-		ata_eh_about_to_do(ap, dev, ATA_EH_SUSPEND);
-
-		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
-			/* flush cache */
-			rc = ata_flush_cache(dev);
-			if (rc)
-				break;
-
-			/* spin down */
-			err_mask = ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
-			if (err_mask) {
-				ata_dev_printk(dev, KERN_ERR, "failed to "
-					       "spin down (err_mask=0x%x)\n",
-					       err_mask);
-				rc = -EIO;
-				break;
-			}
-		}
-
-		spin_lock_irqsave(ap->lock, flags);
-		dev->flags |= ATA_DFLAG_SUSPENDED;
-		spin_unlock_irqrestore(ap->lock, flags);
-
-		ata_eh_done(ap, dev, ATA_EH_SUSPEND);
-	}
-
-	if (rc)
-		*r_failed_dev = dev;
-
-	DPRINTK("EXIT\n");
-	return rc;
-}
-
-/**
- *	ata_eh_prep_resume - prep for resume EH action
- *	@ap: target host port
- *
- *	Clear SUSPENDED in preparation for scheduled resume actions.
- *	This allows other parts of EH to access the devices being
- *	resumed.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- */
-static void ata_eh_prep_resume(struct ata_port *ap)
-{
-	struct ata_device *dev;
-	unsigned long flags;
-	int i;
-
-	DPRINTK("ENTER\n");
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		unsigned int action;
-
-		dev = &ap->device[i];
-		action = ata_eh_dev_action(dev);
-
-		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
-			continue;
-
-		spin_lock_irqsave(ap->lock, flags);
-		dev->flags &= ~ATA_DFLAG_SUSPENDED;
-		spin_unlock_irqrestore(ap->lock, flags);
-	}
-
-	DPRINTK("EXIT\n");
-}
-
-/**
- *	ata_eh_resume - handle resume EH action
- *	@ap: target host port
- *	@r_failed_dev: result parameter to indicate failing device
- *
- *	Handle resume EH action.  Target devices are already reset and
- *	revalidated.  Spinning up is the only operation left.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno otherwise
- */
-static int ata_eh_resume(struct ata_port *ap, struct ata_device **r_failed_dev)
-{
-	struct ata_device *dev;
-	int i, rc = 0;
-
-	DPRINTK("ENTER\n");
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		unsigned int action, err_mask;
-
-		dev = &ap->device[i];
-		action = ata_eh_dev_action(dev);
-
-		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
-			continue;
-
-		ata_eh_about_to_do(ap, dev, ATA_EH_RESUME);
-
-		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
-			err_mask = ata_do_simple_cmd(dev,
-						     ATA_CMD_IDLEIMMEDIATE);
-			if (err_mask) {
-				ata_dev_printk(dev, KERN_ERR, "failed to "
-					       "spin up (err_mask=0x%x)\n",
-					       err_mask);
-				rc = -EIO;
-				break;
-			}
-		}
-
-		ata_eh_done(ap, dev, ATA_EH_RESUME);
-	}
-
-	if (rc)
-		*r_failed_dev = dev;
-
-	DPRINTK("EXIT\n");
-	return 0;
-}
-#endif /* CONFIG_PM */
-
 static int ata_port_nr_enabled(struct ata_port *ap)
 {
 	int i, cnt = 0;
@@ -2026,17 +1849,6 @@ static int ata_eh_skip_recovery(struct ata_port *ap)
 	struct ata_eh_context *ehc = &ap->eh_context;
 	int i;
 
-	/* skip if all possible devices are suspended */
-	for (i = 0; i < ata_port_max_devices(ap); i++) {
-		struct ata_device *dev = &ap->device[i];
-
-		if (!(dev->flags & ATA_DFLAG_SUSPENDED))
-			break;
-	}
-
-	if (i == ata_port_max_devices(ap))
-		return 1;
-
 	/* thaw frozen port, resume link and recover failed devices */
 	if ((ap->pflags & ATA_PFLAG_FROZEN) ||
 	    (ehc->i.flags & ATA_EHI_RESUME_LINK) || ata_port_nr_enabled(ap))
@@ -2116,9 +1928,6 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	if (ap->pflags & ATA_PFLAG_UNLOADING)
 		goto out;
 
-	/* prep for resume */
-	ata_eh_prep_resume(ap);
-
 	/* skip EH if possible. */
 	if (ata_eh_skip_recovery(ap))
 		ehc->i.action = 0;
@@ -2146,11 +1955,6 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	if (rc)
 		goto dev_fail;
 
-	/* resume devices */
-	rc = ata_eh_resume(ap, &dev);
-	if (rc)
-		goto dev_fail;
-
 	/* configure transfer mode if necessary */
 	if (ehc->i.flags & ATA_EHI_SETMODE) {
 		rc = ata_set_mode(ap, &dev);
@@ -2159,11 +1963,6 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		ehc->i.flags &= ~ATA_EHI_SETMODE;
 	}
 
-	/* suspend devices */
-	rc = ata_eh_suspend(ap, &dev);
-	if (rc)
-		goto dev_fail;
-
 	goto out;
 
  dev_fail:
@@ -2359,22 +2158,13 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
  *
  *	Resume @ap.
  *
- *	This function also waits upto one second until all devices
- *	hanging off this port requests resume EH action.  This is to
- *	prevent invoking EH and thus reset multiple times on resume.
- *
- *	On DPM resume, where some of devices might not be resumed
- *	together, this may delay port resume upto one second, but such
- *	DPM resumes are rare and 1 sec delay isn't too bad.
- *
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
 static void ata_eh_handle_port_resume(struct ata_port *ap)
 {
-	unsigned long timeout;
 	unsigned long flags;
-	int i, rc = 0;
+	int rc = 0;
 
 	/* are we resuming? */
 	spin_lock_irqsave(ap->lock, flags);
@@ -2385,31 +2175,12 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 	}
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	/* spurious? */
-	if (!(ap->pflags & ATA_PFLAG_SUSPENDED))
-		goto done;
+	WARN_ON(!(ap->pflags & ATA_PFLAG_SUSPENDED));
 
 	if (ap->ops->port_resume)
 		rc = ap->ops->port_resume(ap);
 
-	/* give devices time to request EH */
-	timeout = jiffies + HZ; /* 1s max */
-	while (1) {
-		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			struct ata_device *dev = &ap->device[i];
-			unsigned int action = ata_eh_dev_action(dev);
-
-			if ((dev->flags & ATA_DFLAG_SUSPENDED) &&
-			    !(action & ATA_EH_RESUME))
-				break;
-		}
-
-		if (i == ATA_MAX_DEVICES || time_after(jiffies, timeout))
-			break;
-		msleep(10);
-	}
-
- done:
+	/* report result */
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags &= ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
 	if (ap->pm_result) {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 9afba2b..8f80019 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -510,133 +510,6 @@ static void ata_dump_status(unsigned id, struct ata_taskfile *tf)
 	}
 }
 
-#ifdef CONFIG_PM
-/**
- *	ata_scsi_device_suspend - suspend ATA device associated with sdev
- *	@sdev: the SCSI device to suspend
- *	@mesg: target power management message
- *
- *	Request suspend EH action on the ATA device associated with
- *	@sdev and wait for the operation to complete.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t mesg)
-{
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
-	unsigned long flags;
-	unsigned int action;
-	int rc = 0;
-
-	if (!dev)
-		goto out;
-
-	spin_lock_irqsave(ap->lock, flags);
-
-	/* wait for the previous resume to complete */
-	while (dev->flags & ATA_DFLAG_SUSPENDED) {
-		spin_unlock_irqrestore(ap->lock, flags);
-		ata_port_wait_eh(ap);
-		spin_lock_irqsave(ap->lock, flags);
-	}
-
-	/* if @sdev is already detached, nothing to do */
-	if (sdev->sdev_state == SDEV_OFFLINE ||
-	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
-		goto out_unlock;
-
-	/* request suspend */
-	action = ATA_EH_SUSPEND;
-	if (mesg.event != PM_EVENT_SUSPEND)
-		action |= ATA_EH_PM_FREEZE;
-	ap->eh_info.dev_action[dev->devno] |= action;
-	ap->eh_info.flags |= ATA_EHI_QUIET;
-	ata_port_schedule_eh(ap);
-
-	spin_unlock_irqrestore(ap->lock, flags);
-
-	/* wait for EH to do the job */
-	ata_port_wait_eh(ap);
-
-	spin_lock_irqsave(ap->lock, flags);
-
-	/* If @sdev is still attached but the associated ATA device
-	 * isn't suspended, the operation failed.
-	 */
-	if (sdev->sdev_state != SDEV_OFFLINE &&
-	    sdev->sdev_state != SDEV_CANCEL && sdev->sdev_state != SDEV_DEL &&
-	    !(dev->flags & ATA_DFLAG_SUSPENDED))
-		rc = -EIO;
-
- out_unlock:
-	spin_unlock_irqrestore(ap->lock, flags);
- out:
-	if (rc == 0)
-		sdev->sdev_gendev.power.power_state = mesg;
-	return rc;
-}
-
-/**
- *	ata_scsi_device_resume - resume ATA device associated with sdev
- *	@sdev: the SCSI device to resume
- *
- *	Request resume EH action on the ATA device associated with
- *	@sdev and return immediately.  This enables parallel
- *	wakeup/spinup of devices.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- *
- *	RETURNS:
- *	0.
- */
-int ata_scsi_device_resume(struct scsi_device *sdev)
-{
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
-	struct ata_eh_info *ehi = &ap->eh_info;
-	unsigned long flags;
-	unsigned int action;
-
-	if (!dev)
-		goto out;
-
-	spin_lock_irqsave(ap->lock, flags);
-
-	/* if @sdev is already detached, nothing to do */
-	if (sdev->sdev_state == SDEV_OFFLINE ||
-	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
-		goto out_unlock;
-
-	/* request resume */
-	action = ATA_EH_RESUME;
-	if (sdev->sdev_gendev.power.power_state.event == PM_EVENT_SUSPEND)
-		__ata_ehi_hotplugged(ehi);
-	else
-		action |= ATA_EH_PM_FREEZE | ATA_EH_SOFTRESET;
-	ehi->dev_action[dev->devno] |= action;
-
-	/* We don't want autopsy and verbose EH messages.  Disable
-	 * those if we're the only device on this link.
-	 */
-	if (ata_port_max_devices(ap) == 1)
-		ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
-
-	ata_port_schedule_eh(ap);
-
- out_unlock:
-	spin_unlock_irqrestore(ap->lock, flags);
- out:
-	sdev->sdev_gendev.power.power_state = PMSG_ON;
-	return 0;
-}
-#endif /* CONFIG_PM */
-
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@id: ATA device number
@@ -929,6 +802,8 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
 
 	blk_queue_max_phys_segments(sdev->request_queue, LIBATA_MAX_PRD);
 
+	sdev->manage_start_stop = 1;
+
 	if (dev)
 		ata_scsi_dev_config(sdev, dev);
 
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index d40edeb..48c7531 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -291,10 +291,6 @@ static struct scsi_host_template ali_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 /*
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 5a77e4e..2bf9ade 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -323,10 +323,6 @@ static struct scsi_host_template amd_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations amd33_port_ops = {
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 39c871a..b4048f0 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -229,10 +229,6 @@ static struct scsi_host_template atiixp_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations atiixp_port_ops = {
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index ab9468d..c876d77 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -181,8 +181,6 @@ static struct scsi_host_template cmd640_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations cmd640_port_ops = {
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 3989cc5..3e02c6a 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -266,10 +266,6 @@ static struct scsi_host_template cmd64x_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations cmd64x_port_ops = {
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 79bef0d..83bcc5b 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -155,10 +155,6 @@ static struct scsi_host_template cs5520_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations cs5520_port_ops = {
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 29642d5..637d8b3 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -176,10 +176,6 @@ static struct scsi_host_template cs5530_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations cs5530_port_ops = {
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 08cccc9..54586ac 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -172,10 +172,6 @@ static struct scsi_host_template cs5535_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations cs5535_port_ops = {
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index 6ec049c..30e5c54 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -125,10 +125,6 @@ static struct scsi_host_template cy82c693_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations cy82c693_port_ops = {
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index a321685..38411f2 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -246,10 +246,6 @@ static struct scsi_host_template efar_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations efar_ops = {
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 93cfa6d..c412a9a 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -331,10 +331,6 @@ static struct scsi_host_template hpt36x_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 /*
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index ac28ec8..84c636b 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -100,10 +100,6 @@ static struct scsi_host_template hpt3x3_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations hpt3x3_port_ops = {
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 011306e..e1bd263 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -255,10 +255,6 @@ static struct scsi_host_template it8213_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations it8213_ops = {
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index f1f8cec..8e565a5 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -620,10 +620,6 @@ static struct scsi_host_template it821x_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations it821x_smart_port_ops = {
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 420c343..b994351 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -31,7 +31,7 @@ static int ixp4xx_set_mode(struct ata_port *ap, struct ata_device **error)
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		if (ata_dev_ready(dev)) {
+		if (ata_dev_enabled(dev)) {
 			ata_dev_printk(dev, KERN_INFO, "configured for PIO0\n");
 			dev->pio_mode = XFER_PIO_0;
 			dev->xfer_mode = XFER_PIO_0;
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 43763c9..e3f6f5d 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -137,10 +137,6 @@ static struct scsi_host_template jmicron_sht = {
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static const struct ata_port_operations jmicron_ops = {
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index d9b94a1..4c282ab 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -104,10 +104,6 @@ static struct scsi_host_template marvell_sht = {
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations marvell_ops = {
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 9587a89..368fac7 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -280,10 +280,6 @@ static struct scsi_host_template mpc52xx_ata_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static struct ata_port_operations mpc52xx_ata_port_ops = {
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 987c5fa..2858927 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -164,10 +164,6 @@ static struct scsi_host_template mpiix_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations mpiix_port_ops = {
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index dbba5b7..f15eb34 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -37,10 +37,6 @@ static struct scsi_host_template netcell_sht = {
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations netcell_ops = {
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 078aeda..2147172 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -156,10 +156,6 @@ static struct scsi_host_template ns87410_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations ns87410_port_ops = {
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index dea4690..9cc1d1e 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -232,10 +232,6 @@ static struct scsi_host_template oldpiix_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations oldpiix_pata_ops = {
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 13b63e2..af00c26 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -177,10 +177,6 @@ static struct scsi_host_template opti_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations opti_port_ops = {
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index b70e04c..d1569a7 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -362,10 +362,6 @@ static struct scsi_host_template optidma_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations optidma_port_ops = {
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index ee636be..3e204c3 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -244,10 +244,6 @@ static struct scsi_host_template pdc202xx_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations pdc2024x_port_ops = {
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 1c54673..bc01b17 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -200,10 +200,6 @@ static struct scsi_host_template radisys_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations radisys_pata_ops = {
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 85c4529..97785b4 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -40,7 +40,7 @@ static int rz1000_set_mode(struct ata_port *ap, struct ata_device **unused)
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		if (ata_dev_ready(dev)) {
+		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
 			dev->xfer_mode = XFER_PIO_0;
@@ -69,10 +69,6 @@ static struct scsi_host_template rz1000_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations rz1000_port_ops = {
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 66e8ff4..2af9f8c 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -194,10 +194,6 @@ static struct scsi_host_template sc1200_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations sc1200_port_ops = {
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 5df354d..243130e 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -984,10 +984,6 @@ static struct scsi_host_template scc_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations scc_pata_ops = {
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 3956ef2..fdd9a63 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -313,10 +313,6 @@ static struct scsi_host_template serverworks_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations serverworks_osb4_port_ops = {
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 6770820..8978186 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -230,10 +230,6 @@ static struct scsi_host_template sil680_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static struct ata_port_operations sil680_port_ops = {
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index fc260d9..25f3b70 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -520,10 +520,6 @@ static struct scsi_host_template sis_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations sis_133_ops = {
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index e618ffd..33a1663 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -192,10 +192,6 @@ static struct scsi_host_template triflex_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations triflex_port_ops = {
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 96b7179..969b98f 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -300,10 +300,6 @@ static struct scsi_host_template via_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static struct ata_port_operations via_port_ops = {
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index f099a1d..4c12d92 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -135,10 +135,6 @@ static struct scsi_host_template inic_sht = {
 	.slave_configure	= inic_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static const int scr_map[] = {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 0216974..087f84b 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -323,10 +323,6 @@ static struct scsi_host_template nv_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static struct scsi_host_template nv_adma_sht = {
@@ -345,10 +341,6 @@ static struct scsi_host_template nv_adma_sht = {
 	.slave_configure	= nv_adma_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static const struct ata_port_operations nv_generic_ops = {
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 0a1e417..e8483aa 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -182,10 +182,6 @@ static struct scsi_host_template sil_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static const struct ata_port_operations sil_ops = {
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index e6223ba..b1945e6 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -380,10 +380,6 @@ static struct scsi_host_template sil24_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend		= ata_scsi_device_suspend,
-	.resume			= ata_scsi_device_resume,
-#endif
 };
 
 static const struct ata_port_operations sil24_ops = {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 73b86dd..6ef4055 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -140,7 +140,6 @@ enum {
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */
 	ATA_DFLAG_NCQ_OFF	= (1 << 9), /* device limited to non-NCQ mode */
-	ATA_DFLAG_SUSPENDED	= (1 << 10), /* device suspended */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 16),
@@ -268,13 +267,9 @@ enum {
 	ATA_EH_REVALIDATE	= (1 << 0),
 	ATA_EH_SOFTRESET	= (1 << 1),
 	ATA_EH_HARDRESET	= (1 << 2),
-	ATA_EH_SUSPEND		= (1 << 3),
-	ATA_EH_RESUME		= (1 << 4),
-	ATA_EH_PM_FREEZE	= (1 << 5),
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
-	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_SUSPEND |
-				  ATA_EH_RESUME | ATA_EH_PM_FREEZE,
+	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
@@ -740,8 +735,6 @@ extern int sata_scr_write_flush(struct ata_port *ap, int reg, u32 val);
 extern int ata_port_online(struct ata_port *ap);
 extern int ata_port_offline(struct ata_port *ap);
 #ifdef CONFIG_PM
-extern int ata_scsi_device_resume(struct scsi_device *);
-extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t mesg);
 extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
 #endif
@@ -1016,11 +1009,6 @@ static inline unsigned int ata_dev_absent(const struct ata_device *dev)
 	return ata_class_absent(dev->class);
 }
 
-static inline unsigned int ata_dev_ready(const struct ata_device *dev)
-{
-	return ata_dev_enabled(dev) && !(dev->flags & ATA_DFLAG_SUSPENDED);
-}
-
 /*
  * port helpers
  */
-- 
1.5.0.3

