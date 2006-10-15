From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 16/18] [PATCH] libata-link: update EH to deal with PMP links
Date: Mon, 16 Oct 2006 07:54:42 +0900
Message-ID: <11609528821640-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:50102 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422941AbWJOWy7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:59 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626620nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:58 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_eh_autopsy(), ata_eh_report() and ata_eh_recover() to deal
with PMP links.  ata_eh_autopsy() and ata_eh_report() updates are
straightforward.  They just repeat the same operation over all
configured links.

ata_eh_recover() update is more complex as it first processes all
resets and then performs the rest.  This is necessary as thawing with
some links in unknown state can be dangerous.  ehi->action is cleared
on successful recovery of a link to avoid repeating recovery due to
failures in other links.

ata_eh_recover() iterates over only PMP links if PMP is attached, and,
on failure, the failing link is returned in @failed_link instead of
disabling devices directly.  These are to integrate ata_eh_recover()
into PMP EH later.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |  248 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 170 insertions(+), 78 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5ce1e16..1389a1f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1332,8 +1332,8 @@ static int ata_eh_speed_down(struct ata_
 }
 
 /**
- *	ata_eh_autopsy - analyze error and determine recovery action
- *	@link: ATA link to perform autopsy on
+ *	ata_eh_link_autopsy - analyze error and determine recovery action
+ *	@link: host link to perform autopsy on
  *
  *	Analyze why @link failed and determine which recovery actions
  *	are needed.  This function also sets more detailed AC_ERR_*
@@ -1342,7 +1342,7 @@ static int ata_eh_speed_down(struct ata_
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_autopsy(struct ata_link *link)
+static void ata_eh_link_autopsy(struct ata_link *link)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
@@ -1432,7 +1432,25 @@ static void ata_eh_autopsy(struct ata_li
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
@@ -1440,7 +1458,7 @@ static void ata_eh_autopsy(struct ata_li
  *	LOCKING:
  *	None.
  */
