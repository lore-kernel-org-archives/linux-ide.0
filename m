From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/17] libata-link: linkify config/EH related functions
Date: Sat, 8 Jul 2006 14:45:36 +0900
Message-ID: <11523375362574-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:41839 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932518AbWGHFot (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:49 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484119wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:49 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make the following functions deal with ata_link instead of ata_port.

* ata_set_mode()
* ata_eh_autopsy() and related functions
* ata_eh_report() and related functions
* suspend/resume related functions
* ata_eh_recover() and related functions

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    8 +-
 drivers/scsi/libata-eh.c   |  161 +++++++++++++++++++++++---------------------
 drivers/scsi/libata.h      |    3 +
 3 files changed, 91 insertions(+), 81 deletions(-)

9f6869b65ed5dc741ca33747d34c7ebb3186e495
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9f6b905..e8170e5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1584,7 +1584,7 @@ static int ata_bus_probe(struct ata_port
 	}
 
 	/* configure transfer mode */
-	rc = ata_set_mode(ap, &dev);
+	rc = ata_set_mode(&ap->link, &dev);
 	if (rc) {
 		down_xfermask = 1;
 		goto fail;
@@ -2122,7 +2122,7 @@ static int ata_dev_set_mode(struct ata_d
 
 /**
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER
- *	@ap: port on which timings will be programmed
+ *	@link: link on which timings will be programmed
  *	@r_failed_dev: out paramter for failed device
  *
  *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).  If
@@ -2135,9 +2135,9 @@ static int ata_dev_set_mode(struct ata_d
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
+int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	struct ata_device *dev;
 	int rc = 0, used_dma = 0, found = 0;
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 5475e2f..d574486 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1002,7 +1002,7 @@ static unsigned int atapi_eh_request_sen
 
 /**
  *	ata_eh_analyze_serror - analyze SError for a failed port
- *	@ap: ATA port to analyze SError for
+ *	@link: ATA link to analyze SError for
  *
  *	Analyze SError if available and further determine cause of
  *	failure.
@@ -1010,9 +1010,9 @@ static unsigned int atapi_eh_request_sen
  *	LOCKING:
  *	None.
  */
-static void ata_eh_analyze_serror(struct ata_port *ap)
+static void ata_eh_analyze_serror(struct ata_link *link)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_eh_context *ehc = &link->eh_context;
 	u32 serror = ehc->i.serror;
 	unsigned int err_mask = 0, action = 0;
 
@@ -1042,7 +1042,7 @@ static void ata_eh_analyze_serror(struct
 
 /**
  *	ata_eh_analyze_ncq_error - analyze NCQ error
- *	@ap: ATA port to analyze NCQ error for
+ *	@link: ATA link to analyze NCQ error for
  *
  *	Read log page 10h, determine the offending qc and acquire
  *	error status TF.  For NCQ device errors, all LLDDs have to do
@@ -1052,10 +1052,11 @@ static void ata_eh_analyze_serror(struct
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_analyze_ncq_error(struct ata_port *ap)
+static void ata_eh_analyze_ncq_error(struct ata_link *link)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
-	struct ata_device *dev = ap->link.device;
+	struct ata_port *ap = link->ap;
+	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_device *dev = link->device;
 	struct ata_queued_cmd *qc;
 	struct ata_taskfile tf;
 	int tag, rc;
@@ -1065,7 +1066,7 @@ static void ata_eh_analyze_ncq_error(str
 		return;
 
 	/* is it NCQ device error? */
-	if (!ap->link.sactive || !(ehc->i.err_mask & AC_ERR_DEV))
+	if (!link->sactive || !(ehc->i.err_mask & AC_ERR_DEV))
 		return;
 
 	/* has LLDD analyzed already? */
@@ -1082,13 +1083,13 @@ static void ata_eh_analyze_ncq_error(str
 	/* okay, this error is ours */
 	rc = ata_eh_read_log_10h(dev, &tag, &tf);
 	if (rc) {
-		ata_port_printk(ap, KERN_ERR, "failed to read log page 10h "
+		ata_link_printk(link, KERN_ERR, "failed to read log page 10h "
 				"(errno=%d)\n", rc);
 		return;
 	}
 
-	if (!(ap->link.sactive & (1 << tag))) {
-		ata_port_printk(ap, KERN_ERR, "log page 10h reported "
+	if (!(link->sactive & (1 << tag))) {
+		ata_link_printk(link, KERN_ERR, "log page 10h reported "
 				"inactive tag %d\n", tag);
 		return;
 	}
@@ -1288,18 +1289,18 @@ static int ata_eh_speed_down(struct ata_
 
 /**
  *	ata_eh_autopsy - analyze error and determine recovery action
- *	@ap: ATA port to perform autopsy on
+ *	@link: ATA link to perform autopsy on
  *
- *	Analyze why @ap failed and determine which recovery action is
- *	needed.  This function also sets more detailed AC_ERR_* values
- *	and fills sense data for ATAPI CHECK SENSE.
+ *	Analyze why @link failed and determine which recovery actions
+ *	are needed.  This function also sets more detailed AC_ERR_*
+ *	values and fills sense data for ATAPI CHECK SENSE.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_autopsy(struct ata_port *ap)
+static void ata_eh_autopsy(struct ata_link *link)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int action = ehc->i.action;
 	struct ata_device *failed_dev = NULL;
@@ -1317,12 +1318,12 @@ static void ata_eh_autopsy(struct ata_po
 	rc = sata_scr_read(link, SCR_ERROR, &serror);
 	if (rc == 0) {
 		ehc->i.serror |= serror;
-		ata_eh_analyze_serror(ap);
+		ata_eh_analyze_serror(link);
 	} else if (rc != -EOPNOTSUPP)
 		action |= ATA_EH_HARDRESET;
 
 	/* analyze NCQ failure */
-	ata_eh_analyze_ncq_error(ap);
+	ata_eh_analyze_ncq_error(link);
 
 	/* any real error trumps AC_ERR_OTHER */
 	if (ehc->i.err_mask & ~AC_ERR_OTHER)
@@ -1333,7 +1334,7 @@ static void ata_eh_autopsy(struct ata_po
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
-		if (!(qc->flags & ATA_QCFLAG_FAILED))
+		if (!(qc->flags & ATA_QCFLAG_FAILED) || qc->dev->link != link)
 			continue;
 
 		/* inherit upper level err_mask */
@@ -1391,16 +1392,17 @@ static void ata_eh_autopsy(struct ata_po
 
 /**
  *	ata_eh_report - report error handling to user
- *	@ap: ATA port EH is going on
+ *	@link: ATA link EH is going on
  *
  *	Report EH to user.
  *
  *	LOCKING:
  *	None.
  */
-static void ata_eh_report(struct ata_port *ap)
+static void ata_eh_report(struct ata_link *link)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_port *ap = link->ap;
+	struct ata_eh_context *ehc = &link->eh_context;
 	const char *frozen, *desc;
 	int tag, nr_failed = 0;
 
@@ -1411,7 +1413,7 @@ static void ata_eh_report(struct ata_por
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
-		if (!(qc->flags & ATA_QCFLAG_FAILED))
+		if (!(qc->flags & ATA_QCFLAG_FAILED) || qc->dev->link != link)
 			continue;
 		if (qc->flags & ATA_QCFLAG_SENSE_VALID && !qc->err_mask)
 			continue;
@@ -1429,23 +1431,24 @@ static void ata_eh_report(struct ata_por
 	if (ehc->i.dev) {
 		ata_dev_printk(ehc->i.dev, KERN_ERR, "exception Emask 0x%x "
 			       "SAct 0x%x SErr 0x%x action 0x%x%s\n",
-			       ehc->i.err_mask, ap->link.sactive,
+			       ehc->i.err_mask, link->sactive,
 			       ehc->i.serror, ehc->i.action, frozen);
 		if (desc)
 			ata_dev_printk(ehc->i.dev, KERN_ERR, "(%s)\n", desc);
 	} else {
-		ata_port_printk(ap, KERN_ERR, "exception Emask 0x%x "
+		ata_link_printk(link, KERN_ERR, "exception Emask 0x%x "
 				"SAct 0x%x SErr 0x%x action 0x%x%s\n",
-				ehc->i.err_mask, ap->link.sactive,
+				ehc->i.err_mask, link->sactive,
 				ehc->i.serror, ehc->i.action, frozen);
 		if (desc)
-			ata_port_printk(ap, KERN_ERR, "(%s)\n", desc);
+			ata_link_printk(link, KERN_ERR, "(%s)\n", desc);
 	}
 
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
-		if (!(qc->flags & ATA_QCFLAG_FAILED) || !qc->err_mask)
+		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
+		    qc->dev->link != link || !qc->err_mask)
 			continue;
 
 		ata_dev_printk(qc->dev, KERN_ERR, "tag %d cmd 0x%x "
@@ -1631,17 +1634,18 @@ static int ata_eh_reset(struct ata_link 
 	return rc;
 }
 
-static int ata_eh_revalidate_and_attach(struct ata_port *ap,
+static int ata_eh_revalidate_and_attach(struct ata_link *link,
 					struct ata_device **r_failed_dev)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_port *ap = link->ap;
+	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev;
 	unsigned long flags;
 	int rc = 0;
 
 	DPRINTK("ENTER\n");
 
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev(dev, link) {
 		unsigned int action = ata_eh_dev_action(dev);
 
 		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
@@ -1650,13 +1654,13 @@ static int ata_eh_revalidate_and_attach(
 				break;
 			}
 
-			ata_eh_about_to_do(&ap->link, dev, ATA_EH_REVALIDATE);
+			ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
 			rc = ata_dev_revalidate(dev,
 					ehc->i.flags & ATA_EHI_DID_RESET);
 			if (rc)
 				break;
 
-			ata_eh_done(&ap->link, dev, ATA_EH_REVALIDATE);
+			ata_eh_done(link, dev, ATA_EH_REVALIDATE);
 
 			/* schedule the scsi_rescan_device() here */
 			queue_work(ata_aux_wq, &(ap->scsi_rescan_task));
@@ -1689,7 +1693,7 @@ static int ata_eh_revalidate_and_attach(
 
 /**
  *	ata_eh_suspend - handle suspend EH action
- *	@ap: target host port
+ *	@link: target link
  *	@r_failed_dev: result parameter to indicate failing device
  *
  *	Handle suspend EH action.  Disk devices are spinned down and
@@ -1703,14 +1707,16 @@ static int ata_eh_revalidate_and_attach(
  *	RETURNS:
  *	0 on success, -errno otherwise
  */
-static int ata_eh_suspend(struct ata_port *ap, struct ata_device **r_failed_dev)
+static int ata_eh_suspend(struct ata_link *link,
+			  struct ata_device **r_failed_dev)
 {
+	struct ata_port *ap = link->ap;
 	struct ata_device *dev;
 	int rc = 0;
 
 	DPRINTK("ENTER\n");
 
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev(dev, link) {
 		unsigned int action = ata_eh_dev_action(dev);
 		unsigned int err_mask;
 		unsigned long flags;
@@ -1720,7 +1726,7 @@ static int ata_eh_suspend(struct ata_por
 
 		WARN_ON(dev->flags & ATA_DFLAG_SUSPENDED);
 
-		ata_eh_about_to_do(&ap->link, dev, ATA_EH_SUSPEND);
+		ata_eh_about_to_do(link, dev, ATA_EH_SUSPEND);
 
 		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
 			/* flush cache */
@@ -1743,7 +1749,7 @@ static int ata_eh_suspend(struct ata_por
 		dev->flags |= ATA_DFLAG_SUSPENDED;
 		spin_unlock_irqrestore(ap->lock, flags);
 
-		ata_eh_done(&ap->link, dev, ATA_EH_SUSPEND);
+		ata_eh_done(link, dev, ATA_EH_SUSPEND);
 	}
 
 	if (rc)
@@ -1755,7 +1761,7 @@ static int ata_eh_suspend(struct ata_por
 
 /**
  *	ata_eh_prep_resume - prep for resume EH action
- *	@ap: target host port
+ *	@link: target link
  *
  *	Clear SUSPENDED in preparation for scheduled resume actions.
  *	This allows other parts of EH to access the devices being
@@ -1764,14 +1770,15 @@ static int ata_eh_suspend(struct ata_por
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_prep_resume(struct ata_port *ap)
+static void ata_eh_prep_resume(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct ata_device *dev;
 	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev(dev, link) {
 		unsigned int action = ata_eh_dev_action(dev);
 
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
@@ -1787,7 +1794,7 @@ static void ata_eh_prep_resume(struct at
 
 /**
  *	ata_eh_resume - handle resume EH action
- *	@ap: target host port
+ *	@link: target link
  *	@r_failed_dev: result parameter to indicate failing device
  *
  *	Handle resume EH action.  Target devices are already reset and
@@ -1799,21 +1806,22 @@ static void ata_eh_prep_resume(struct at
  *	RETURNS:
  *	0 on success, -errno otherwise
  */
-static int ata_eh_resume(struct ata_port *ap, struct ata_device **r_failed_dev)
+static int ata_eh_resume(struct ata_link *link,
+			 struct ata_device **r_failed_dev)
 {
 	struct ata_device *dev;
 	int rc = 0;
 
 	DPRINTK("ENTER\n");
 
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev(dev, link) {
 		unsigned int action = ata_eh_dev_action(dev);
 		unsigned int err_mask;
 
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
 			continue;
 
-		ata_eh_about_to_do(&ap->link, dev, ATA_EH_RESUME);
+		ata_eh_about_to_do(link, dev, ATA_EH_RESUME);
 
 		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
 			err_mask = ata_do_simple_cmd(dev,
@@ -1827,7 +1835,7 @@ static int ata_eh_resume(struct ata_port
 			}
 		}
 
-		ata_eh_done(&ap->link, dev, ATA_EH_RESUME);
+		ata_eh_done(link, dev, ATA_EH_RESUME);
 	}
 
 	if (rc)
@@ -1837,35 +1845,35 @@ static int ata_eh_resume(struct ata_port
 	return 0;
 }
 
-static int ata_port_nr_enabled(struct ata_port *ap)
+static int ata_link_nr_enabled(struct ata_link *link)
 {
 	struct ata_device *dev;
 	int cnt = 0;
 
-	ata_link_for_each_dev(dev, &ap->link)
+	ata_link_for_each_dev(dev, link)
 		if (ata_dev_enabled(dev))
 			cnt++;
 	return cnt;
 }
 
-static int ata_port_nr_vacant(struct ata_port *ap)
+static int ata_link_nr_vacant(struct ata_link *link)
 {
 	struct ata_device *dev;
 	int cnt = 0;
 
-	ata_link_for_each_dev(dev, &ap->link)
+	ata_link_for_each_dev(dev, link)
 		if (dev->class == ATA_DEV_UNKNOWN)
 			cnt++;
 	return cnt;
 }
 
-static int ata_eh_skip_recovery(struct ata_port *ap)
+static int ata_eh_skip_recovery(struct ata_link *link)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev;
 
 	/* skip if all possible devices are suspended */
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev(dev, link) {
 		if (ata_dev_absent(dev) || ata_dev_ready(dev))
 			break;
 	}
@@ -1874,11 +1882,11 @@ static int ata_eh_skip_recovery(struct a
 		return 1;
 
 	/* always thaw frozen port and recover failed devices */
-	if (ap->pflags & ATA_PFLAG_FROZEN || ata_port_nr_enabled(ap))
+	if (link->ap->pflags & ATA_PFLAG_FROZEN || ata_link_nr_enabled(link))
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev(dev, link) {
 		if (dev->class == ATA_DEV_UNKNOWN &&
 		    ehc->classes[dev->devno] != ATA_DEV_NONE)
 			return 0;
@@ -1890,8 +1898,8 @@ static int ata_eh_skip_recovery(struct a
 static void ata_eh_handle_dev_fail(struct ata_device *dev, int err,
 				   int down_xfermask)
 {
-	struct ata_port *ap = dev->link->ap;
-	struct ata_eh_context *ehc = &dev->link->eh_context;
+	struct ata_link *link = dev->link;
+	struct ata_eh_context *ehc = &link->eh_context;
 
 	switch (err) {
 	case -ENODEV:
@@ -1901,7 +1909,7 @@ static void ata_eh_handle_dev_fail(struc
 		ehc->tries[dev->devno] = 0;
 		break;
 	case -EIO:
-		sata_down_spd_limit(&ap->link);
+		sata_down_spd_limit(link);
 	default:
 		ehc->tries[dev->devno]--;
 		if (down_xfermask &&
@@ -1914,7 +1922,7 @@ static void ata_eh_handle_dev_fail(struc
 		ata_dev_disable(dev);
 
 		/* detach if offline */
-		if (ata_link_offline(&ap->link))
+		if (ata_link_offline(link))
 			ata_eh_detach_dev(dev);
 
 		/* probe if requested */
@@ -1961,14 +1969,15 @@ static int ata_eh_recover(struct ata_por
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_link *link = &ap->link;
+	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev;
 	int down_xfermask, rc;
 
 	DPRINTK("ENTER\n");
 
 	/* prep for recovery */
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev(dev, link) {
 		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
 		/* process hotplug request */
@@ -1994,23 +2003,23 @@ static int ata_eh_recover(struct ata_por
 		goto out;
 
 	/* prep for resume */
-	ata_eh_prep_resume(ap);
+	ata_eh_prep_resume(link);
 
 	/* skip EH if possible. */
-	if (ata_eh_skip_recovery(ap))
+	if (ata_eh_skip_recovery(link))
 		ehc->i.action = 0;
 
-	ata_link_for_each_dev(dev, &ap->link)
+	ata_link_for_each_dev(dev, link)
 		ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
 
 	/* reset */
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(&ap->link, ata_port_nr_vacant(ap), prereset,
+		rc = ata_eh_reset(link, ata_link_nr_vacant(link), prereset,
 				  softreset, hardreset, postreset);
 		if (rc) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_link_printk(link, KERN_ERR,
 					"reset failed, giving up\n");
 			goto out;
 		}
@@ -2019,18 +2028,18 @@ static int ata_eh_recover(struct ata_por
 	}
 
 	/* revalidate existing devices and attach new ones */
-	rc = ata_eh_revalidate_and_attach(ap, &dev);
+	rc = ata_eh_revalidate_and_attach(link, &dev);
 	if (rc)
 		goto dev_fail;
 
 	/* resume devices */
-	rc = ata_eh_resume(ap, &dev);
+	rc = ata_eh_resume(link, &dev);
 	if (rc)
 		goto dev_fail;
 
 	/* configure transfer mode if the port has been reset */
 	if (ehc->i.flags & ATA_EHI_DID_RESET) {
-		rc = ata_set_mode(ap, &dev);
+		rc = ata_set_mode(link, &dev);
 		if (rc) {
 			down_xfermask = 1;
 			goto dev_fail;
@@ -2038,7 +2047,7 @@ static int ata_eh_recover(struct ata_por
 	}
 
 	/* suspend devices */
-	rc = ata_eh_suspend(ap, &dev);
+	rc = ata_eh_suspend(link, &dev);
 	if (rc)
 		goto dev_fail;
 
@@ -2047,8 +2056,8 @@ static int ata_eh_recover(struct ata_por
  dev_fail:
 	ata_eh_handle_dev_fail(dev, rc, down_xfermask);
 
-	if (ata_port_nr_enabled(ap)) {
-		ata_port_printk(ap, KERN_WARNING, "failed to recover some "
+	if (ata_link_nr_enabled(link)) {
+		ata_link_printk(link, KERN_WARNING, "failed to recover some "
 				"devices, retrying in 5 secs\n");
 		ssleep(5);
 	} else {
@@ -2063,7 +2072,7 @@ static int ata_eh_recover(struct ata_por
 		/* recovery failed, activate hp-poll */
 		ata_hp_poll_activate(ap);
 
-		ata_link_for_each_dev(dev, &ap->link);
+		ata_link_for_each_dev(dev, link);
 			ata_dev_disable(dev);
 	}
 
@@ -2130,8 +2139,8 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 	       ata_postreset_fn_t postreset)
 {
-	ata_eh_autopsy(ap);
-	ata_eh_report(ap);
+	ata_eh_autopsy(&ap->link);
+	ata_eh_report(&ap->link);
 	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
 	ata_eh_finish(ap);
 }
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 69b9b0e..c544d88 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -57,7 +57,8 @@ extern int ata_dev_configure(struct ata_
 extern int sata_down_spd_limit(struct ata_link *link);
 extern int sata_set_spd_needed(struct ata_link *link);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
-extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
+extern int ata_set_mode(struct ata_link *link,
+			struct ata_device **r_failed_dev);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-- 
1.3.2


