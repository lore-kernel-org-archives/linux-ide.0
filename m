From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: improve FLUSH error handling
Date: Thu, 27 Mar 2008 19:14:26 +0900
Message-ID: <12066128661591-git-send-email-htejun@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:1215 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898AbYC0KOg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 06:14:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4737780wah.23
        for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2008 03:14:33 -0700 (PDT)
In-Reply-To: <12066128663306-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

When errors occur during flush, instead of writing out the rest and
reporting the errors, ATA halts the processing and report the error,
so FLUSH must be retried on failure.  Also, the spec says that FLUSH
may take more than 30 secs but doesn't mention anything about the
actual limit.

This patch improves FLUSH error handling such that...

1. It's always retried with longer timeout (60s for now) after failure.

2. If the device is making progress by retrying, humor it for longer
   (20 tries for now).

3. If the device is fails the command with the same failed sector,
   retry fewer times (log2 of the original number of tries).

4. If retried FLUSH fails for something other than device error, don't
   keep retrying.  We're likely wasting time.

This patch is inspired by Alan's patch to improve ata_flush_cache().

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-eh.c |  131 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/libata.h  |    5 ++-
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5f3d294..195af46 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1784,6 +1784,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) || qc->dev->link != link)
 			continue;
+		dev = qc->dev;
 
 		/* inherit upper level err_mask */
 		qc->err_mask |= ehc->i.err_mask;
@@ -1809,8 +1810,19 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		    ((qc->flags & ATA_QCFLAG_IO) || qc->err_mask != AC_ERR_DEV))
 			qc->flags |= ATA_QCFLAG_RETRY;
 
+		/* If FLUSH is valid for the device and failed, retry
+		 * and don't be quiet about it.  As EH is gonna retry,
+		 * skip regular retry logic.
+		 */
+		if (dev->class == ATA_DEV_ATA && ata_try_flush_cache(dev) &&
+		    (qc->tf.command == ATA_CMD_FLUSH ||
+		     qc->tf.command == ATA_CMD_FLUSH_EXT)) {
+			ehc->i.dev_action[dev->devno] |= ATA_EH_RETRY_FLUSH;
+			qc->flags &= ~(ATA_QCFLAG_QUIET | ATA_QCFLAG_RETRY);
+		}
+
 		/* accumulate error info */
-		ehc->i.dev = qc->dev;
+		ehc->i.dev = dev;
 		all_err_mask |= qc->err_mask;
 		if (qc->flags & ATA_QCFLAG_IO)
 			eflags |= ATA_EFLAG_IS_IO;
@@ -2496,6 +2508,115 @@ int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 	return rc;
 }
 
