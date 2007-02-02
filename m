From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] libata: put some intelligence into EH speed down sequence
Date: Fri, 2 Feb 2007 16:22:31 +0900
Message-ID: <11704009513444-git-send-email-htejun@gmail.com>
References: <11704009502014-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:7283 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423180AbXBBHWk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:22:40 -0500
Received: by nz-out-0506.google.com with SMTP id s1so788962nze
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:22:37 -0800 (PST)
In-Reply-To: <11704009502014-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

The current EH speed down code is more of a proof that the EH
framework is capable of adjusting transfer speed in response to error.
This patch puts some intelligence into EH speed down sequence.  The
rules are..

* If there have been more than three timeout, HSM violation or
  unclassified DEV errors for known supported commands during last 10
  mins, NCQ is turned off.

* If there have been more than three timeout or HSM violation for known
  supported command, transfer mode is slowed down.  If DMA is active,
  it is first slowered by one grade (e.g. UDMA133->100).  If that
  doesn't help, it's slowered to 40c limit (UDMA33).  If PIO is
  active, it's slowered by one grade first.  If that doesn't help,
  PIO0 is forced.  Note that this rule does not change transfer mode.
  DMA is never degraded into PIO by this rule.

* If there have been more than ten ATA bus, timeout, HSM violation or
  unclassified device errors for known supported commands && speeding
  down DMA mode didn't help, the device is forced into PIO mode.  Note
  that this rule is considered only for PATA devices and is pretty
  difficult to trigger.

One error can only trigger one rule at a time.  After a rule is
triggered, error history is cleared such that the next speed down
happens only after some number of errors are accumulated.  This makes
sense because now speed down is done in bigger stride.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |  184 +++++++++++++++++++++++++++++++---------------
 include/linux/libata.h  |    1 +
 2 files changed, 125 insertions(+), 60 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1abfdba..3173862 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -44,6 +44,12 @@
 
 #include "libata.h"
 
+enum {
+	ATA_EH_SPDN_NCQ_OFF		= (1 << 0),
+	ATA_EH_SPDN_SPEED_DOWN		= (1 << 1),
+	ATA_EH_SPDN_FALLBACK_TO_PIO	= (1 << 2),
+};
+
 static void __ata_port_freeze(struct ata_port *ap);
 static void ata_eh_finish(struct ata_port *ap);
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
@@ -65,12 +71,9 @@ static void ata_ering_record(struct ata_ering *ering, int is_io,
 	ent->timestamp = get_jiffies_64();
 }
 
-static struct ata_ering_entry * ata_ering_top(struct ata_ering *ering)
+static void ata_ering_clear(struct ata_ering *ering)
 {
-	struct ata_ering_entry *ent = &ering->ring[ering->cursor];
-	if (!ent->err_mask)
-		return NULL;
-	return ent;
+	memset(ering, 0, sizeof(*ering));
 }
 
 static int ata_ering_map(struct ata_ering *ering,
@@ -1159,87 +1162,99 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	return action;
 }
 
