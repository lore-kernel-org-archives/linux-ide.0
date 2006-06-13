From: Tejun Heo <htejun@gmail.com>
Subject: rolled up patch for new Power Management for libata
Date: Tue, 13 Jun 2006 18:09:45 +0900
Message-ID: <20060613090945.GA8931@htj.dyndns.org>
References: <11501274284082-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:22340 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750799AbWFMJJw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 05:09:52 -0400
Received: by py-out-1112.google.com with SMTP id x31so59126pye
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 02:09:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

This is a rolled up version of new-pm patchset for testing as
requested by Jens.

This patch is against

	libata-dev #upstream (aeb2ecd6096182cc080d37679080c0f088dcd4a4)

And contains the following patches

	upstream (aeb2ecd6096182cc080d37679080c0f088dcd4a4)
	+ [1] kill-ATA_FLAG_SRST patch
	+ [2] shift-ATA_FLAG_-bits patch
	+ [3] new-power-management-for-libata patchset

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=115012501502940&w=2
[2] http://marc.theaimsgroup.com/?l=linux-ide&m=115012349728574&w=2
[3] http://marc.theaimsgroup.com/?l=linux-ide&m=115012753926326&w=2

The git tree containing these changes can be accessed at the following URL.

	http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=new-pm
	git://htj.dyndns.org/libata-tj new-pm

Patch follows...


diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 521b718..75aa47f 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -220,8 +220,6 @@ static struct scsi_host_template piix_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations piix_pata_ops = {
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 4bc0537..13fab97 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -1076,10 +1076,21 @@ int ata_pci_init_one (struct pci_dev *pd
 
 	/* FIXME: check ata_device_add return */
 	if (legacy_mode) {
-		if (legacy_mode & (1 << 0))
+		struct device *dev = &pdev->dev;
+		struct ata_host_set *host_set = NULL;
+
+		if (legacy_mode & (1 << 0)) {
 			ata_device_add(probe_ent);
-		if (legacy_mode & (1 << 1))
+			host_set = dev_get_drvdata(dev);
+		}
+
+		if (legacy_mode & (1 << 1)) {
 			ata_device_add(probe_ent2);
+			if (host_set) {
+				host_set->next = dev_get_drvdata(dev);
+				dev_set_drvdata(dev, host_set);
+			}
+		}
 	} else
 		ata_device_add(probe_ent);
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 014855e..0ee7ab4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -70,6 +70,7 @@ static unsigned int ata_dev_init_params(
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
+static int ata_host_set_resume(struct ata_host_set *host_set);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -1123,6 +1124,32 @@ unsigned ata_exec_internal(struct ata_de
 	return err_mask;
 }
 
+/*	ata_do_simple_cmd - execute simple internal command
+ *	@dev: Device to which the command is sent
+ *	@cmd: Opcode to execute
+ *
+ *	Execute a 'simple' command, that only consists of the opcode
+ *	'cmd' itself, without filling any other registers
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, AC_ERR_* mask on failure
+ */
+unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
+{
+	struct ata_taskfile tf;
+
+	ata_tf_init(dev, &tf);
+
+	tf.command = cmd;
+	tf.flags |= ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+
+	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+}
+
 /**
  *	ata_pio_need_iordy	-	check if iordy needed
  *	@adev: ATA device
@@ -2380,7 +2407,7 @@ void ata_bus_reset(struct ata_port *ap)
 	ap->ops->dev_select(ap, 0);
 
 	/* issue bus reset */
-	if (ap->flags & ATA_FLAG_SRST)
+	if (!(ap->flags & ATA_FLAG_SATA_RESET))
 		if (ata_bus_softreset(ap, devmask))
 			goto err_out;
 
@@ -2406,13 +2433,11 @@ void ata_bus_reset(struct ata_port *ap)
 	    (ap->device[1].class == ATA_DEV_NONE))
 		goto err_out;
 
-	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
-		/* set up device control for ATA_FLAG_SATA_RESET */
-		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		else
-			outb(ap->ctl, ioaddr->ctl_addr);
-	}
+	/* set up device control for ATA_FLAG_SATA_RESET */
+	if (ap->flags & ATA_FLAG_MMIO)
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
+	else
+		outb(ap->ctl, ioaddr->ctl_addr);
 
 	DPRINTK("EXIT\n");
 	return;
@@ -4926,104 +4951,101 @@ int ata_port_offline(struct ata_port *ap
 	return 0;
 }
 
-/*
- * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
- * without filling any other registers
- */
-static int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
+static void ata_host_set_request_pm(struct ata_host_set *host_set,
+				    pm_message_t mesg)
 {
-	struct ata_taskfile tf;
-	int err;
+	int i;
 
-	ata_tf_init(dev, &tf);
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+		unsigned long flags;
 
-	tf.command = cmd;
-	tf.flags |= ATA_TFLAG_DEVICE;
-	tf.protocol = ATA_PROT_NODATA;
+		spin_lock_irqsave(&ap->host_set->lock, flags);
 
-	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-	if (err)
-		ata_dev_printk(dev, KERN_ERR, "%s: ata command failed: %d\n",
-			       __FUNCTION__, err);
+		/* Previous resume operation might still be in
+		 * progress.  Wait for PM_PENDING to clear.
+		 */
+		while (ap->flags & ATA_FLAG_PM_PENDING) {
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
+			ata_port_wait_eh(ap);
+			spin_lock_irqsave(&ap->host_set->lock, flags);
+		}
+
+		/* request PM ops to EH */
+		ap->flags |= ATA_FLAG_PM_PENDING;
+		ap->pm_mesg = mesg;
+		ap->pm_result = 0;
+		ata_port_schedule_eh(ap);
 
-	return err;
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	}
 }
 