-static void ata_eh_report(struct ata_link *link)
+static void ata_eh_link_report(struct ata_link *link)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
@@ -1500,6 +1518,23 @@ static void ata_eh_report(struct ata_lin
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
@@ -1904,6 +1939,17 @@ static int ata_link_nr_enabled(struct at
 	return cnt;
 }
 
+static int ata_port_nr_enabled(struct ata_port *ap)
+{
+	struct ata_link *link;
+	int cnt = 0;
+
+	ata_port_for_each_link(link, ap)
+		cnt += ata_link_nr_enabled(link);
+
+	return cnt;
+}
+
 static int ata_link_nr_vacant(struct ata_link *link)
 {
 	struct ata_device *dev;
@@ -2000,12 +2046,13 @@ static void ata_eh_handle_dev_fail(struc
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
@@ -2016,115 +2063,147 @@ static void ata_eh_handle_dev_fail(struc
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
 	struct ata_device *dev;
-	int down_xfermask, rc;
+	int nr_failed_devs;
+	int reset, rc;
 
 	DPRINTK("ENTER\n");
 
 	/* prep for recovery */
-	ata_link_for_each_dev(dev, link) {
-		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
+	ata_port_for_each_link(link, ap) {
+		struct ata_eh_context *ehc = &link->eh_context;
 
-		/* process hotplug request */
-		if (dev->flags & ATA_DFLAG_DETACH)
-			ata_eh_detach_dev(dev);
+		ata_link_for_each_dev(dev, link) {
+			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
-		if (!ata_dev_enabled(dev) &&
-		    ((ehc->i.probe_mask & (1 << dev->devno)) &&
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
-	down_xfermask = 0;
 	rc = 0;
+	nr_failed_devs = 0;
+	reset = 0;
 
 	/* if UNLOADING, finish immediately */
 	if (ap->pflags & ATA_PFLAG_UNLOADING)
 		goto out;
 
-	/* prep for resume */
-	ata_eh_prep_resume(link);
+	/* prep for EH */
+	ata_port_for_each_link(link, ap) {
+		struct ata_eh_context *ehc = &link->eh_context;
 
-	/* skip EH if possible. */
-	if (ata_eh_skip_recovery(link))
-		ehc->i.action = 0;
+		/* prep for resume */
+		ata_eh_prep_resume(link);
 
-	ata_link_for_each_dev(dev, link)
-		ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
+		/* skip EH if possible. */
+		if (ata_eh_skip_recovery(link))
+			ehc->i.action = 0;
+
+		/* do we need to reset? */
+		if (ehc->i.action & ATA_EH_RESET_MASK)
+			reset = 1;
+
+		ata_link_for_each_dev(dev, link)
+			ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
+	}
 
 	/* reset */
-	if (ehc->i.action & ATA_EH_RESET_MASK) {
+	if (reset) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(link, ata_link_nr_vacant(link), prereset,
-				  softreset, hardreset, postreset);
-		if (rc) {
-			ata_link_printk(link, KERN_ERR,
-					"reset failed, giving up\n");
-			goto out;
+		ata_port_for_each_link(link, ap) {
+			struct ata_eh_context *ehc = &link->eh_context;
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
+	/* the rest */
+	ata_port_for_each_link(link, ap) {
+		struct ata_eh_context *ehc = &link->eh_context;
+		int down_xfermask = 0;
 
-	/* resume devices */
-	rc = ata_eh_resume(link, &dev);
-	if (rc)
-		goto dev_fail;
+		/* revalidate existing devices and attach new ones */
+		rc = ata_eh_revalidate_and_attach(link, &dev);
+		if (rc)
+			goto dev_fail;
 
-	/* configure transfer mode if the port has been reset */
-	if (ehc->i.flags & ATA_EHI_DID_RESET) {
-		rc = ata_set_mode(link, &dev);
-		if (rc) {
-			down_xfermask = 1;
+		/* resume devices */
+		rc = ata_eh_resume(link, &dev);
+		if (rc)
 			goto dev_fail;
+
+		/* configure transfer mode if the port has been reset */
+		if (ehc->i.flags & ATA_EHI_DID_RESET) {
+			rc = ata_set_mode(link, &dev);
+			if (rc) {
+				down_xfermask = 1;
+				goto dev_fail;
+			}
 		}
-	}
 
-	/* suspend devices */
-	rc = ata_eh_suspend(link, &dev);
-	if (rc)
-		goto dev_fail;
+		/* suspend devices */
+		rc = ata_eh_suspend(link, &dev);
+		if (rc)
+			goto dev_fail;
 
-	goto out;
+		/* this link is okay now */
+		ehc->i.flags = 0;
+		continue;
 
- dev_fail:
-	ata_eh_handle_dev_fail(dev, rc, down_xfermask);
+	dev_fail:
+		ata_eh_handle_dev_fail(dev, rc, down_xfermask);
+		nr_failed_devs++;
 
-	if (ata_link_nr_enabled(link)) {
-		ata_link_printk(link, KERN_WARNING, "failed to recover some "
-				"devices, retrying in 5 secs\n");
-		ssleep(5);
-	} else {
-		/* no device left, repeat fast */
-		msleep(500);
+		if (ap->pflags & ATA_PFLAG_FROZEN)
+			break;
 	}
 
-	goto retry;
-
- out:
-	if (rc) {
-		/* recovery failed, activate hp-poll */
-		ata_hp_poll_activate(ap);
+	if (nr_failed_devs) {
+		if (ata_port_nr_enabled(ap)) {
+			ata_port_printk(ap, KERN_WARNING, "failed to recover "
+					"some devices, retrying in 5 secs\n");
+			ssleep(5);
+		} else {
+			/* no device left, repeat fast */
+			msleep(500);
+		}
 
-		ata_link_for_each_dev(dev, link);
-			ata_dev_disable(dev);
+		goto retry;
 	}
 
+ out:
+	if (rc && r_failed_link)
+		*r_failed_link = link;
+
 	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
@@ -2188,9 +2267,22 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 	       ata_postreset_fn_t postreset)
 {
-	ata_eh_autopsy(&ap->link);
-	ata_eh_report(&ap->link);
-	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
+	struct ata_device *dev;
+	int rc;
+
+	ata_eh_autopsy(ap);
+	ata_eh_report(ap);
+
+	rc = ata_eh_recover(ap, prereset, softreset, hardreset, postreset,
+			    NULL);
+	if (rc) {
+		/* recovery failed, activate hp-poll */
+		ata_hp_poll_activate(ap);
+
+		ata_link_for_each_dev(dev, &ap->link)
+			ata_dev_disable(dev);
+	}
+
 	ata_eh_finish(ap);
 }
 
-- 
1.4.2.3