-static int ata_eh_categorize_ering_entry(struct ata_ering_entry *ent)
+static int ata_eh_categorize_error(int is_io, unsigned int err_mask)
 {
-	if (ent->err_mask & (AC_ERR_ATA_BUS | AC_ERR_TIMEOUT))
+	if (err_mask & AC_ERR_ATA_BUS)
 		return 1;
 
-	if (ent->is_io) {
-		if (ent->err_mask & AC_ERR_HSM)
-			return 1;
-		if ((ent->err_mask &
-		     (AC_ERR_DEV|AC_ERR_MEDIA|AC_ERR_INVALID)) == AC_ERR_DEV)
+	if (err_mask & AC_ERR_TIMEOUT)
+		return 2;
+
+	if (is_io) {
+		if (err_mask & AC_ERR_HSM)
 			return 2;
+		if ((err_mask &
+		     (AC_ERR_DEV|AC_ERR_MEDIA|AC_ERR_INVALID)) == AC_ERR_DEV)
+			return 3;
 	}
 
 	return 0;
 }
 
-struct speed_down_needed_arg {
+struct speed_down_verdict_arg {
 	u64 since;
-	int nr_errors[3];
+	int nr_errors[4];
 };
 
-static int speed_down_needed_cb(struct ata_ering_entry *ent, void *void_arg)
+static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
 {
-	struct speed_down_needed_arg *arg = void_arg;
+	struct speed_down_verdict_arg *arg = void_arg;
+	int cat = ata_eh_categorize_error(ent->is_io, ent->err_mask);
 
 	if (ent->timestamp < arg->since)
 		return -1;
 
-	arg->nr_errors[ata_eh_categorize_ering_entry(ent)]++;
+	arg->nr_errors[cat]++;
 	return 0;
 }
 
 /**
- *	ata_eh_speed_down_needed - Determine wheter speed down is necessary
+ *	ata_eh_speed_down_verdict - Determine speed down verdict
  *	@dev: Device of interest
  *
  *	This function examines error ring of @dev and determines
- *	whether speed down is necessary.  Speed down is necessary if
- *	there have been more than 3 of Cat-1 errors or 10 of Cat-2
- *	errors during last 15 minutes.
+ *	whether NCQ needs to be turned off, transfer speed should be
+ *	stepped down, or falling back to PIO is necessary.
+ *
+ *	Cat-1 is ATA_BUS error for any command.
  *
- *	Cat-1 errors are ATA_BUS, TIMEOUT for any command and HSM
- *	violation for known supported commands.
+ *	Cat-2 is TIMEOUT for any command or HSM violation for known
+ *	supported commands.
  *
- *	Cat-2 errors are unclassified DEV error for known supported
+ *	Cat-3 is is unclassified DEV error for known supported
  *	command.
  *
+ *	NCQ needs to be turned off if there have been more than 3
+ *	Cat-2 + Cat-3 errors during last 10 minutes.
+ *
+ *	Speed down is necessary if there have been more than 3 Cat-1 +
+ *	Cat-2 errors or 10 Cat-3 errors during last 10 minutes.
+ *
+ *	Falling back to PIO mode is necessary if there have been more
+ *	than 10 Cat-1 + Cat-2 + Cat-3 errors during last 5 minutes.
+ *
  *	LOCKING:
  *	Inherited from caller.
  *
  *	RETURNS:
- *	1 if speed down is necessary, 0 otherwise
+ *	OR of ATA_EH_SPDN_* flags.
  */
-static int ata_eh_speed_down_needed(struct ata_device *dev)
+static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
 {
-	const u64 interval = 15LLU * 60 * HZ;
-	static const int err_limits[3] = { -1, 3, 10 };
-	struct speed_down_needed_arg arg;
-	struct ata_ering_entry *ent;
-	int err_cat;
-	u64 j64;
+	const u64 j5mins = 5LLU * 60 * HZ, j10mins = 10LLU * 60 * HZ;
+	u64 j64 = get_jiffies_64();
+	struct speed_down_verdict_arg arg;
+	unsigned int verdict = 0;
 
-	ent = ata_ering_top(&dev->ering);
-	if (!ent)
-		return 0;
+	/* scan past 10 mins of error history */
+	memset(&arg, 0, sizeof(arg));
+	arg.since = j64 - min(j64, j10mins);
+	ata_ering_map(&dev->ering, speed_down_verdict_cb, &arg);
 
-	err_cat = ata_eh_categorize_ering_entry(ent);
-	if (err_cat == 0)
-		return 0;
+	if (arg.nr_errors[2] + arg.nr_errors[3] > 3)
+		verdict |= ATA_EH_SPDN_NCQ_OFF;
+	if (arg.nr_errors[1] + arg.nr_errors[2] > 3 || arg.nr_errors[3] > 10)
+		verdict |= ATA_EH_SPDN_SPEED_DOWN;
 
+	/* scan past 3 mins of error history */
 	memset(&arg, 0, sizeof(arg));
+	arg.since = j64 - min(j64, j5mins);
+	ata_ering_map(&dev->ering, speed_down_verdict_cb, &arg);
 
-	j64 = get_jiffies_64();
-	if (j64 >= interval)
-		arg.since = j64 - interval;
-	else
-		arg.since = 0;
-
-	ata_ering_map(&dev->ering, speed_down_needed_cb, &arg);
+	if (arg.nr_errors[1] + arg.nr_errors[2] + arg.nr_errors[3] > 10)
+		verdict |= ATA_EH_SPDN_FALLBACK_TO_PIO;
 
-	return arg.nr_errors[err_cat] > err_limits[err_cat];
+	return verdict;
 }
 
 /**
@@ -1257,31 +1272,80 @@ static int ata_eh_speed_down_needed(struct ata_device *dev)
  *	Kernel thread context (may sleep).
  *
  *	RETURNS:
- *	0 on success, -errno otherwise
+ *	Determined recovery action.
  */
-static int ata_eh_speed_down(struct ata_device *dev, int is_io,
-			     unsigned int err_mask)
+static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
+				      unsigned int err_mask)
 {
-	if (!err_mask)
+	unsigned int verdict;
+	unsigned int action = 0;
+
+	/* don't bother if Cat-0 error */
+	if (ata_eh_categorize_error(is_io, err_mask) == 0)
 		return 0;
 
 	/* record error and determine whether speed down is necessary */
 	ata_ering_record(&dev->ering, is_io, err_mask);
+	verdict = ata_eh_speed_down_verdict(dev);
 
-	if (!ata_eh_speed_down_needed(dev))
-		return 0;
+	/* turn off NCQ? */
+	if ((verdict & ATA_EH_SPDN_NCQ_OFF) &&
+	    (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ |
+			   ATA_DFLAG_NCQ_OFF)) == ATA_DFLAG_NCQ) {
+		dev->flags |= ATA_DFLAG_NCQ_OFF;
+		ata_dev_printk(dev, KERN_WARNING,
+			       "NCQ disabled due to excessive errors\n");
+		goto done;
+	}
+
+	/* speed down? */
+	if (verdict & ATA_EH_SPDN_SPEED_DOWN) {
+		/* speed down SATA link speed if possible */
+		if (sata_down_spd_limit(dev->ap) == 0) {
+			action |= ATA_EH_HARDRESET;
+			goto done;
+		}
 
-	/* speed down SATA link speed if possible */
-	if (sata_down_spd_limit(dev->ap) == 0)
-		return ATA_EH_HARDRESET;
+		/* lower transfer mode */
+		if (dev->spdn_cnt < 2) {
+			static const int dma_dnxfer_sel[] =
+				{ ATA_DNXFER_DMA, ATA_DNXFER_40C };
+			static const int pio_dnxfer_sel[] =
+				{ ATA_DNXFER_PIO, ATA_DNXFER_FORCE_PIO0 };
+			int sel;
 
-	/* lower transfer mode */
-	if (ata_down_xfermask_limit(dev, ATA_DNXFER_ANY) == 0)
-		return ATA_EH_SOFTRESET;
+			if (dev->xfer_shift != ATA_SHIFT_PIO)
+				sel = dma_dnxfer_sel[dev->spdn_cnt];
+			else
+				sel = pio_dnxfer_sel[dev->spdn_cnt];
+
+			dev->spdn_cnt++;
+
+			if (ata_down_xfermask_limit(dev, sel) == 0) {
+				action |= ATA_EH_SOFTRESET;
+				goto done;
+			}
+		}
+	}
+
+	/* Fall back to PIO?  Slowing down to PIO is meaningless for
+	 * SATA.  Consider it only for PATA.
+	 */
+	if ((verdict & ATA_EH_SPDN_FALLBACK_TO_PIO) && (dev->spdn_cnt >= 2) &&
+	    (dev->ap->cbl != ATA_CBL_SATA) &&
+	    (dev->xfer_shift != ATA_SHIFT_PIO)) {
+		if (ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO) == 0) {
+			dev->spdn_cnt = 0;
+			action |= ATA_EH_SOFTRESET;
+			goto done;
+		}
+	}
 
-	ata_dev_printk(dev, KERN_ERR,
-		       "speed down requested but no transfer mode left\n");
 	return 0;
+ done:
+	/* device has been slowed down, blow error history */
+	ata_ering_clear(&dev->ering);
+	return action;
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4c3ed59..1b3963f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -495,6 +495,7 @@ struct ata_device {
 
 	/* error history */
 	struct ata_ering	ering;
+	int			spdn_cnt;
 	unsigned int		horkage;	/* List of broken features */
 };
 
-- 
1.4.4.4