-static int ata_flush_cache(struct ata_device *dev)
+static int ata_host_set_wait_pm(struct ata_host_set *host_set)
 {
-	u8 cmd;
+	int i, rc = 0;
 
-	if (!ata_try_flush_cache(dev))
-		return 0;
-
-	if (ata_id_has_flush_ext(dev->id))
-		cmd = ATA_CMD_FLUSH_EXT;
-	else
-		cmd = ATA_CMD_FLUSH;
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
 
-	return ata_do_simple_cmd(dev, cmd);
-}
+		ata_port_wait_eh(ap);
+		WARN_ON(ap->flags & ATA_FLAG_PM_PENDING);
 
-static int ata_standby_drive(struct ata_device *dev)
-{
-	return ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
-}
+		if (ap->pm_result)
+			rc = ap->pm_result;
+	}
 
-static int ata_start_drive(struct ata_device *dev)
-{
-	return ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
+	return rc;
 }
 
 /**
- *	ata_device_resume - wakeup a previously suspended devices
- *	@dev: the device to resume
+ *	ata_host_set_suspend - suspend host_set
+ *	@host_set: host_set to suspend
+ *	@mesg: PM message
+ *
+ *	Suspend @host_set.  Actual operation is performed by EH.  This
+ *	function requests EH to perform PM operations and waits for EH
+ *	to finish.
  *
- *	Kick the drive back into action, by sending it an idle immediate
- *	command and making sure its transfer mode matches between drive
- *	and host.
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
  *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
  */
-int ata_device_resume(struct ata_device *dev)
+static int ata_host_set_suspend(struct ata_host_set *host_set,
+				pm_message_t mesg)
 {
-	struct ata_port *ap = dev->ap;
-
-	if (ap->flags & ATA_FLAG_SUSPENDED) {
-		struct ata_device *failed_dev;
+	int rc;
 
-		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
+	ata_host_set_request_pm(host_set, mesg);
+	rc = ata_host_set_wait_pm(host_set);
 
-		ap->flags &= ~ATA_FLAG_SUSPENDED;
-		while (ata_set_mode(ap, &failed_dev))
-			ata_dev_disable(failed_dev);
-	}
-	if (!ata_dev_enabled(dev))
-		return 0;
-	if (dev->class == ATA_DEV_ATA)
-		ata_start_drive(dev);
+	host_set->dev->power.power_state = mesg;
+	if (rc)
+		ata_host_set_resume(host_set);
 
-	return 0;
+	return rc;
 }
 
 /**
- *	ata_device_suspend - prepare a device for suspend
- *	@dev: the device to suspend
- *	@state: target power management state
+ *	ata_host_set_resume - resume host_set
+ *	@host_set: host_set to resume
  *
- *	Flush the cache on the drive, if appropriate, then issue a
- *	standbynow command.
+ *	Resume @host_set.  Actual operation is performed by EH.  This
+ *	function requests EH to perform PM operations and returns.
+ *	Note that all resume operations are performed parallely.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0.
  */
-int ata_device_suspend(struct ata_device *dev, pm_message_t state)
+static int ata_host_set_resume(struct ata_host_set *host_set)
 {
-	struct ata_port *ap = dev->ap;
-
-	if (!ata_dev_enabled(dev))
-		return 0;
-	if (dev->class == ATA_DEV_ATA)
-		ata_flush_cache(dev);
-
-	if (state.event != PM_EVENT_FREEZE)
-		ata_standby_drive(dev);
-	ap->flags |= ATA_FLAG_SUSPENDED;
+	ata_host_set_request_pm(host_set, PMSG_ON);
+	host_set->dev->power.power_state = PMSG_ON;
 	return 0;
 }
 