+static u64 ata_flush_failed_sector(u8 cmd, const struct ata_taskfile *tf)
+{
+	switch (cmd) {
+	case ATA_CMD_FLUSH:
+		return ata_tf_to_lba(tf);
+	case ATA_CMD_FLUSH_EXT:
+		return ata_tf_to_lba48(tf);
+	default:
+		return -1;
+	}
+}
+
+static int ata_eh_retry_flush(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	int tries = ATA_EH_FLUSH_RETRIES;
+	u64 last_failed = -1;
+	unsigned int tag;
+	int rc = 0;
+
+	/* determine the failed qc and read last_failed from it */
+	for (tag = 0; tag < ATA_MAX_QUEUE - 1; tag++) {
+		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+		if ((qc->err_mask & AC_ERR_DEV) && qc->dev == dev) {
+			last_failed = ata_flush_failed_sector(qc->tf.command,
+							      &qc->result_tf);
+			break;
+		}
+	}
+
+	/* RETRY_FLUSH action is taken only once and repeats inside
+	 * the action if necessary.  Mark done on start.
+	 */
+	ata_eh_about_to_do(dev->link, dev, ATA_EH_RETRY_FLUSH);
+	ata_eh_done(dev->link, dev, ATA_EH_RETRY_FLUSH);
+
+	while (tries) {
+		struct ata_taskfile tf;
+		unsigned int err_mask;
+		u64 failed;
+		u8 cmd;
+
+		/* this can take a while, keep the user entertained */
+		if (last_failed == -1)
+			ata_dev_printk(dev, KERN_INFO, "retrying FLUSH, "
+				       "%d tries left\n", tries);
+		else
+			ata_dev_printk(dev, KERN_INFO, "retrying FLUSH, "
+				       "last_sector=%llu, %d tries left\n",
+				       (unsigned long long)last_failed, tries);
+
+		/* Build tf.  Set the LBA flags so that we don't read
+		 * garbage back after command completion.
+		 */
+		ata_tf_init(dev, &tf);
+
+		if (dev->flags & ATA_DFLAG_FLUSH_EXT) {
+			tf.command = cmd = ATA_CMD_FLUSH_EXT;
+			tf.flags |= ATA_TFLAG_LBA48;
+		} else {
+			tf.command = cmd = ATA_CMD_FLUSH;
+			tf.flags |= ATA_TFLAG_LBA;
+		}
+
+		tf.flags |= ATA_TFLAG_DEVICE;
+		tf.protocol = ATA_PROT_NODATA;
+
+		/* execute FLUSH */
+		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0,
+				jiffies_to_msecs(ATA_TMOUT_FLUSH_RETRY));
+
+		if (!err_mask)
+			return 0;
+
+		/* If it failed for anything other than device error,
+		 * doing it again isn't likely to fix the situation.
+		 */
+		if (err_mask != AC_ERR_DEV || (ap->pflags & ATA_PFLAG_FROZEN)) {
+			ata_dev_printk(dev, KERN_WARNING,
+				"unexpected FLUSH failure, err_mask=0x%x\n",
+				err_mask);
+			rc = -EIO;
+			break;
+		}
+
+		failed = ata_flush_failed_sector(cmd, &tf);
+
+		/* fast-fail if FLUSH isn't making any progress */
+		if (failed == last_failed) {
+			ata_dev_printk(dev, KERN_WARNING,
+				       "FLUSH failed at the same sector, "
+				       "halving tries\n");
+			tries /= 2;
+		} else {
+			ata_dev_printk(dev, KERN_WARNING,
+				       "FLUSH failed at sector %llu\n",
+				       (unsigned long long)failed);
+			last_failed = failed;
+			tries--;
+		}
+	}
+
+	/* anyone who sees this message is seriously screwed */
+	ata_dev_printk(dev, KERN_ERR, "ATTENTION: giving up FLUSH, "
+		       "device might be losing data\n");
+
+	return rc;
+}
+
 static int ata_link_nr_enabled(struct ata_link *link)
 {
 	struct ata_device *dev;
@@ -2753,6 +2874,14 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			ehc->i.flags &= ~ATA_EHI_SETMODE;
 		}
 
+		/* retry FLUSH if requested */
+		ata_link_for_each_dev(dev, link)
+			if (ata_eh_dev_action(dev) & ATA_EH_RETRY_FLUSH) {
+				rc = ata_eh_retry_flush(dev);
+				if (rc)
+					goto dev_fail;
+			}
+
 		if (ehc->i.action & ATA_EH_LPM)
 			ata_link_for_each_dev(dev, link)
 				ata_dev_enable_pm(dev, ap->pm_policy);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d06dd12..d946840 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -242,6 +242,7 @@ enum {
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
 	ATA_TMOUT_INTERNAL	= 30 * HZ,
 	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
+	ATA_TMOUT_FLUSH_RETRY	= 60 * HZ,
 
 	/* FIXME: GoVault needs 2s but we can't afford that without
 	 * parallel probing.  800ms is enough for iVDR disk
@@ -297,9 +298,10 @@ enum {
 	ATA_EH_HARDRESET	= (1 << 2),
 	ATA_EH_ENABLE_LINK	= (1 << 3),
 	ATA_EH_LPM		= (1 << 4),  /* link power management action */
+	ATA_EH_RETRY_FLUSH	= (1 << 5),
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
-	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
+	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_RETRY_FLUSH,
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
@@ -324,6 +326,7 @@ enum {
 	ATA_EH_DEV_TRIES	= 3,
 	ATA_EH_PMP_TRIES	= 5,
 	ATA_EH_PMP_LINK_TRIES	= 3,
+	ATA_EH_FLUSH_RETRIES	= 20,
 
 	SATA_PMP_SCR_TIMEOUT	= 250,
 
-- 
1.5.2.4

