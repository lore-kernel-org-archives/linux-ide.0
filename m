From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/8] libata: clean up EH speed down implementation
Date: Tue, 27 Nov 2007 19:28:56 +0900
Message-ID: <11961593403985-git-send-email-htejun@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:11782 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbXK0K3T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:29:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1179628wah
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:29:19 -0800 (PST)
In-Reply-To: <11961593392491-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, Tejun Heo <htejun@gmail.com>

Clean up EH speed down implementation.

* is_io boolean variable is replaced eflags.  is_io is ATA_EFLAG_IS_IO.

* Error categories now have names.

* Better comments.

* Reorder 5min and 10min rules in ata_eh_speed_down_verdict()

* Use local variable @link to cache @dev->link in ata_eh_speed_down()

These changes are to improve readability and ease further changes.
This patch doesn't introduce any behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |  117 +++++++++++++++++++++++++++++------------------
 include/linux/libata.h  |    2 +-
 2 files changed, 74 insertions(+), 45 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b1dc6b9..1245b96 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -46,9 +46,20 @@
 #include "libata.h"
 
 enum {
+	/* speed down verdicts */
 	ATA_EH_SPDN_NCQ_OFF		= (1 << 0),
 	ATA_EH_SPDN_SPEED_DOWN		= (1 << 1),
 	ATA_EH_SPDN_FALLBACK_TO_PIO	= (1 << 2),
+
+	/* error flags */
+	ATA_EFLAG_IS_IO			= (1 << 0),
+
+	/* error categories */
+	ATA_ECAT_NONE			= 0,
+	ATA_ECAT_ATA_BUS		= 1,
+	ATA_ECAT_TOUT_HSM		= 2,
+	ATA_ECAT_UNK_DEV		= 3,
+	ATA_ECAT_NR			= 4,
 };
 
 /* Waiting in ->prereset can never be reliable.  It's sometimes nice
@@ -218,7 +229,7 @@ void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
 
 #endif /* CONFIG_PCI */
 
