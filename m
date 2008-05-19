From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] libata: improve EH retry delay handling
Date: Tue, 20 May 2008 02:17:52 +0900
Message-ID: <1211217475951-git-send-email-htejun@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.153]:16301 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYESRSC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 13:18:02 -0400
Received: by po-out-1718.google.com with SMTP id c31so3028484poi.1
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 10:18:02 -0700 (PDT)
In-Reply-To: <12112174741373-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

EH retries were delayed by 5 seconds to ensure that resets don't occur
back-to-back.  However, this 5 second delay is superflous or excessive
in many cases.  For example, after IDENTIFY times out, there's no
reason to wait five more seconds before retrying.

This patch adds ehc->last_reset timestamp and record the timestamp for
the last reset trial or success and uses it to space resets by
ATA_EH_RESET_COOL_DOWN which is 5 secs and removes unconditional 5 sec
sleeps.

As this change makes inter-try waits often shorter and they're
redundant in nature, this patch also removes the "retrying..."
messages.

While at it, convert explicit rounding up division to DIV_ROUND_UP().

This change speeds up EH in many cases w/o sacrificing robustness.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c  |   38 ++++++++++++++++++++------------------
 drivers/ata/libata-pmp.c |   10 ----------
 include/linux/libata.h   |    2 ++
 3 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 08dd07f..5b5ae63 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -67,6 +67,9 @@ enum {
 	ATA_ECAT_DUBIOUS_UNK_DEV	= 7,
 	ATA_ECAT_NR			= 8,
 
+	/* always put at least this amount of time between resets */
+	ATA_EH_RESET_COOL_DOWN		=  5000,
+
 	/* Waiting in ->prereset can never be reliable.  It's
 	 * sometimes nice to wait there but it can't be depended upon;
 	 * otherwise, we wouldn't be resetting.  Just give it enough
@@ -485,6 +488,9 @@ void ata_scsi_error(struct Scsi_Host *host)
 				if (ata_ncq_enabled(dev))
 					ehc->saved_ncq_enabled |= 1 << devno;
 			}
+
+			/* set last reset timestamp to some time in the past */
+			ehc->last_reset = jiffies - 60 * HZ;
 		}
 
 		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
@@ -2088,11 +2094,17 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/*
 	 * Prepare to reset
 	 */
+	now = jiffies;
+	deadline = ata_deadline(ehc->last_reset, ATA_EH_RESET_COOL_DOWN);
+	if (time_before(now, deadline))
+		schedule_timeout_uninterruptible(deadline - now);
+
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags |= ATA_PFLAG_RESETTING;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
+	ehc->last_reset = jiffies;
 
 	ata_link_for_each_dev(dev, link) {
 		/* If we issue an SRST then an ATA drive (not ATAPI)
@@ -2158,6 +2170,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/*
 	 * Perform reset
 	 */
+	ehc->last_reset = jiffies;
 	if (ata_is_host_link(link))
 		ata_eh_freeze_port(ap);
 
@@ -2278,6 +2291,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 
 	/* reset successful, schedule revalidation */
 	ata_eh_done(link, NULL, ATA_EH_RESET);
+	ehc->last_reset = jiffies;
 	ehc->i.action |= ATA_EH_REVALIDATE;
 
 	rc = 0;
@@ -2304,9 +2318,9 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	if (time_before(now, deadline)) {
 		unsigned long delta = deadline - now;
 
-		ata_link_printk(link, KERN_WARNING, "reset failed "
-				"(errno=%d), retrying in %u secs\n",
-				rc, (jiffies_to_msecs(delta) + 999) / 1000);
+		ata_link_printk(link, KERN_WARNING,
+			"reset failed (errno=%d), retrying in %u secs\n",
+			rc, DIV_ROUND_UP(jiffies_to_msecs(delta), 1000));
 
 		while (delta)
 			delta = schedule_timeout_uninterruptible(delta);
@@ -2623,7 +2637,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 {
 	struct ata_link *link;
 	struct ata_device *dev;
-	int nr_failed_devs, nr_disabled_devs;
+	int nr_failed_devs;
 	int rc;
 	unsigned long flags;
 
@@ -2666,7 +2680,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
  retry:
 	rc = 0;
 	nr_failed_devs = 0;
-	nr_disabled_devs = 0;
 
 	/* if UNLOADING, finish immediately */
 	if (ap->pflags & ATA_PFLAG_UNLOADING)
@@ -2733,8 +2746,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 dev_fail:
 		nr_failed_devs++;
-		if (ata_eh_handle_dev_fail(dev, rc))
-			nr_disabled_devs++;
+		ata_eh_handle_dev_fail(dev, rc);
 
 		if (ap->pflags & ATA_PFLAG_FROZEN) {
 			/* PMP reset requires working host port.
@@ -2746,18 +2758,8 @@ dev_fail:
 		}
 	}
 
-	if (nr_failed_devs) {
-		if (nr_failed_devs != nr_disabled_devs) {
-			ata_port_printk(ap, KERN_WARNING, "failed to recover "
-					"some devices, retrying in 5 secs\n");
-			ssleep(5);
-		} else {
-			/* no device left to recover, repeat fast */
-			msleep(500);
-		}
-
+	if (nr_failed_devs)
 		goto retry;
-	}
 
  out:
 	if (rc && r_failed_link)
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 3a2bce0..3374ec5 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -724,19 +724,12 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 		}
 
 		if (tries) {
-			int sleep = ehc->i.flags & ATA_EHI_DID_RESET;
-
 			/* consecutive revalidation failures? speed down */
 			if (reval_failed)
 				sata_down_spd_limit(link);
 			else
 				reval_failed = 1;
 
-			ata_dev_printk(dev, KERN_WARNING,
-				       "retrying reset%s\n",
-				       sleep ? " in 5 secs" : "");
-			if (sleep)
-				ssleep(5);
 			ehc->i.action |= ATA_EH_RESET;
 			goto retry;
 		} else {
@@ -988,10 +981,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 		goto retry;
 
 	if (--pmp_tries) {
-		ata_port_printk(ap, KERN_WARNING,
-				"failed to recover PMP, retrying in 5 secs\n");
 		pmp_ehc->i.action |= ATA_EH_RESET;
-		ssleep(5);
 		goto retry;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4bbe955..4fc9ab0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -602,6 +602,8 @@ struct ata_eh_context {
 	unsigned int		did_probe_mask;
 	unsigned int		saved_ncq_enabled;
 	u8			saved_xfer_mode[ATA_MAX_DEVICES];
+	/* timestamp for the last reset attempt or success */
+	unsigned long		last_reset;
 };
 
 struct ata_acpi_drive
-- 
1.5.2.4