@@ -5245,13 +5267,6 @@ static struct ata_port * ata_host_add(co
 
 	DPRINTK("ENTER\n");
 
-	if (!ent->port_ops->error_handler &&
-	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
-		printk(KERN_ERR "ata%u: no reset mechanism available\n",
-		       port_no);
-		return NULL;
-	}
-
 	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
 	if (!host)
 		return NULL;
@@ -5621,8 +5636,12 @@ void ata_pci_remove_one (struct pci_dev 
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ata_host_set *host_set2 = host_set->next;
 
 	ata_host_set_remove(host_set);
+	if (host_set2)
+		ata_host_set_remove(host_set2);
+
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
@@ -5664,19 +5683,51 @@ int pci_test_config_bits(struct pci_dev 
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
-	return 0;
+	struct ata_host_set *first_hset = dev_get_drvdata(&pdev->dev);
+	struct ata_host_set *host_set;
+	int rc = 0;
+
+	for (host_set = first_hset; host_set; host_set = host_set->next) {
+		rc = ata_host_set_suspend(host_set, state);
+		if (rc)
+			break;
+	}
+
+	if (rc == 0) {
+		pci_save_state(pdev);
+		pci_disable_device(pdev);
+
+		if (state.event == PM_EVENT_SUSPEND)
+			pci_set_power_state(pdev, PCI_D3hot);
+	} else {
+		/* Resume the first host_set too if the second one
+		 * failed to sleep.
+		 */
+		if (host_set != first_hset)
+			ata_host_set_resume(first_hset);
+	}
+
+	return rc;
 }
 
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
+	struct ata_host_set *first_hset = dev_get_drvdata(&pdev->dev);
+	struct ata_host_set *host_set;
+	int tmp, rc = 0;
+
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_enable_device(pdev);
 	pci_set_master(pdev);
-	return 0;
+
+	for (host_set = first_hset; host_set; host_set = host_set->next) {
+		tmp = ata_host_set_resume(host_set);
+		if (tmp)
+			rc = tmp;
+	}
+
+	return rc;
 }
 #endif /* CONFIG_PCI */
 
@@ -5874,11 +5925,6 @@ EXPORT_SYMBOL_GPL(ata_pci_default_filter
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
-EXPORT_SYMBOL_GPL(ata_device_suspend);
-EXPORT_SYMBOL_GPL(ata_device_resume);
-EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
-EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
-
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 EXPORT_SYMBOL_GPL(ata_port_abort);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 531a4e1..6191964 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -47,6 +47,8 @@ #include "libata.h"
 
 static void __ata_port_freeze(struct ata_port *ap);
 static void ata_eh_finish(struct ata_port *ap);
+static void ata_eh_handle_suspend(struct ata_port *ap);
+static void ata_eh_handle_resume(struct ata_port *ap);
 
 static void ata_ering_record(struct ata_ering *ering, int is_io,
 			     unsigned int err_mask)
@@ -243,10 +245,14 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 		spin_unlock_irqrestore(hs_lock, flags);
 
-		/* invoke EH.  if unloading, just finish failed qcs */
-		if (!(ap->flags & ATA_FLAG_UNLOADING))
+		/* invoke EH, skip if unloading or suspended */
+		if (!(ap->flags & ATA_FLAG_UNLOADING) &&
+		    (!(ap->flags & ATA_FLAG_SUSPENDED) ||
+		     ap->flags & ATA_FLAG_PM_PENDING)) {
+			ata_eh_handle_resume(ap);
 			ap->ops->error_handler(ap);
-		else
+			ata_eh_handle_suspend(ap);
+		} else
 			ata_eh_finish(ap);
 
 		/* Exception might have happend after ->error_handler
@@ -1585,6 +1591,37 @@ static int ata_eh_revalidate_and_attach(
 	return rc;
 }
 
+static int ata_eh_spinup(struct ata_port *ap, struct ata_device **r_failed_dev)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_device *dev;
+	unsigned int err_mask = 0;
+	int i;
+
+	if (!(ehc->i.action & ATA_EH_SPINUP))
+		return 0;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+
+		if (dev->class != ATA_DEV_ATA)
+			continue;
+
+		ata_eh_about_to_do(ap, ATA_EH_SPINUP);
+		err_mask = ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
+		if (err_mask)
+			break;
+	}
+
+	if (err_mask == 0) {
+		ehc->i.action &= ~ATA_EH_SPINUP;
+		return 0;
+	} else {
+		*r_failed_dev = dev;
+		return -EIO;
+	}
+}
+
 static int ata_port_nr_enabled(struct ata_port *ap)
 {
 	int i, cnt = 0;
@@ -1711,6 +1748,11 @@ static int ata_eh_recover(struct ata_por
 	if (rc)
 		goto dev_fail;
 
+	/* spin up if requested */
+	rc = ata_eh_spinup(ap, &dev);
+	if (rc)
+		goto dev_fail;
+
 	/* configure transfer mode if the port has been reset */
 	if (ehc->i.flags & ATA_EHI_DID_RESET) {
 		rc = ata_set_mode(ap, &dev);
@@ -1853,3 +1895,139 @@ void ata_do_eh(struct ata_port *ap, ata_
 	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
 	ata_eh_finish(ap);
 }
+
+static int ata_flush_cache(struct ata_device *dev)
+{
+	unsigned int err_mask;
+	u8 cmd;
+
+	if (!ata_try_flush_cache(dev))
+		return 0;
+
+	if (ata_id_has_flush_ext(dev->id))
+		cmd = ATA_CMD_FLUSH_EXT;
+	else
+		cmd = ATA_CMD_FLUSH;
+
+	err_mask = ata_do_simple_cmd(dev, cmd);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR, "failed to flush cache\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ *	ata_eh_handle_suspend - perform suspend operation
+ *	@ap: port to suspend
+ *
+ *	Suspend @ap.  All disk devices on @ap will be flushed and put
+ *	into standby mode, the port is frozen and LLD is given a
+ *	chance to tidy things up.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_handle_suspend(struct ata_port *ap)
+{
+	int do_suspend = ap->pm_mesg.event == PM_EVENT_SUSPEND;
+	unsigned long flags;
+	int i, rc;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	if (!(ap->flags & ATA_FLAG_PM_PENDING) ||
+	    ap->pm_mesg.event == PM_EVENT_ON) {
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		return;
+	}
+	ap->flags &= ~ATA_FLAG_PM_PENDING;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (do_suspend) {
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			struct ata_device *dev = &ap->device[i];
+			unsigned int err_mask;
+
+			if (dev->class != ATA_DEV_ATA)
+				continue;
+
+			/* flush cache */
+			rc = ata_flush_cache(dev);
+			if (rc)
+				goto fail;
+
+			/* spin down */
+			err_mask = ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
+			if (err_mask) {
+				ata_dev_printk(dev, KERN_ERR,
+					"failed to spin down (err_mask=0x%x)\n",
+					err_mask);
+				rc = -EIO;
+				goto fail;
+			}
+		}
+	}
+
+	ata_eh_freeze_port(ap);
+
+	if (ap->ops->suspend) {
+		rc = ap->ops->suspend(ap, ap->pm_mesg);
+		if (rc)
+			goto fail;
+	}
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags |= ATA_FLAG_SUSPENDED;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	return;
+
+ fail:
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->eh_info.action |= ATA_EH_REVALIDATE;
+	ata_port_schedule_eh(ap);
+	ap->pm_result = rc;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
+/**
+ *	ata_eh_handle_resume - perform resume operation
+ *	@ap: port to resume
+ *
+ *	Resume @ap.  For all devices on @ap, SPINUP EH action and
+ *	hotplug handling are requested.  LLD is given a chance to wake
+ *	@ap up before EH takes over and performs those operations.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_handle_resume(struct ata_port *ap)
+{
+	unsigned long flags;
+	int rc = 0;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	if (!(ap->flags & ATA_FLAG_PM_PENDING) ||
+	    !(ap->flags & ATA_FLAG_SUSPENDED) ||
+	    ap->pm_mesg.event != PM_EVENT_ON) {
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		return;
+	}
+	ap->flags &= ~ATA_FLAG_PM_PENDING;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (ap->host_set->dev->power.power_state.event == PM_EVENT_SUSPEND) {
+		struct ata_eh_context *ehc = &ap->eh_context;
+
+		ehc->i.action |= ATA_EH_SPINUP;
+		ata_ehi_hotplugged(&ehc->i);
+	}
+
+	if (ap->ops->resume)
+		rc = ap->ops->resume(ap);
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags &= ~ATA_FLAG_SUSPENDED;
+	ap->pm_result = rc;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 45a49be..0c30e6c 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -399,22 +399,6 @@ void ata_dump_status(unsigned id, struct
 	}
 }
 
-int ata_scsi_device_resume(struct scsi_device *sdev)
-{
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
-
-	return ata_device_resume(dev);
-}
-
-int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
-{
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
-
-	return ata_device_suspend(dev, state);
-}
-
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@id: ATA device number
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index bdd4888..539b0b5 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -50,6 +50,7 @@ extern void ata_port_flush_task(struct a
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen);
+extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 7ebe8e0..3831858 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -182,8 +182,8 @@ static struct ata_port_info adma_port_in
 	/* board_1841_idx */
 	{
 		.sht		= &adma_ata_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x1f, /* udma0-4 */
 		.port_ops	= &adma_ata_ops,
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 9055124..aa69753 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -257,7 +257,6 @@ static struct ata_port_info nv_port_info
 	.sht		= &nv_sht,
 	.host_flags	= ATA_FLAG_SATA |
 			  /* ATA_FLAG_SATA_RESET | */
-			  ATA_FLAG_SRST |
 			  ATA_FLAG_NO_LEGACY,
 	.pio_mask	= NV_PIO_MASK,
 	.mwdma_mask	= NV_MWDMA_MASK,
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index b2b6ed5..083e06e 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -75,9 +75,8 @@ enum {
 
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 
-	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
-				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
-				  ATA_FLAG_PIO_POLLING,
+	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
+				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
 };
 
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 98ddc25..5c84b06 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -176,7 +176,6 @@ static const struct ata_port_info qs_por
 		.sht		= &qs_ata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SATA_RESET |
-				  //FIXME ATA_FLAG_SRST |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x7f, /* udma0-6 */
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index a7e99a1..bb63db2 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -107,6 +107,7 @@ enum {
 };
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int sil_pci_device_resume(struct pci_dev *pdev);
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
@@ -158,6 +159,8 @@ static struct pci_driver sil_pci_driver 
 	.id_table		= sil_pci_tbl,
 	.probe			= sil_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= sil_pci_device_resume,
 };
 
 static struct scsi_host_template sil_sht = {
@@ -526,6 +529,52 @@ static void sil_dev_config(struct ata_po
 	}
 }
 
+static void sil_init_controller(struct pci_dev *pdev,
+				int n_ports, unsigned long host_flags,
+				void __iomem *mmio_base)
+{
+	u8 cls;
+	u32 tmp;
+	int i;
+
+	/* Initialize FIFO PCI bus arbitration */
+	cls = sil_get_device_cache_line(pdev);
+	if (cls) {
+		cls >>= 3;
+		cls++;  /* cls = (line_size/8)+1 */
+		for (i = 0; i < n_ports; i++)
+			writew(cls << 8 | cls,
+			       mmio_base + sil_port[i].fifo_cfg);
+	} else
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "cache line size not set.  Driver may not function\n");
+
+	/* Apply R_ERR on DMA activate FIS errata workaround */
+	if (host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
+		int cnt;
+
+		for (i = 0, cnt = 0; i < n_ports; i++) {
+			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
+			if ((tmp & 0x3) != 0x01)
+				continue;
+			if (!cnt)
+				dev_printk(KERN_INFO, &pdev->dev,
+					   "Applying R_ERR on DMA activate "
+					   "FIS errata fix\n");
+			writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
+			cnt++;
+		}
+	}
+
+	if (n_ports == 4) {
+		/* flip the magic "make 4 ports work" bit */
+		tmp = readl(mmio_base + sil_port[2].bmdma);
+		if ((tmp & SIL_INTR_STEERING) == 0)
+			writel(tmp | SIL_INTR_STEERING,
+			       mmio_base + sil_port[2].bmdma);
+	}
+}
+
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -535,8 +584,6 @@ static int sil_init_one (struct pci_dev 
 	int rc;
 	unsigned int i;
 	int pci_dev_busy = 0;
-	u32 tmp;
-	u8 cls;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -595,42 +642,8 @@ static int sil_init_one (struct pci_dev 
 		ata_std_ports(&probe_ent->port[i]);
 	}
 
-	/* Initialize FIFO PCI bus arbitration */
-	cls = sil_get_device_cache_line(pdev);
-	if (cls) {
-		cls >>= 3;
-		cls++;  /* cls = (line_size/8)+1 */
-		for (i = 0; i < probe_ent->n_ports; i++)
-			writew(cls << 8 | cls,
-			       mmio_base + sil_port[i].fifo_cfg);
-	} else
-		dev_printk(KERN_WARNING, &pdev->dev,
-			   "cache line size not set.  Driver may not function\n");
-
-	/* Apply R_ERR on DMA activate FIS errata workaround */
-	if (probe_ent->host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
-		int cnt;
-
-		for (i = 0, cnt = 0; i < probe_ent->n_ports; i++) {
-			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
-			if ((tmp & 0x3) != 0x01)
-				continue;
-			if (!cnt)
-				dev_printk(KERN_INFO, &pdev->dev,
-					   "Applying R_ERR on DMA activate "
-					   "FIS errata fix\n");
-			writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
-			cnt++;
-		}
-	}
-
-	if (ent->driver_data == sil_3114) {
-		/* flip the magic "make 4 ports work" bit */
-		tmp = readl(mmio_base + sil_port[2].bmdma);
-		if ((tmp & SIL_INTR_STEERING) == 0)
-			writel(tmp | SIL_INTR_STEERING,
-			       mmio_base + sil_port[2].bmdma);
-	}
+	sil_init_controller(pdev, probe_ent->n_ports, probe_ent->host_flags,
+			    mmio_base);
 
 	pci_set_master(pdev);
 
@@ -650,6 +663,16 @@ err_out:
 	return rc;
 }
 
+static int sil_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+
+	sil_init_controller(pdev, host_set->n_ports, host_set->ports[0]->flags,
+			    host_set->mmio_base);
+
+	return ata_pci_device_resume(pdev);
+}
+
 static int __init sil_init(void)
 {
 	return pci_module_init(&sil_pci_driver);
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index c8b477c..8c438ba 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -92,6 +92,7 @@ enum {
 	HOST_CTRL_STOP		= (1 << 18), /* latched PCI STOP */
 	HOST_CTRL_DEVSEL	= (1 << 19), /* latched PCI DEVSEL */
 	HOST_CTRL_REQ64		= (1 << 20), /* latched PCI REQ64 */
+	HOST_CTRL_GLOBAL_RST	= (1 << 31), /* global reset */
 
 	/*
 	 * Port registers
@@ -338,6 +339,7 @@ static int sil24_port_start(struct ata_p
 static void sil24_port_stop(struct ata_port *ap);
 static void sil24_host_stop(struct ata_host_set *host_set);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static int sil24_pci_device_resume(struct pci_dev *pdev);
 
 static const struct pci_device_id sil24_pci_tbl[] = {
 	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
@@ -353,6 +355,8 @@ static struct pci_driver sil24_pci_drive
 	.id_table		= sil24_pci_tbl,
 	.probe			= sil24_init_one,
 	.remove			= ata_pci_remove_one, /* safe? */
+	.suspend		= ata_pci_device_suspend,
+	.resume			= sil24_pci_device_resume,
 };
 
 static struct scsi_host_template sil24_sht = {
@@ -988,6 +992,64 @@ static void sil24_host_stop(struct ata_h
 	kfree(hpriv);
 }
 
+static void sil24_init_controller(struct pci_dev *pdev, int n_ports,
+				  unsigned long host_flags,
+				  void __iomem *host_base,
+				  void __iomem *port_base)
+{
+	u32 tmp;
+	int i;
+
+	/* GPIO off */
+	writel(0, host_base + HOST_FLASH_CMD);
+
+	/* clear global reset & mask interrupts during initialization */
+	writel(0, host_base + HOST_CTRL);
+
+	/* init ports */
+	for (i = 0; i < n_ports; i++) {
+		void __iomem *port = port_base + i * PORT_REGS_SIZE;
+
+		/* Initial PHY setting */
+		writel(0x20c, port + PORT_PHY_CFG);
+
+		/* Clear port RST */
+		tmp = readl(port + PORT_CTRL_STAT);
+		if (tmp & PORT_CS_PORT_RST) {
+			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
+			tmp = ata_wait_register(port + PORT_CTRL_STAT,
+						PORT_CS_PORT_RST,
+						PORT_CS_PORT_RST, 10, 100);
+			if (tmp & PORT_CS_PORT_RST)
+				dev_printk(KERN_ERR, &pdev->dev,
+				           "failed to clear port RST\n");
+		}
+
+		/* Configure IRQ WoC */
+		if (host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
+			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
+		else
+			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
+
+		/* Zero error counters. */
+		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
+		writel(0x8000, port + PORT_CRC_ERR_THRESH);
+		writel(0x8000, port + PORT_HSHK_ERR_THRESH);
+		writel(0x0000, port + PORT_DECODE_ERR_CNT);
+		writel(0x0000, port + PORT_CRC_ERR_CNT);
+		writel(0x0000, port + PORT_HSHK_ERR_CNT);
+
+		/* Always use 64bit activation */
+		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
+
+		/* Clear port multiplier enable and resume bits */
+		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
+	}
+
+	/* Turn on interrupts */
+	writel(IRQ_STAT_4PORTS, host_base + HOST_CTRL);
+}
+
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
@@ -1076,9 +1138,6 @@ static int sil24_init_one(struct pci_dev
 		}
 	}
 
-	/* GPIO off */
-	writel(0, host_base + HOST_FLASH_CMD);
-
 	/* Apply workaround for completion IRQ loss on PCI-X errata */
 	if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
 		tmp = readl(host_base + HOST_CTRL);
@@ -1090,56 +1149,18 @@ static int sil24_init_one(struct pci_dev
 			probe_ent->host_flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
 	}
 
-	/* clear global reset & mask interrupts during initialization */
-	writel(0, host_base + HOST_CTRL);
-
 	for (i = 0; i < probe_ent->n_ports; i++) {
-		void __iomem *port = port_base + i * PORT_REGS_SIZE;
-		unsigned long portu = (unsigned long)port;
+		unsigned long portu =
+			(unsigned long)port_base + i * PORT_REGS_SIZE;
 
 		probe_ent->port[i].cmd_addr = portu;
 		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
 
 		ata_std_ports(&probe_ent->port[i]);
-
-		/* Initial PHY setting */
-		writel(0x20c, port + PORT_PHY_CFG);
-
-		/* Clear port RST */
-		tmp = readl(port + PORT_CTRL_STAT);
-		if (tmp & PORT_CS_PORT_RST) {
-			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
-			tmp = ata_wait_register(port + PORT_CTRL_STAT,
-						PORT_CS_PORT_RST,
-						PORT_CS_PORT_RST, 10, 100);
-			if (tmp & PORT_CS_PORT_RST)
-				dev_printk(KERN_ERR, &pdev->dev,
-				           "failed to clear port RST\n");
-		}
-
-		/* Configure IRQ WoC */
-		if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
-			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
-		else
-			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
-
-		/* Zero error counters. */
-		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
-		writel(0x8000, port + PORT_CRC_ERR_THRESH);
-		writel(0x8000, port + PORT_HSHK_ERR_THRESH);
-		writel(0x0000, port + PORT_DECODE_ERR_CNT);
-		writel(0x0000, port + PORT_CRC_ERR_CNT);
-		writel(0x0000, port + PORT_HSHK_ERR_CNT);
-
-		/* Always use 64bit activation */
-		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
-
-		/* Clear port multiplier enable and resume bits */
-		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
 	}
 
-	/* Turn on interrupts */
-	writel(IRQ_STAT_4PORTS, host_base + HOST_CTRL);
+	sil24_init_controller(pdev, probe_ent->n_ports, probe_ent->host_flags,
+			      host_base, port_base);
 
 	pci_set_master(pdev);
 
@@ -1162,6 +1183,21 @@ static int sil24_init_one(struct pci_dev
 	return rc;
 }
 
+static int sil24_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	struct sil24_host_priv *hpriv = host_set->private_data;
+
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
+		writel(HOST_CTRL_GLOBAL_RST, hpriv->host_base + HOST_CTRL);
+
+	sil24_init_controller(pdev, host_set->n_ports,
+			      host_set->ports[0]->flags,
+			      hpriv->host_base, hpriv->port_base);
+
+	return ata_pci_device_resume(pdev);
+}
+
 static int __init sil24_init(void)
 {
 	return pci_module_init(&sil24_pci_driver);
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 7f86441..58a60ef 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -219,8 +219,8 @@ static const struct ata_port_info pdc_po
 	{
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
+				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index c6975c5..44fc057 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -142,7 +142,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info svia_port_info = {
 	.sht		= &svia_sht,
-	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST | ATA_FLAG_NO_LEGACY,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x07,
 	.udma_mask	= 0x7f,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 61eea57..267f3d8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -148,31 +148,31 @@ enum {
 	ATA_FLAG_SATA		= (1 << 1),
 	ATA_FLAG_NO_LEGACY	= (1 << 2), /* no legacy mode check */
 	ATA_FLAG_MMIO		= (1 << 3), /* use MMIO, not PIO */
-	ATA_FLAG_SRST		= (1 << 4), /* (obsolete) use ATA SRST, not E.D.D. */
-	ATA_FLAG_SATA_RESET	= (1 << 5), /* (obsolete) use COMRESET */
-	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
-	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
-	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
-	ATA_FLAG_PIO_POLLING	= (1 << 9), /* use polling PIO if LLD
+	ATA_FLAG_SATA_RESET	= (1 << 4), /* (obsolete) use COMRESET */
+	ATA_FLAG_NO_ATAPI	= (1 << 5), /* No ATAPI support */
+	ATA_FLAG_PIO_DMA	= (1 << 6), /* PIO cmds via DMA */
+	ATA_FLAG_PIO_LBA48	= (1 << 7), /* Host DMA engine is LBA28 only */
+	ATA_FLAG_PIO_POLLING	= (1 << 8), /* use polling PIO if LLD
 					     * doesn't handle PIO interrupts */
-	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
-	ATA_FLAG_HRST_TO_RESUME	= (1 << 11), /* hardreset to resume phy */
-	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
+	ATA_FLAG_NCQ		= (1 << 9), /* host supports NCQ */
+	ATA_FLAG_HRST_TO_RESUME	= (1 << 10), /* hardreset to resume phy */
+	ATA_FLAG_SKIP_D2H_BSY	= (1 << 11), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 
-	ATA_FLAG_DEBUGMSG	= (1 << 13),
-	ATA_FLAG_FLUSH_PORT_TASK = (1 << 14), /* flush port task */
+	ATA_FLAG_DEBUGMSG	= (1 << 12),
+	ATA_FLAG_FLUSH_PORT_TASK = (1 << 13), /* flush port task */
 
-	ATA_FLAG_EH_PENDING	= (1 << 15), /* EH pending */
-	ATA_FLAG_EH_IN_PROGRESS	= (1 << 16), /* EH in progress */
-	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
-	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
-	ATA_FLAG_LOADING	= (1 << 19), /* boot/loading probe */
-	ATA_FLAG_UNLOADING	= (1 << 20), /* module is unloading */
-	ATA_FLAG_SCSI_HOTPLUG	= (1 << 21), /* SCSI hotplug scheduled */
+	ATA_FLAG_EH_PENDING	= (1 << 14), /* EH pending */
+	ATA_FLAG_EH_IN_PROGRESS	= (1 << 15), /* EH in progress */
+	ATA_FLAG_FROZEN		= (1 << 16), /* port is frozen */
+	ATA_FLAG_RECOVERED	= (1 << 17), /* recovery action performed */
+	ATA_FLAG_LOADING	= (1 << 18), /* boot/loading probe */
+	ATA_FLAG_UNLOADING	= (1 << 19), /* module is unloading */
+	ATA_FLAG_SCSI_HOTPLUG	= (1 << 20), /* SCSI hotplug scheduled */
 
-	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
-	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
+	ATA_FLAG_DISABLED	= (1 << 21), /* port is disabled, ignore it */
+	ATA_FLAG_SUSPENDED	= (1 << 22), /* port is suspended (power) */
+	ATA_FLAG_PM_PENDING	= (1 << 23), /* PM event pending */
 
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
 
@@ -247,6 +247,7 @@ enum {
 	ATA_EH_REVALIDATE	= (1 << 0),
 	ATA_EH_SOFTRESET	= (1 << 1),
 	ATA_EH_HARDRESET	= (1 << 2),
+	ATA_EH_SPINUP		= (1 << 3),
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 
@@ -356,7 +357,8 @@ struct ata_host_set {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
-	struct ata_port *	ports[0];
+	struct ata_host_set	*next;		/* for legacy mode */
+	struct ata_port		*ports[0];
 };
 
 struct ata_queued_cmd {
@@ -530,6 +532,9 @@ struct ata_port {
 	struct list_head	eh_done_q;
 	wait_queue_head_t	eh_wait_q;
 
+	pm_message_t		pm_mesg;
+	int			pm_result;
+
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
@@ -584,6 +589,9 @@ struct ata_port_operations {
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
 			   u32 val);
 
+	int (*suspend) (struct ata_port *ap, pm_message_t mesg);
+	int (*resume) (struct ata_port *ap);
+
 	int (*port_start) (struct ata_port *ap);
 	void (*port_stop) (struct ata_port *ap);
 
@@ -657,10 +665,6 @@ extern int sata_scr_write(struct ata_por
 extern int sata_scr_write_flush(struct ata_port *ap, int reg, u32 val);
 extern int ata_port_online(struct ata_port *ap);
 extern int ata_port_offline(struct ata_port *ap);
-extern int ata_scsi_device_resume(struct scsi_device *);
-extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
-extern int ata_device_resume(struct ata_device *);
-extern int ata_device_suspend(struct ata_device *, pm_message_t state);
 extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