-static void ata_ering_record(struct ata_ering *ering, int is_io,
+static void ata_ering_record(struct ata_ering *ering, unsigned int eflags,
 			     unsigned int err_mask)
 {
 	struct ata_ering_entry *ent;
@@ -229,7 +240,7 @@ static void ata_ering_record(struct ata_ering *ering, int is_io,
 	ering->cursor %= ATA_ERING_SIZE;
 
 	ent = &ering->ring[ering->cursor];
-	ent->is_io = is_io;
+	ent->eflags = eflags;
 	ent->err_mask = err_mask;
 	ent->timestamp = get_jiffies_64();
 }
@@ -1451,20 +1462,20 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	return action;
 }
 
-static int ata_eh_categorize_error(int is_io, unsigned int err_mask)
+static int ata_eh_categorize_error(unsigned int eflags, unsigned int err_mask)
 {
 	if (err_mask & AC_ERR_ATA_BUS)
-		return 1;
+		return ATA_ECAT_ATA_BUS;
 
 	if (err_mask & AC_ERR_TIMEOUT)
-		return 2;
+		return ATA_ECAT_TOUT_HSM;
 
-	if (is_io) {
+	if (eflags & ATA_EFLAG_IS_IO) {
 		if (err_mask & AC_ERR_HSM)
-			return 2;
+			return ATA_ECAT_TOUT_HSM;
 		if ((err_mask &
 		     (AC_ERR_DEV|AC_ERR_MEDIA|AC_ERR_INVALID)) == AC_ERR_DEV)
-			return 3;
+			return ATA_ECAT_UNK_DEV;
 	}
 
 	return 0;
@@ -1472,13 +1483,13 @@ static int ata_eh_categorize_error(int is_io, unsigned int err_mask)
 
 struct speed_down_verdict_arg {
 	u64 since;
-	int nr_errors[4];
+	int nr_errors[ATA_ECAT_NR];
 };
 
 static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
 {
 	struct speed_down_verdict_arg *arg = void_arg;
-	int cat = ata_eh_categorize_error(ent->is_io, ent->err_mask);
+	int cat = ata_eh_categorize_error(ent->eflags, ent->err_mask);
 
 	if (ent->timestamp < arg->since)
 		return -1;
@@ -1495,22 +1506,33 @@ static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
  *	whether NCQ needs to be turned off, transfer speed should be
  *	stepped down, or falling back to PIO is necessary.
  *
- *	Cat-1 is ATA_BUS error for any command.
+ *	ECAT_ATA_BUS	: ATA_BUS error for any command
+ *
+ *	ECAT_TOUT_HSM	: TIMEOUT for any command or HSM violation for
+ *			  IO commands
+ *
+ *	ECAT_UNK_DEV	: Unknown DEV error for IO commands
+ *
+ *	Verdicts are
  *
- *	Cat-2 is TIMEOUT for any command or HSM violation for known
- *	supported commands.
+ *	NCQ_OFF		: Turn off NCQ.
  *
- *	Cat-3 is is unclassified DEV error for known supported
- *	command.
+ *	SPEED_DOWN	: Speed down transfer speed but don't fall back
+ *			  to PIO.
  *
- *	NCQ needs to be turned off if there have been more than 3
- *	Cat-2 + Cat-3 errors during last 10 minutes.
+ *	FALLBACK_TO_PIO	: Fall back to PIO.
  *
- *	Speed down is necessary if there have been more than 3 Cat-1 +
- *	Cat-2 errors or 10 Cat-3 errors during last 10 minutes.
+ *	Even if multiple verdicts are returned, only one action is
+ *	taken per error.  ering is cleared after an action is taken.
  *
- *	Falling back to PIO mode is necessary if there have been more
- *	than 10 Cat-1 + Cat-2 + Cat-3 errors during last 5 minutes.
+ *	1. If more than 10 ATA_BUS, TOUT_HSM or UNK_DEV errors
+ *	   ocurred during last 5 mins, FALLBACK_TO_PIO
+ *
+ *	2. If more than 3 TOUT_HSM or UNK_DEV errors occurred
+ *	   during last 10 mins, NCQ_OFF.
+ *
+ *	3. If more than 3 ATA_BUS or TOUT_HSM errors, or more than 10
+ *	   UNK_DEV errors occurred during last 10 mins, SPEED_DOWN.
  *
  *	LOCKING:
  *	Inherited from caller.
@@ -1525,23 +1547,29 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
 	struct speed_down_verdict_arg arg;
 	unsigned int verdict = 0;
 
-	/* scan past 10 mins of error history */
+	/* scan past 5 mins of error history */
 	memset(&arg, 0, sizeof(arg));
-	arg.since = j64 - min(j64, j10mins);
+	arg.since = j64 - min(j64, j5mins);
 	ata_ering_map(&dev->ering, speed_down_verdict_cb, &arg);
 
-	if (arg.nr_errors[2] + arg.nr_errors[3] > 3)
-		verdict |= ATA_EH_SPDN_NCQ_OFF;
-	if (arg.nr_errors[1] + arg.nr_errors[2] > 3 || arg.nr_errors[3] > 10)
-		verdict |= ATA_EH_SPDN_SPEED_DOWN;
+	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
+	    arg.nr_errors[ATA_ECAT_TOUT_HSM] +
+	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 10)
+		verdict |= ATA_EH_SPDN_FALLBACK_TO_PIO;
 
-	/* scan past 3 mins of error history */
+	/* scan past 10 mins of error history */
 	memset(&arg, 0, sizeof(arg));
-	arg.since = j64 - min(j64, j5mins);
+	arg.since = j64 - min(j64, j10mins);
 	ata_ering_map(&dev->ering, speed_down_verdict_cb, &arg);
 
-	if (arg.nr_errors[1] + arg.nr_errors[2] + arg.nr_errors[3] > 10)
-		verdict |= ATA_EH_SPDN_FALLBACK_TO_PIO;
+	if (arg.nr_errors[ATA_ECAT_TOUT_HSM] +
+	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 3)
+		verdict |= ATA_EH_SPDN_NCQ_OFF;
+
+	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
+	    arg.nr_errors[ATA_ECAT_TOUT_HSM] > 3 ||
+	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 10)
+		verdict |= ATA_EH_SPDN_SPEED_DOWN;
 
 	return verdict;
 }
@@ -1549,7 +1577,7 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
 /**
  *	ata_eh_speed_down - record error and speed down if necessary
  *	@dev: Failed device
- *	@is_io: Did the device fail during normal IO?
+ *	@eflags: mask of ATA_EFLAG_* flags
  *	@err_mask: err_mask of the error
  *
  *	Record error and examine error history to determine whether
@@ -1563,18 +1591,19 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
  *	RETURNS:
  *	Determined recovery action.
  */
-static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
-				      unsigned int err_mask)
+static unsigned int ata_eh_speed_down(struct ata_device *dev,
+				unsigned int eflags, unsigned int err_mask)
 {
+	struct ata_link *link = dev->link;
 	unsigned int verdict;
 	unsigned int action = 0;
 
 	/* don't bother if Cat-0 error */
-	if (ata_eh_categorize_error(is_io, err_mask) == 0)
+	if (ata_eh_categorize_error(eflags, err_mask) == 0)
 		return 0;
 
 	/* record error and determine whether speed down is necessary */
-	ata_ering_record(&dev->ering, is_io, err_mask);
+	ata_ering_record(&dev->ering, eflags, err_mask);
 	verdict = ata_eh_speed_down_verdict(dev);
 
 	/* turn off NCQ? */
@@ -1590,7 +1619,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
 	/* speed down? */
 	if (verdict & ATA_EH_SPDN_SPEED_DOWN) {
 		/* speed down SATA link speed if possible */
-		if (sata_down_spd_limit(dev->link) == 0) {
+		if (sata_down_spd_limit(link) == 0) {
 			action |= ATA_EH_HARDRESET;
 			goto done;
 		}
@@ -1621,7 +1650,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
 	 * SATA.  Consider it only for PATA.
 	 */
 	if ((verdict & ATA_EH_SPDN_FALLBACK_TO_PIO) && (dev->spdn_cnt >= 2) &&
-	    (dev->link->ap->cbl != ATA_CBL_SATA) &&
+	    (link->ap->cbl != ATA_CBL_SATA) &&
 	    (dev->xfer_shift != ATA_SHIFT_PIO)) {
 		if (ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO) == 0) {
 			dev->spdn_cnt = 0;
@@ -1653,8 +1682,8 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev;
-	unsigned int all_err_mask = 0;
-	int tag, is_io = 0;
+	unsigned int all_err_mask = 0, eflags = 0;
+	int tag;
 	u32 serror;
 	int rc;
 
@@ -1713,15 +1742,15 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ehc->i.dev = qc->dev;
 		all_err_mask |= qc->err_mask;
 		if (qc->flags & ATA_QCFLAG_IO)
-			is_io = 1;
+			eflags |= ATA_EFLAG_IS_IO;
 	}
 
 	/* enforce default EH actions */
 	if (ap->pflags & ATA_PFLAG_FROZEN ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
 		ehc->i.action |= ATA_EH_SOFTRESET;
-	else if ((is_io && all_err_mask) ||
-		 (!is_io && (all_err_mask & ~AC_ERR_DEV)))
+	else if (((eflags & ATA_EFLAG_IS_IO) && all_err_mask) ||
+		 (!(eflags & ATA_EFLAG_IS_IO) && (all_err_mask & ~AC_ERR_DEV)))
 		ehc->i.action |= ATA_EH_REVALIDATE;
 
 	/* If we have offending qcs and the associated failed device,
@@ -1740,7 +1769,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		dev = link->device;
 
 	if (dev)
-		ehc->i.action |= ata_eh_speed_down(dev, is_io, all_err_mask);
+		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
 
 	DPRINTK("EXIT\n");
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9cd06dd..e9407f1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -480,7 +480,7 @@ struct ata_port_stats {
 };
 
 struct ata_ering_entry {
-	int			is_io;
+	unsigned int		eflags;
 	unsigned int		err_mask;
 	u64			timestamp;
 };
-- 
1.5.2.4

