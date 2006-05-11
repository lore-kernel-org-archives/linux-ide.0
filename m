From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/14] libata-link: linkify config/EH related functions
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <11473650233329-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:23435 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751865AbWEKQaf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:35 -0400
Received: by wr-out-0506.google.com with SMTP id 55so367439wri
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:34 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make the following functions deal with ata_link instead of ata_port.

* ata_set_mode()
* ata_eh_analyze_ncq_error()
* ata_eh_analyze_serror()
* ata_eh_autopsy()
* ata_eh_report()
* ata_eh_attach_and_revalidate()

---

 drivers/scsi/libata-core.c |   13 +++--
 drivers/scsi/libata-eh.c   |  113 +++++++++++++++++++++++---------------------
 drivers/scsi/libata.h      |    3 +
 3 files changed, 68 insertions(+), 61 deletions(-)

222e799fb2ba9ac4c8e0437d5418d6a89fa515b9
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6dc370f..dd40909 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1525,7 +1525,7 @@ static int ata_bus_probe(struct ata_port
 	}
 
 	/* configure transfer mode */
-	rc = ata_set_mode(ap, &dev);
+	rc = ata_set_mode(&ap->link, &dev);
 	if (rc) {
 		down_xfermask = 1;
 		goto fail;
@@ -2062,7 +2062,7 @@ static int ata_dev_set_mode(struct ata_d
 
 /**
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER
- *	@ap: port on which timings will be programmed
+ *	@link: link on which timings will be programmed
  *	@r_failed_dev: out paramter for failed device
  *
  *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).  If
@@ -2075,9 +2075,9 @@ static int ata_dev_set_mode(struct ata_d
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
 
@@ -4938,12 +4938,13 @@ static int ata_start_drive(struct ata_de
  */
 int ata_device_resume(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->link->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		struct ata_device *failed_dev;
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
-		while (ata_set_mode(ap, &failed_dev))
+		while (ata_set_mode(link, &failed_dev))
 			ata_dev_disable(failed_dev);
 	}
 	if (!ata_dev_enabled(dev))
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7e5a03a..06e6523 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -880,7 +880,7 @@ static unsigned int atapi_eh_request_sen
 
 /**
  *	ata_eh_analyze_serror - analyze SError for a failed port
- *	@ap: ATA port to analyze SError for
+ *	@link: ATA link to analyze SError for
  *
  *	Analyze SError if available and further determine cause of
  *	failure.
@@ -888,9 +888,9 @@ static unsigned int atapi_eh_request_sen
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
 
@@ -923,7 +923,7 @@ static void ata_eh_analyze_serror(struct
 
 /**
  *	ata_eh_analyze_ncq_error - analyze NCQ error
- *	@ap: ATA port to analyze NCQ error for
+ *	@link: ATA link to analyze NCQ error for
  *
  *	Read log page 10h, determine the offending qc and acquire
  *	error status TF.  For NCQ device errors, all LLDDs have to do
@@ -933,10 +933,11 @@ static void ata_eh_analyze_serror(struct
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
@@ -946,7 +947,7 @@ static void ata_eh_analyze_ncq_error(str
 		return;
 
 	/* is it NCQ device error? */
-	if (!ap->link.sactive || !(ehc->i.err_mask & AC_ERR_DEV))
+	if (!link->sactive || !(ehc->i.err_mask & AC_ERR_DEV))
 		return;
 
 	/* has LLDD analyzed already? */
@@ -963,13 +964,13 @@ static void ata_eh_analyze_ncq_error(str
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
@@ -1169,18 +1170,18 @@ static int ata_eh_speed_down(struct ata_
 
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
@@ -1195,12 +1196,12 @@ static void ata_eh_autopsy(struct ata_po
 	rc = ata_scr_read(link, SCR_ERROR, &serror);
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
@@ -1211,7 +1212,7 @@ static void ata_eh_autopsy(struct ata_po
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
-		if (!(qc->flags & ATA_QCFLAG_FAILED))
+		if (!(qc->flags & ATA_QCFLAG_FAILED) || qc->dev->link != link)
 			continue;
 
 		/* inherit upper level err_mask */
@@ -1260,16 +1261,17 @@ static void ata_eh_autopsy(struct ata_po
 
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
 
@@ -1280,7 +1282,7 @@ static void ata_eh_report(struct ata_por
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
-		if (!(qc->flags & ATA_QCFLAG_FAILED))
+		if (!(qc->flags & ATA_QCFLAG_FAILED) || qc->dev->link != link)
 			continue;
 		if (qc->flags & ATA_QCFLAG_SENSE_VALID && !qc->err_mask)
 			continue;
@@ -1298,23 +1300,24 @@ static void ata_eh_report(struct ata_por
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
@@ -1485,17 +1488,18 @@ static int ata_eh_reset(struct ata_link 
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
 		if (ehc->i.action & ATA_EH_REVALIDATE && ata_dev_enabled(dev) &&
 		    (!ehc->i.dev || ehc->i.dev == dev)) {
 			if (ata_link_offline(dev->link)) {
@@ -1503,7 +1507,7 @@ static int ata_eh_revalidate_and_attach(
 				break;
 			}
 
-			ata_eh_about_to_do(&ap->link, ATA_EH_REVALIDATE);
+			ata_eh_about_to_do(link, ATA_EH_REVALIDATE);
 			rc = ata_dev_revalidate(dev,
 						ehc->flags & ATA_EHC_DID_RESET);
 			if (rc)
@@ -1537,38 +1541,38 @@ static int ata_eh_revalidate_and_attach(
 	return rc;
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
 
-	if (ap->flags & ATA_FLAG_FROZEN || ata_port_nr_enabled(ap))
+	if (link->ap->flags & ATA_FLAG_FROZEN || ata_link_nr_enabled(link))
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev(dev, link) {
 		if (dev->class == ATA_DEV_UNKNOWN &&
 		    ehc->classes[dev->devno] != ATA_DEV_NONE)
 			return 0;
@@ -1602,14 +1606,15 @@ static int ata_eh_recover(struct ata_por
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
@@ -1631,17 +1636,17 @@ static int ata_eh_recover(struct ata_por
 	rc = 0;
 
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
+		rc = ata_eh_reset(link, ata_link_nr_vacant(ap), prereset,
 				  softreset, hardreset, postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
@@ -1653,13 +1658,13 @@ static int ata_eh_recover(struct ata_por
 	}
 
 	/* revalidate existing devices and attach new ones */
-	rc = ata_eh_revalidate_and_attach(ap, &dev);
+	rc = ata_eh_revalidate_and_attach(link, &dev);
 	if (rc)
 		goto dev_fail;
 
 	/* configure transfer mode if the port has been reset */
 	if (ehc->flags & ATA_EHC_DID_RESET) {
-		rc = ata_set_mode(ap, &dev);
+		rc = ata_set_mode(link, &dev);
 		if (rc) {
 			down_xfermask = 1;
 			goto dev_fail;
@@ -1677,7 +1682,7 @@ static int ata_eh_recover(struct ata_por
 		ehc->tries[dev->devno] = 0;
 		break;
 	case -EIO:
-		ata_down_sata_spd_limit(&ap->link);
+		ata_down_sata_spd_limit(link);
 	default:
 		ehc->tries[dev->devno]--;
 		if (down_xfermask &&
@@ -1690,7 +1695,7 @@ static int ata_eh_recover(struct ata_por
 		ata_dev_disable(dev);
 
 		/* detach if offline */
-		if (ata_link_offline(&ap->link))
+		if (ata_link_offline(link))
 			ata_eh_detach_dev(dev);
 
 		/* probe if requested */
@@ -1711,7 +1716,7 @@ static int ata_eh_recover(struct ata_por
 			ehc->i.action |= ATA_EH_SOFTRESET;
 	}
 
-	if (ata_port_nr_enabled(ap)) {
+	if (ata_link_nr_enabled(ap)) {
 		ata_port_printk(ap, KERN_WARNING, "failed to recover some "
 				"devices, retrying in 5 secs\n");
 		ssleep(5);
@@ -1724,7 +1729,7 @@ static int ata_eh_recover(struct ata_por
 
  out:
 	if (rc) {
-		ata_link_for_each_dev(dev, &ap->link)
+		ata_link_for_each_dev(dev, link)
 			ata_dev_disable(dev);
 	}
 
@@ -1856,8 +1861,8 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_postreset_fn_t postreset)
 {
 	if (!(ap->flags & (ATA_FLAG_LOADING | ATA_FLAG_UNLOADING))) {
-		ata_eh_autopsy(ap);
-		ata_eh_report(ap);
+		ata_eh_autopsy(&ap->link);
+		ata_eh_report(&ap->link);
 	}
 
 	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index bd2e399..f09c23e 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -56,7 +56,8 @@ extern int ata_dev_configure(struct ata_
 extern int ata_down_sata_spd_limit(struct ata_link *link);
 extern int ata_set_sata_spd_needed(struct ata_link *link);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
-extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
+extern int ata_set_mode(struct ata_link *link,
+			struct ata_device **r_failed_dev);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-- 
1.2.4


