From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/14] libata-hp-prep: add prereset() method and implement ata_std_prereset()
Date: Fri, 19 May 2006 06:06:40 -0700 (PDT)
Message-ID: <11480439891385-git-send-email-htejun@gmail.com>
References: <1148043989542-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:41012 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751330AbWESNGm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:06:42 -0400
Received: by nz-out-0102.google.com with SMTP id 8so624359nzo
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:06:41 -0700 (PDT)
In-Reply-To: <1148043989542-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With hotplug, every reset might be a probing reset and thus something
similar to probe_init() is needed.  prereset() method is called before
a series of resets to a port and is the counterpart of postreset().
prereset() can tell EH to use different type of reset or skip reset by
modifying ehc->i.action.

This patch also implements ata_std_prereset().  Most controllers
should be able to use this function directly or with some wrapping.
After hotplug, different controllers need different actions to resume
the PHY and detect the newly attached device.  Controllers can be
categorized as follows.

* Controllers which can wait for the first FIS34 after hotplug.  Note
  that if the waiting is implemented by polling TF status, there needs
  to be a way to set BSY on PHY status change.  It can be implemented
  by hardware or with the help of the driver.

* Controllers which can wait for the first FIS34 after sending
  COMRESET.  These controllers need to issue COMRESET to wait for the
  first FIS.  Note that the received FIS34 could be the first FIS34
  after POR (power-on-reset) or FIS34 in response to the COMRESET.
  Some controllers use COMRESET as TF status synchronization point and
  clear TF automatically (sata_sil).

* Controllers which cannot wait for the first FIS34 reliably.  Blindly
  issuing SRST to spinning-up device often results in command issue
  failure or timeout, causing extended delay.  For these controllers,
  ata_std_prereset() explicitly waits ATA_SPINUP_WAIT (currently 8s)
  to give newly attached device time to spin up, then issues reset.
  Note that failing to getting ready in ATA_SPINUP_WAIT is not
  critical.  libata will retry.  So, the timeout needs to be long
  enough to spin up most devices.

LLDDs can tell ata_std_prereset() which of above action is needed with
ATA_FLAG_HRST_TO_RESUME and ATA_FLAG_CANT_WAIT_FIS34 flags.  These
flags are PHY-specific property and will be moved to ata_link later.

While at it, this patch unifies function typedef's such that they all
have named arguments.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    3 +-
 drivers/scsi/libata-bmdma.c |   11 ++++--
 drivers/scsi/libata-core.c  |   81 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-eh.c    |   62 ++++++++++++++++++++++++++++-----
 drivers/scsi/sata_sil24.c   |    3 +-
 include/linux/libata.h      |   24 ++++++++++---
 6 files changed, 162 insertions(+), 22 deletions(-)

3d2d7d0fb0501519e0940f77303bdde24955aa79
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 45fd71d..8493b02 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1026,7 +1026,8 @@ static void ahci_error_handler(struct at
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ahci_softreset, ahci_hardreset, ahci_postreset);
+	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_hardreset,
+		  ahci_postreset);
 }
 
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 6d30d2c..4bc0537 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -695,6 +695,7 @@ void ata_bmdma_thaw(struct ata_port *ap)
 /**
  *	ata_bmdma_drive_eh - Perform EH with given methods for BMDMA controller
  *	@ap: port to handle error for
+ *	@prereset: prereset method (can be NULL)
  *	@softreset: softreset method (can be NULL)
  *	@hardreset: hardreset method (can be NULL)
  *	@postreset: postreset method (can be NULL)
@@ -710,8 +711,9 @@ void ata_bmdma_thaw(struct ata_port *ap)
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-void ata_bmdma_drive_eh(struct ata_port *ap, ata_reset_fn_t softreset,
-			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
+void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
+			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+			ata_postreset_fn_t postreset)
 {
 	struct ata_host_set *host_set = ap->host_set;
 	struct ata_eh_context *ehc = &ap->eh_context;
@@ -759,7 +761,7 @@ void ata_bmdma_drive_eh(struct ata_port 
 		ata_eh_thaw_port(ap);
 
 	/* PIO and DMA engines have been stopped, perform recovery */
