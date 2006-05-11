From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/14] libata-hp-prep: add prereset() method and implement ata_std_prereset()
Date: Fri, 12 May 2006 00:12:00 +0900
Message-ID: <11473603203554-git-send-email-htejun@gmail.com>
References: <1147360318920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:44528 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751860AbWEKPMP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:12:15 -0400
Received: by nz-out-0102.google.com with SMTP id 13so224767nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:12:14 -0700 (PDT)
In-Reply-To: <1147360318920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With hotplug, every reset might be a probing reset and thus something
similar to probe_init() is needed.  prereset() method is called before
a series of resets to a port and is the counterpart of postreset().
prereset() can also short-circuit probing by returning -ENODEV.

ata_std_prereset() waits for !BSY iff it's boot probe and the port is
online.  The rationales are...

* after hotplugging, BSY clearance is not reliable
* libata can recover from bad resets
* there is no standard way to implement it - some controllers can't
  even do it.

With this behavior, there is a chance that SRST may be issued before
the device enters DI0: Device_idle state which may or may not result
in SRST failure.  However, SATA PM specification states that waiting
for !BSY before issuing SRST is not always possible and thus excludes
the step from device enumeration procedure.  So, all in all, this
should be safe.

If waiting for !BSY before hotplug reset is possible and desirable for
a certain controller, its LLDD is responsible for implementing it.

While at it, this patch unifies function typedef's such that they all
have named arguments.

---

 drivers/scsi/ahci.c         |    3 ++
 drivers/scsi/libata-bmdma.c |   11 ++++++---
 drivers/scsi/libata-core.c  |   42 +++++++++++++++++++++++++++++++++
 drivers/scsi/libata-eh.c    |   54 +++++++++++++++++++++++++++++++++++--------
 drivers/scsi/sata_sil24.c   |    3 ++
 include/linux/libata.h      |   15 +++++++-----
 6 files changed, 106 insertions(+), 22 deletions(-)

561686a7d075c317603fe6aed443895d7ce42c2c
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 9f020cd..f7b550a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1017,7 +1017,8 @@ static void ahci_error_handler(struct at
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ahci_softreset, ahci_hardreset, ahci_postreset);
+	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_hardreset,
+		  ahci_postreset);
 }
 
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 741ddc4..db5a975 100644
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
 	if (ata_scr_valid(ap))
 		hardreset = sata_std_hardreset;
 
-	ata_bmdma_drive_eh(ap, ata_std_softreset, hardreset, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
+			   ata_std_postreset);
 }
 
 /**
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 2500854..7259646 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2533,6 +2533,47 @@ int sata_phy_resume(struct ata_port *ap,
 }
 
 /**
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
+	int boot_probe = ap->flags & ATA_FLAG_LOADING;
+	int rc;
+
+	/* if we're about to do hardreset, don't bother */
+	if (ap->eh_context.i.action & ATA_EH_HARDRESET)
+		return 0;
+
+	/* resume port */
+	rc = sata_phy_resume(ap, boot_probe);
+	if (rc && rc != -EOPNOTSUPP) {
+		/* phy resume failed, whine but continue */
+		ata_port_printk(ap, KERN_WARNING, "failed to resume link "
+				"for reset (errno=%d)\n", rc);
+	}
+
+	/* Wait for !BSY iff boot probe is in progress and we don't
+	 * know that no device is attached.  The boot probe test is
+	 * necessary because hotplugging doesn't clear BSY in many
+	 * cases.  As we wait for !BSY after resets, this should be
+	 * safe.
+	 */
+	if (boot_probe && !ata_port_offline(ap))
+		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+
+	return 0;
+}
+
+/**
  *	ata_std_probeinit - initialize probing
  *	@ap: port to be probed
  *
@@ -5817,6 +5858,7 @@ EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(sata_phy_debounce);
 EXPORT_SYMBOL_GPL(sata_phy_resume);
 EXPORT_SYMBOL_GPL(ata_std_probeinit);
+EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 740934b..ee046c1 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1284,20 +1284,50 @@ static void ata_eh_report(struct ata_por
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
+	 * prereset() may examine it to determine what kind of
+	 * preparation is needed.
+	 */
+	action = ehc->i.action;
+	ehc->i.action &= ~ATA_EH_RESET_MASK;
 	if (softreset && (!hardreset || (!ata_set_sata_spd_needed(ap) &&
-					 !(ehc->i.action & ATA_EH_HARDRESET))))
+					 !(action & ATA_EH_HARDRESET)))) {
+		ehc->i.action |= ATA_EH_SOFTRESET;
 		reset = softreset;
-	else
+	} else {
+		ehc->i.action |= ATA_EH_HARDRESET;
 		reset = hardreset;
+	}
+
+	if (prereset) {
+		rc = prereset(ap);
+
+		/* prereset can short-circuit resetting by returning
+		 * -ENODEV.
+		 */
+		if (rc == -ENODEV) {
+			for (i = 0; i < ATA_MAX_DEVICES; i++)
+				classes[i] = ATA_DEV_NONE;
+			return 0;
+		}
+
+		if (rc) {
+			ata_port_printk(ap, KERN_ERR,
+					"prereset failed (errno=%d)\n", rc);
+			return rc;
+		}
+	}
 
  retry:
 	ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
@@ -1384,6 +1414,7 @@ static int ata_port_nr_enabled(struct at
 /**
  *	ata_eh_recover - recover host port after error
  *	@ap: host port to recover
+ *	@prereset: prereset method (can be NULL)
  *	@softreset: softreset method (can be NULL)
  *	@hardreset: hardreset method (can be NULL)
  *	@postreset: postreset method (can be NULL)
@@ -1400,8 +1431,8 @@ static int ata_port_nr_enabled(struct at
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
@@ -1429,7 +1460,8 @@ static int ata_eh_recover(struct ata_por
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(ap, softreset, hardreset, postreset);
+		rc = ata_eh_reset(ap, prereset, softreset, hardreset,
+				  postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
 					"reset failed, giving up\n");
@@ -1546,6 +1578,7 @@ static void ata_eh_finish(struct ata_por
 /**
  *	ata_do_eh - do standard error handling
  *	@ap: host port to handle error for
+ *	@prereset: prereset method (can be NULL)
  *	@softreset: softreset method (can be NULL)
  *	@hardreset: hardreset method (can be NULL)
  *	@postreset: postreset method (can be NULL)
@@ -1555,11 +1588,12 @@ static void ata_eh_finish(struct ata_por
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
index 202d34e..4747047 100644
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
index ac8e58c..9e06d82 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -296,9 +296,10 @@ struct ata_queued_cmd;
 
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
@@ -618,6 +619,7 @@ extern int ata_drive_probe_reset(struct 
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			ata_postreset_fn_t postreset, unsigned int *classes);
 extern void ata_std_probeinit(struct ata_port *ap);
+extern int ata_std_prereset(struct ata_port *ap);
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
@@ -696,7 +698,7 @@ extern u8   ata_bmdma_status(struct ata_
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_bmdma_freeze(struct ata_port *ap);
 extern void ata_bmdma_thaw(struct ata_port *ap);
-extern void ata_bmdma_drive_eh(struct ata_port *ap,
+extern void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 			       ata_reset_fn_t softreset,
 			       ata_reset_fn_t hardreset,
 			       ata_postreset_fn_t postreset);
@@ -774,8 +776,9 @@ extern void ata_eh_thaw_port(struct ata_
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
1.2.4


