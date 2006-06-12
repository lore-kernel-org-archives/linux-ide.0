From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 00:50:29 +0900
Message-ID: <11501274293403-git-send-email-htejun@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:9294 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752080AbWFLPul (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:41 -0400
Received: by py-out-1112.google.com with SMTP id x31so1732415pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:50:40 -0700 (PDT)
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement new Power Management framework.  All PM operations are
bus-wide and performed by EH.  ata_host_set_suspend() and
ata_host_set_resume() are used to request PM suspend and resume on all
ports of a host_set.  PCI suspend/resume callbacks calls these two
functions for each host_set the controller implements.

Suspend is performed parallely on all ports of a host_set and resume
is done parallely in background to decrease the time necessary before
responding to user.

New PM is fully synchronized w/ all other EH events and it's safe to
suspend and resume any time.  All the usual EH stuff is performed on
resume and removing device or exchanging them while suspended
shouldn't cause any trouble for libata.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  140 ++++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/libata-eh.c   |  148 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/libata.h     |    7 ++
 3 files changed, 286 insertions(+), 9 deletions(-)

240ed4c86ceaf789e40f638a63402d60e7c0555c
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ba9f346..0ee7ab4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -70,6 +70,7 @@ static unsigned int ata_dev_init_params(
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
+static int ata_host_set_resume(struct ata_host_set *host_set);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -4950,6 +4951,104 @@ int ata_port_offline(struct ata_port *ap
 	return 0;
 }
 
+static void ata_host_set_request_pm(struct ata_host_set *host_set,
+				    pm_message_t mesg)
+{
+	int i;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+		unsigned long flags;
+
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+
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
+
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	}
+}
+
+static int ata_host_set_wait_pm(struct ata_host_set *host_set)
+{
+	int i, rc = 0;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		ata_port_wait_eh(ap);
+		WARN_ON(ap->flags & ATA_FLAG_PM_PENDING);
+
+		if (ap->pm_result)
+			rc = ap->pm_result;
+	}
+
+	return rc;
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
+static int ata_host_set_suspend(struct ata_host_set *host_set,
+				pm_message_t mesg)
+{
+	int rc;
+
+	ata_host_set_request_pm(host_set, mesg);
+	rc = ata_host_set_wait_pm(host_set);
+
+	host_set->dev->power.power_state = mesg;
+	if (rc)
+		ata_host_set_resume(host_set);
+
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
+ *
+ *	RETURNS:
+ *	0.
+ */
+static int ata_host_set_resume(struct ata_host_set *host_set)
+{
+	ata_host_set_request_pm(host_set, PMSG_ON);
+	host_set->dev->power.power_state = PMSG_ON;
+	return 0;
+}
+
 /**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
@@ -5584,22 +5683,51 @@ int pci_test_config_bits(struct pci_dev 
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
+	struct ata_host_set *first_hset = dev_get_drvdata(&pdev->dev);
+	struct ata_host_set *host_set;
+	int rc = 0;
+
+	for (host_set = first_hset; host_set; host_set = host_set->next) {
+		rc = ata_host_set_suspend(host_set, state);
+		if (rc)
+			break;
+	}
 
-	if (state.event == PM_EVENT_SUSPEND)
-		pci_set_power_state(pdev, PCI_D3hot);
+	if (rc == 0) {
+		pci_save_state(pdev);
+		pci_disable_device(pdev);
 
-	return 0;
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
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 8711e83..6191964 100644
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
@@ -1889,3 +1895,139 @@ void ata_do_eh(struct ata_port *ap, ata_
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e5ff148..267f3d8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -172,6 +172,7 @@ enum {
 
 	ATA_FLAG_DISABLED	= (1 << 21), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 22), /* port is suspended (power) */
+	ATA_FLAG_PM_PENDING	= (1 << 23), /* PM event pending */
 
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
 
@@ -531,6 +532,9 @@ struct ata_port {
 	struct list_head	eh_done_q;
 	wait_queue_head_t	eh_wait_q;
 
+	pm_message_t		pm_mesg;
+	int			pm_result;
+
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
@@ -585,6 +589,9 @@ struct ata_port_operations {
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
 			   u32 val);
 
+	int (*suspend) (struct ata_port *ap, pm_message_t mesg);
+	int (*resume) (struct ata_port *ap);
+
 	int (*port_start) (struct ata_port *ap);
 	void (*port_stop) (struct ata_port *ap);
 
-- 
1.3.2


