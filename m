From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/8] libata: implement fast speed down for unverified data transfer mode
Date: Tue, 27 Nov 2007 19:28:59 +0900
Message-ID: <1196159340385-git-send-email-htejun@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:15466 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbXK0K3Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:29:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so837301rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:29:24 -0800 (PST)
In-Reply-To: <11961593392491-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, Tejun Heo <htejun@gmail.com>

It's very likely that the configured data transfer mode is the wrong
one if device fails data transfers right after initial data transfer
mode configuration (including NCQ on/off and xfermode).  libata EH
needs to speed down fast before upper layers give up on probing.

This patch implement fast speed down rules to handle such cases
better.  Error occured while data transfer hasn't been verified
trigger fast back-to-back speed down actions until data transfer
works.

This change will make cable mis-detection and other initial
configuration problems corrected before partition scanning code gives
up.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   97 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2ba6f59..77083b5 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -50,16 +50,23 @@ enum {
 	ATA_EH_SPDN_NCQ_OFF		= (1 << 0),
 	ATA_EH_SPDN_SPEED_DOWN		= (1 << 1),
 	ATA_EH_SPDN_FALLBACK_TO_PIO	= (1 << 2),
+	ATA_EH_SPDN_KEEP_ERRORS		= (1 << 3),
 
 	/* error flags */
 	ATA_EFLAG_IS_IO			= (1 << 0),
+	ATA_EFLAG_DUBIOUS_XFER		= (1 << 1),
 
 	/* error categories */
 	ATA_ECAT_NONE			= 0,
 	ATA_ECAT_ATA_BUS		= 1,
 	ATA_ECAT_TOUT_HSM		= 2,
 	ATA_ECAT_UNK_DEV		= 3,
-	ATA_ECAT_NR			= 4,
+	ATA_ECAT_DUBIOUS_ATA_BUS	= 4,
+	ATA_ECAT_DUBIOUS_TOUT_HSM	= 5,
+	ATA_ECAT_DUBIOUS_UNK_DEV	= 6,
+	ATA_ECAT_NR			= 7,
+
+	ATA_ECAT_DUBIOUS_BASE		= ATA_ECAT_DUBIOUS_ATA_BUS,
 };
 
 /* Waiting in ->prereset can never be reliable.  It's sometimes nice
@@ -245,6 +252,15 @@ static void ata_ering_record(struct ata_ering *ering, unsigned int eflags,
 	ent->timestamp = get_jiffies_64();
 }
 
+static struct ata_ering_entry *ata_ering_top(struct ata_ering *ering)
+{
+	struct ata_ering_entry *ent = &ering->ring[ering->cursor];
+
+	if (ent->err_mask)
+		return ent;
+	return NULL;
+}
+
 static void ata_ering_clear(struct ata_ering *ering)
 {
 	memset(ering, 0, sizeof(*ering));
@@ -1473,20 +1489,29 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	return action;
 }
 
-static int ata_eh_categorize_error(unsigned int eflags, unsigned int err_mask)
+static int ata_eh_categorize_error(unsigned int eflags, unsigned int err_mask,
+				   int *xfer_ok)
 {
+	int base = 0;
+
+	if (!(eflags & ATA_EFLAG_DUBIOUS_XFER))
+		*xfer_ok = 1;
+
+	if (!*xfer_ok)
+		base = ATA_ECAT_DUBIOUS_BASE;
+
 	if (err_mask & AC_ERR_ATA_BUS)
-		return ATA_ECAT_ATA_BUS;
+		return base + ATA_ECAT_ATA_BUS;
 
 	if (err_mask & AC_ERR_TIMEOUT)
-		return ATA_ECAT_TOUT_HSM;
+		return base + ATA_ECAT_TOUT_HSM;
 
 	if (eflags & ATA_EFLAG_IS_IO) {
 		if (err_mask & AC_ERR_HSM)
-			return ATA_ECAT_TOUT_HSM;
+			return base + ATA_ECAT_TOUT_HSM;
 		if ((err_mask &
 		     (AC_ERR_DEV|AC_ERR_MEDIA|AC_ERR_INVALID)) == AC_ERR_DEV)
-			return ATA_ECAT_UNK_DEV;
+			return base + ATA_ECAT_UNK_DEV;
 	}
 
 	return 0;
@@ -1494,18 +1519,22 @@ static int ata_eh_categorize_error(unsigned int eflags, unsigned int err_mask)
 
 struct speed_down_verdict_arg {
 	u64 since;
+	int xfer_ok;
 	int nr_errors[ATA_ECAT_NR];
 };
 
 static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
 {
 	struct speed_down_verdict_arg *arg = void_arg;
-	int cat = ata_eh_categorize_error(ent->eflags, ent->err_mask);
+	int cat;
 
 	if (ent->timestamp < arg->since)
 		return -1;
 
+	cat = ata_eh_categorize_error(ent->eflags, ent->err_mask,
+				      &arg->xfer_ok);
 	arg->nr_errors[cat]++;
+
 	return 0;
 }
 
@@ -1524,6 +1553,9 @@ static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
  *
  *	ECAT_UNK_DEV	: Unknown DEV error for IO commands
  *
+ *	ECAT_DUBIOUS_*	: Identical to above three but occurred while
+ *			  data transfer hasn't been verified.
+ *
  *	Verdicts are
  *
  *	NCQ_OFF		: Turn off NCQ.
@@ -1534,15 +1566,27 @@ static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
  *	FALLBACK_TO_PIO	: Fall back to PIO.
  *
  *	Even if multiple verdicts are returned, only one action is
- *	taken per error.  ering is cleared after an action is taken.
+ *	taken per error.  An action triggered by non-DUBIOUS errors
+ *	clears ering, while one triggered by DUBIOUS_* errors doesn't.
+ *	This is to expedite speed down decisions right after device is
+ *	initially configured.
+ *
+ *	The followings are speed down rules.  #1 and #2 deal with
+ *	DUBIOUS errors.
  *
- *	1. If more than 6 ATA_BUS, TOUT_HSM or UNK_DEV errors
+ *	1. If more than one DUBIOUS_ATA_BUS or DUBIOUS_TOUT_HSM errors
+ *	   occurred during last 5 mins, SPEED_DOWN and FALLBACK_TO_PIO.
+ *
+ *	2. If more than one DUBIOUS_TOUT_HSM or DUBIOUS_UNK_DEV errors
+ *	   occurred during last 5 mins, NCQ_OFF.
+ *
+ *	3. If more than 8 ATA_BUS, TOUT_HSM or UNK_DEV errors
  *	   ocurred during last 5 mins, FALLBACK_TO_PIO
  *
- *	2. If more than 3 TOUT_HSM or UNK_DEV errors occurred
+ *	4. If more than 3 TOUT_HSM or UNK_DEV errors occurred
  *	   during last 10 mins, NCQ_OFF.
  *
- *	3. If more than 3 ATA_BUS or TOUT_HSM errors, or more than 6
+ *	5. If more than 3 ATA_BUS or TOUT_HSM errors, or more than 6
  *	   UNK_DEV errors occurred during last 10 mins, SPEED_DOWN.
  *
  *	LOCKING:
@@ -1563,6 +1607,15 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
 	arg.since = j64 - min(j64, j5mins);
 	ata_ering_map(&dev->ering, speed_down_verdict_cb, &arg);
 
+	if (arg.nr_errors[ATA_ECAT_DUBIOUS_ATA_BUS] +
+	    arg.nr_errors[ATA_ECAT_DUBIOUS_TOUT_HSM] > 1)
+		verdict |= ATA_EH_SPDN_SPEED_DOWN |
+			ATA_EH_SPDN_FALLBACK_TO_PIO | ATA_EH_SPDN_KEEP_ERRORS;
+
+	if (arg.nr_errors[ATA_ECAT_DUBIOUS_TOUT_HSM] +
+	    arg.nr_errors[ATA_ECAT_DUBIOUS_UNK_DEV] > 1)
+		verdict |= ATA_EH_SPDN_NCQ_OFF | ATA_EH_SPDN_KEEP_ERRORS;
+
 	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
 	    arg.nr_errors[ATA_ECAT_TOUT_HSM] +
 	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 6)
@@ -1606,11 +1659,12 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
 				unsigned int eflags, unsigned int err_mask)
 {
 	struct ata_link *link = dev->link;
+	int xfer_ok = 0;
 	unsigned int verdict;
 	unsigned int action = 0;
 
 	/* don't bother if Cat-0 error */
