From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/14] libata-link: update EH to deal with PM links
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <11473650233229-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:39563 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030234AbWEKQap (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:45 -0400
Received: by wr-out-0506.google.com with SMTP id i12so405462wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:45 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_eh_autopsy(), ata_eh_report() and ata_eh_recover() to deal
with PM links.  ata_eh_autopsy() and ata_eh_report() updates are
straightforward.  They just repeat the same operation over all
configured links.

ata_eh_recover() update is more complex as it first processes all
resets and then performs the rest.  This is necessary as thawing with
some links in unknown state can be dangerous.  ehi->action is cleared
on successful recovery of a link to avoid repeating recovery due to
failures in other links.

ata_eh_recover() iterates over only PM links if PM is attached, and,
on failure, the failing link is returned in @failed_link instead of
disabling devices directly.  These are to integrate ata_eh_recover()
into PM EH later.

---

 drivers/scsi/libata-eh.c |  192 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 135 insertions(+), 57 deletions(-)

e76a448cb0f33855cd17ee65f4a5f5b83e6962af
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 8e89379..24b5dc8 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1196,8 +1196,8 @@ static int ata_eh_speed_down(struct ata_
 }
 
 /**
- *	ata_eh_autopsy - analyze error and determine recovery action
- *	@link: ATA link to perform autopsy on
+ *	ata_eh_link_autopsy - analyze error and determine recovery action
+ *	@link: host link to perform autopsy on
  *
  *	Analyze why @link failed and determine which recovery actions
  *	are needed.  This function also sets more detailed AC_ERR_*
@@ -1206,7 +1206,7 @@ static int ata_eh_speed_down(struct ata_
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_autopsy(struct ata_link *link)
+static void ata_eh_link_autopsy(struct ata_link *link)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
@@ -1287,7 +1287,25 @@ static void ata_eh_autopsy(struct ata_li
 }
 
 /**
- *	ata_eh_report - report error handling to user
+ *	ata_eh_autopsy - analyze error and determine recovery action
+ *	@ap: host port to perform autopsy on
+ *
+ *	Analyze all links of @ap and determine why they failed and
+ *	which recovery actions are needed.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_autopsy(struct ata_port *ap)
+{
+	struct ata_link *link;
+
+	__ata_port_for_each_link(link, ap)
+		ata_eh_link_autopsy(link);
+}
+
+/**
+ *	ata_eh_link_report - report error handling to user
  *	@link: ATA link EH is going on
  *
  *	Report EH to user.
@@ -1295,7 +1313,7 @@ static void ata_eh_autopsy(struct ata_li
  *	LOCKING:
  *	None.
  */
-static void ata_eh_report(struct ata_link *link)
+static void ata_eh_link_report(struct ata_link *link)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
@@ -1355,6 +1373,23 @@ static void ata_eh_report(struct ata_lin
 	}
 }
 
+/**
+ *	ata_eh_report - report error handling to user
+ *	@ap: ATA port to report EH about
+ *
+ *	Report EH to user.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_eh_report(struct ata_port *ap)
+{
+	struct ata_link *link;
+
+	__ata_port_for_each_link(link, ap)
+		ata_eh_link_report(link);
+}
+
 static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 			unsigned int *classes)
 {
@@ -1615,12 +1650,13 @@ static int ata_eh_skip_recovery(struct a
  *	@softreset: softreset method (can be NULL)
  *	@hardreset: hardreset method (can be NULL)
  *	@postreset: postreset method (can be NULL)
+ *	@r_failed_link: out parameter for failed link
  *
  *	This is the alpha and omega, eum and yang, heart and soul of
  *	libata exception handling.  On entry, actions required to
- *	recover the port and hotplug requests are recorded in
- *	eh_context.  This function executes all the operations with
- *	appropriate retrials and fallbacks to resurrect failed
+ *	recover each link and hotplug requests are recorded in the
+ *	link's eh_context.  This function executes all the operations
+ *	with appropriate retrials and fallbacks to resurrect failed
  *	devices, detach goners and greet newcomers.
  *
  *	LOCKING:
@@ -1631,71 +1667,106 @@ static int ata_eh_skip_recovery(struct a
  */
 static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-			  ata_postreset_fn_t postreset)