-	ata_do_eh(ap, softreset, hardreset, postreset);
+	ata_do_eh(ap, prereset, softreset, hardreset, postreset);
 }
 
 /**
@@ -779,7 +781,8 @@ void ata_bmdma_error_handler(struct ata_
 	if (sata_scr_valid(ap))
 		hardreset = sata_std_hardreset;
 
-	ata_bmdma_drive_eh(ap, ata_std_softreset, hardreset, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
+			   ata_std_postreset);
 }
 
 /**
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 72eef00..b2197b0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2529,6 +2529,86 @@ int sata_phy_resume(struct ata_port *ap,
 	return sata_phy_debounce(ap, params);
 }
 
+static void ata_wait_spinup(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	unsigned long end, secs;
+	int rc;
+
+	/* first, debounce */
+	rc = sata_phy_debounce(ap, sata_deb_timing_eh);
+
+	/* if debounced successfully and offline, no need to wait */
+	if (rc == 0 && ata_port_offline(ap))
+		return;
+
+	/* okay, let's give the drive time to spin up */
+	end = ehc->i.hotplug_timestamp + ATA_SPINUP_WAIT * HZ / 1000;
+	secs = ((end - jiffies) + HZ - 1) / HZ;
+
+	if (time_after(jiffies, end))
+		return;
+
+	if (secs > 5)
+		ata_port_printk(ap, KERN_INFO, "waiting for device to spin up "
+				"(%lu secs)\n", secs);
+
+	schedule_timeout_uninterruptible(end - jiffies);
+}
+
+/**
+ *	ata_std_prereset - prepare for reset
+ *	@ap: ATA port to be reset
+ *
+ *	@ap is about to be reset.  Initialize it.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_std_prereset(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	const unsigned long *timing;
+	int rc;
+
+	/* hotplug? */
+	if (ehc->i.flags & ATA_EHI_HOTPLUGGED) {
+		if (ap->flags & ATA_FLAG_HRST_TO_RESUME)
+			ehc->i.action |= ATA_EH_HARDRESET;
+		if (ap->flags & ATA_FLAG_CANT_WAIT_FIS34)
+			ata_wait_spinup(ap);
+	}
+
+	/* if we're about to do hardreset, nothing more to do */
+	if (ehc->i.action & ATA_EH_HARDRESET)
+		return 0;
+
+	/* resume port */
+	if (ap->flags & ATA_FLAG_LOADING)
+		timing = sata_deb_timing_boot;
+	else
+		timing = sata_deb_timing_eh;
+
+	rc = sata_phy_resume(ap, timing);
+	if (rc && rc != -EOPNOTSUPP) {
+		/* phy resume failed */
+		ata_port_printk(ap, KERN_WARNING, "failed to resume link "
+				"for reset (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* Wait for !BSY if the controller can wait for the first
+	 * FIS34 and we don't know that no device is attached.
+	 */
+	if (!(ap->flags & ATA_FLAG_CANT_WAIT_FIS34) && !ata_port_offline(ap))
+		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+
+	return 0;
+}
+
 /**
  *	ata_std_probeinit - initialize probing
  *	@ap: port to be probed
@@ -5818,6 +5898,7 @@ EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_std_probeinit);
+EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7cbb311..4ec50d4 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1281,20 +1281,58 @@ static void ata_eh_report(struct ata_por
 	}
 }
 
-static int ata_eh_reset(struct ata_port *ap, ata_reset_fn_t softreset,
+static int ata_eh_reset(struct ata_port *ap,
+			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned int classes[ATA_MAX_DEVICES];
 	int tries = ATA_EH_RESET_TRIES;
+	unsigned int action;
 	ata_reset_fn_t reset;
-	int rc;
+	int i, rc;
 
+	/* Determine which reset to use and record in ehc->i.action.
+	 * prereset() may examine and modify it.
+	 */
+	action = ehc->i.action;
+	ehc->i.action &= ~ATA_EH_RESET_MASK;
 	if (softreset && (!hardreset || (!sata_set_spd_needed(ap) &&
-					 !(ehc->i.action & ATA_EH_HARDRESET))))
-		reset = softreset;
+					 !(action & ATA_EH_HARDRESET))))
+		ehc->i.action |= ATA_EH_SOFTRESET;
 	else
+		ehc->i.action |= ATA_EH_HARDRESET;
+
+	if (prereset) {
+		rc = prereset(ap);
+		if (rc) {
+			ata_port_printk(ap, KERN_ERR,
+					"prereset failed (errno=%d)\n", rc);
+			return rc;
+		}
+	}
+
+	/* prereset() might have modified ehc->i.action */
+	if (ehc->i.action & ATA_EH_HARDRESET)
 		reset = hardreset;
+	else if (ehc->i.action & ATA_EH_SOFTRESET)
+		reset = softreset;
+	else {
+		/* prereset told us not to reset, bang classes and return */
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			classes[i] = ATA_DEV_NONE;
+		return 0;
+	}
+
+	/* did prereset() screw up?  if so, fix up to avoid oopsing */
+	if (!reset) {
+		ata_port_printk(ap, KERN_ERR, "BUG: prereset() requested "
+				"invalid reset type\n");
+		if (softreset)
+			reset = softreset;
+		else
+			reset = hardreset;
+	}
 
  retry:
 	ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