-	if (ata_eh_categorize_error(eflags, err_mask) == 0)
+	if (ata_eh_categorize_error(eflags, err_mask, &xfer_ok) == 0)
 		return 0;
 
 	/* record error and determine whether speed down is necessary */
@@ -1673,7 +1727,8 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
 	return 0;
  done:
 	/* device has been slowed down, blow error history */
-	ata_ering_clear(&dev->ering);
+	if (!(verdict & ATA_EH_SPDN_KEEP_ERRORS))
+		ata_ering_clear(&dev->ering);
 	return action;
 }
 
@@ -1779,8 +1834,11 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	    ata_dev_enabled(link->device))
 		dev = link->device;
 
-	if (dev)
+	if (dev) {
+		if (dev->flags & ATA_DFLAG_DUBIOUS_XFER)
+			eflags |= ATA_EFLAG_DUBIOUS_XFER;
 		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
+	}
 
 	DPRINTK("EXIT\n");
 }
@@ -2358,6 +2416,17 @@ int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 	struct ata_device *dev;
 	int rc;
 
+	/* if data transfer is verified, clear DUBIOUS_XFER on ering top */
+	ata_link_for_each_dev(dev, link) {
+		if (!(dev->flags & ATA_DFLAG_DUBIOUS_XFER)) {
+			struct ata_ering_entry *ent;
+
+			ent = ata_ering_top(&dev->ering);
+			if (ent)
+				ent->eflags &= ~ATA_EFLAG_DUBIOUS_XFER;
+		}
+	}
+
 	/* has private set_mode? */
 	if (ap->ops->set_mode)
 		rc = ap->ops->set_mode(link, r_failed_dev);
-- 
1.5.2.4