+			  ata_postreset_fn_t postreset,
+			  struct ata_link **r_failed_link)
 {
-	struct ata_link *link = &ap->link;
-	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_link *link;
+	struct ata_eh_context *ehc;
 	struct ata_device *dev;
-	int down_xfermask, rc;
+	int down_xfermask, reset, rc;
 
 	DPRINTK("ENTER\n");
 
 	/* prep for recovery */
-	ata_link_for_each_dev(dev, link) {
-		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
+	ata_port_for_each_link(link, ap) {
+		ehc = &link->eh_context;
 
-		/* process hotplug request */
-		if (dev->flags & ATA_DFLAG_DETACH)
-			ata_eh_detach_dev(dev);
+		ata_link_for_each_dev(dev, link) {
+			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
-		if (!ata_dev_enabled(dev) &&
-		    (ehc->i.probe_mask & (1 << dev->devno) &&
-		     !(ehc->did_probe_mask & (1 << dev->devno)))) {
-			ata_eh_detach_dev(dev);
-			ata_dev_init(dev);
-			ehc->did_probe_mask |= (1 << dev->devno);
-			ehc->i.action |= ATA_EH_SOFTRESET;
+			/* process hotplug request */
+			if (dev->flags & ATA_DFLAG_DETACH)
+				ata_eh_detach_dev(dev);
+
+			if (!ata_dev_enabled(dev) &&
+			    (ehc->i.probe_mask & (1 << dev->devno) &&
+			     !(ehc->did_probe_mask & (1 << dev->devno)))) {
+				ata_eh_detach_dev(dev);
+				ata_dev_init(dev);
+				ehc->did_probe_mask |= (1 << dev->devno);
+				ehc->i.action |= ATA_EH_SOFTRESET;
+			}
 		}
 	}
 
  retry:
 	down_xfermask = 0;
 	rc = 0;
+	reset = 0;
 
-	/* skip EH if possible. */
-	if (ata_eh_skip_recovery(link))
-		ehc->i.action = 0;
+	/* do we need to reset? */
+	ata_port_for_each_link(link, ap) {
+		ehc = &link->eh_context;
 
-	ata_link_for_each_dev(dev, link)
-		ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
+		/* skip EH if possible. */
+		if (ata_eh_skip_recovery(link))
+			ehc->i.action = 0;
+
+		if (ehc->i.action & ATA_EH_RESET_MASK)
+			reset = 1;
+	}
+
+	ata_port_for_each_link(link, ap) {
+		ata_link_for_each_dev(dev, link) {
+			ehc = &link->eh_context;
+			ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
+		}
+	}
 
 	/* reset */
-	if (ehc->i.action & ATA_EH_RESET_MASK) {
-		ata_eh_freeze_port(ap);
+	if (reset) {
+		__ata_port_freeze(ap);
 
-		rc = ata_eh_reset(link, ata_link_nr_vacant(ap), prereset,
-				  softreset, hardreset, postreset);
-		if (rc) {
-			ata_port_printk(ap, KERN_ERR,
-					"reset failed, giving up\n");
-			goto out;
+		ata_port_for_each_link(link, ap) {
+			ehc = &link->eh_context;
+
+			if (!(ehc->i.action & ATA_EH_RESET_MASK))
+				continue;
+
+			rc = ata_eh_reset(link, ata_link_nr_vacant(link),
+					  prereset, softreset, hardreset,
+					  postreset);
+			if (rc) {
+				ata_link_printk(link, KERN_ERR,
+						"reset failed, giving up\n");
+				goto out;
+			}
 		}
 
 		ata_eh_thaw_port(ap);
 	}
 
-	/* revalidate existing devices and attach new ones */
-	rc = ata_eh_revalidate_and_attach(link, &dev);
-	if (rc)
-		goto dev_fail;
-
-	/* configure transfer mode if the port has been reset */
-	if (ehc->flags & ATA_EHC_DID_RESET) {
-		rc = ata_set_mode(link, &dev);
-		if (rc) {
-			down_xfermask = 1;
+	/* the rest */
+	ata_port_for_each_link(link, ap) {
+		ehc = &link->eh_context;
+
+		/* revalidate existing devices and attach new ones */
+		rc = ata_eh_revalidate_and_attach(link, &dev);
+		if (rc)
 			goto dev_fail;
+
+		/* configure transfer mode if the port has been reset */
+		if (ehc->flags & ATA_EHC_DID_RESET) {
+			rc = ata_set_mode(link, &dev);
+			if (rc) {
+				down_xfermask = 1;
+				goto dev_fail;
+			}
 		}
+
+		/* this link is okay now */
+		ehc->flags &= ~ATA_EHC_DID_RESET;
+		ehc->i.action = 0;
 	}
 
 	goto out;
@@ -1718,7 +1789,7 @@ static int ata_eh_recover(struct ata_por
 	}
 
 	if (ata_dev_enabled(dev) && !ehc->tries[dev->devno]) {
-		/* disable device if it has used up all its chances */
+		/* the device has used all its chances, disable */
 		ata_dev_disable(dev);
 
 		/* detach if offline */
@@ -1743,8 +1814,8 @@ static int ata_eh_recover(struct ata_por
 			ehc->i.action |= ATA_EH_SOFTRESET;
 	}
 
-	if (ata_link_nr_enabled(ap)) {
-		ata_port_printk(ap, KERN_WARNING, "failed to recover some "
+	if (ata_link_nr_enabled(link)) {
+		ata_link_printk(link, KERN_WARNING, "failed to recover some "
 				"devices, retrying in 5 secs\n");
 		ssleep(5);
 	} else {
@@ -1755,10 +1826,8 @@ static int ata_eh_recover(struct ata_por
 	goto retry;
 
  out:
-	if (rc) {
-		ata_link_for_each_dev(dev, link)
-			ata_dev_disable(dev);
-	}
+	if (rc && r_failed_link)
+		*r_failed_link = link;
 
 	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
@@ -1887,11 +1956,20 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 	       ata_postreset_fn_t postreset)
 {
+	struct ata_device *dev;
+	int rc;
+
 	if (!(ap->flags & (ATA_FLAG_LOADING | ATA_FLAG_UNLOADING))) {
-		ata_eh_autopsy(&ap->link);
-		ata_eh_report(&ap->link);
+		ata_eh_autopsy(ap);
+		ata_eh_report(ap);
+	}
+
+	rc = ata_eh_recover(ap, prereset, softreset, hardreset, postreset,
+			    NULL);
+	if (rc) {
+		ata_link_for_each_dev(dev, &ap->link)
+			ata_dev_disable(dev);
 	}
 
-	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
 	ata_eh_finish(ap);
 }
-- 
1.2.4