@@ -1381,6 +1419,7 @@ static int ata_port_nr_enabled(struct at
 /**
  *	ata_eh_recover - recover host port after error
  *	@ap: host port to recover
+ *	@prereset: prereset method (can be NULL)
  *	@softreset: softreset method (can be NULL)
  *	@hardreset: hardreset method (can be NULL)
  *	@postreset: postreset method (can be NULL)
@@ -1397,8 +1436,8 @@ static int ata_port_nr_enabled(struct at
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-static int ata_eh_recover(struct ata_port *ap, ata_reset_fn_t softreset,
-			  ata_reset_fn_t hardreset,
+static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
+			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
@@ -1426,7 +1465,8 @@ static int ata_eh_recover(struct ata_por
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(ap, softreset, hardreset, postreset);
+		rc = ata_eh_reset(ap, prereset, softreset, hardreset,
+				  postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
 					"reset failed, giving up\n");
@@ -1543,6 +1583,7 @@ static void ata_eh_finish(struct ata_por
 /**
  *	ata_do_eh - do standard error handling
  *	@ap: host port to handle error for
+ *	@prereset: prereset method (can be NULL)
  *	@softreset: softreset method (can be NULL)
  *	@hardreset: hardreset method (can be NULL)
  *	@postreset: postreset method (can be NULL)
@@ -1552,11 +1593,12 @@ static void ata_eh_finish(struct ata_por
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_do_eh(struct ata_port *ap, ata_reset_fn_t softreset,
-	       ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
+void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
+	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+	       ata_postreset_fn_t postreset)
 {
 	ata_eh_autopsy(ap);
 	ata_eh_report(ap);
-	ata_eh_recover(ap, softreset, hardreset, postreset);
+	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
 	ata_eh_finish(ap);
 }
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 4c76f05..26d7c54 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -912,7 +912,8 @@ static void sil24_error_handler(struct a
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, sil24_softreset, sil24_hardreset, ata_std_postreset);
+	ata_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
+		  ata_std_postreset);
 }
 
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 35f6d3b..f078c4c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -262,6 +262,15 @@ enum {
 	ATA_PROBE_MAX_TRIES	= 3,
 	ATA_EH_RESET_TRIES	= 3,
 	ATA_EH_DEV_TRIES	= 3,
+
+	/* Drive spinup time (time from power-on to the first FIS34)
+	 * in msecs - 8s currently.  Failing to get ready in this time
+	 * isn't critical.  It will result in reset failure for
+	 * controllers which can't wait for the first FIS34.  libata
+	 * will retry, so it just has to be long enough to spin up
+	 * most devices.
+	 */
+	ATA_SPINUP_WAIT		= 8000,
 };
 
 enum hsm_task_states {
@@ -294,9 +303,10 @@ struct ata_queued_cmd;
 
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
-typedef void (*ata_probeinit_fn_t)(struct ata_port *);
-typedef int (*ata_reset_fn_t)(struct ata_port *, unsigned int *);
-typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *);
+typedef void (*ata_probeinit_fn_t)(struct ata_port *ap);
+typedef int (*ata_prereset_fn_t)(struct ata_port *ap);
+typedef int (*ata_reset_fn_t)(struct ata_port *ap, unsigned int *classes);
+typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *classes);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -617,6 +627,7 @@ extern int ata_drive_probe_reset(struct 
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			ata_postreset_fn_t postreset, unsigned int *classes);
 extern void ata_std_probeinit(struct ata_port *ap);
+extern int ata_std_prereset(struct ata_port *ap);
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
@@ -695,7 +706,7 @@ extern u8   ata_bmdma_status(struct ata_
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_bmdma_freeze(struct ata_port *ap);
 extern void ata_bmdma_thaw(struct ata_port *ap);
-extern void ata_bmdma_drive_eh(struct ata_port *ap,
+extern void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 			       ata_reset_fn_t softreset,
 			       ata_reset_fn_t hardreset,
 			       ata_postreset_fn_t postreset);
@@ -773,8 +784,9 @@ extern void ata_eh_thaw_port(struct ata_
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 
-extern void ata_do_eh(struct ata_port *ap, ata_reset_fn_t softreset,
-		      ata_reset_fn_t hardreset, ata_postreset_fn_t postreset);
+extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
+		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+		      ata_postreset_fn_t postreset);
 
 /*
  * printk helpers
-- 
1.3.2

