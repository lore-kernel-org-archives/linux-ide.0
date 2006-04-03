From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/13] libata: implement ata_eh_autopsy()
Date: Mon, 3 Apr 2006 12:44:39 +0900
Message-ID: <11440358791318-git-send-email-htejun@gmail.com>
References: <11440358783861-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:64516 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932290AbWDCDos (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:44:48 -0400
Received: by zproxy.gmail.com with SMTP id o37so1665772nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:44:47 -0700 (PDT)
In-Reply-To: <11440358783861-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement EH helper function ata_eh_autopsy().  This function analyzes
how the port and qc failed and determine what to do to recover from
the condition.

* Analyzes TF/SError
* Record the error and determine whether speeding down is necessary.
  If so, adjust relevant limits.
* Determine which action is required to recover - REVALIDATE,
  PORT_SOFTRESET or PORT_HARDRESET.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 
 drivers/scsi/libata-eh.c   |  280 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    3 
 3 files changed, 284 insertions(+), 0 deletions(-)

166600385563ff9043f86179422b041fb6a1c7fb
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 06bf7f4..ea5335b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5280,3 +5280,4 @@ EXPORT_SYMBOL_GPL(ata_eh_schedule_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_eh_determine_qc);
+EXPORT_SYMBOL_GPL(ata_eh_autopsy);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7781f67..5224fe4 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -550,3 +550,283 @@ struct ata_queued_cmd * ata_eh_determine
 	return __ata_qc_from_tag(ap, ap->active_tag);
 }
 
+/**
+ *	ata_eh_analyze_tf - analyze taskfile of a failed qc
+ *	@qc: qc to analyze
+ *	@tf: Taskfile registers to analyze
+ *
+ *	Analyze taskfile of @qc and further determine cause of
+ *	failure.  This function also requests ATAPI sense data if
+ *	avaliable.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	Determined recovery action
+ */
+static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
+				      const struct ata_taskfile *tf)
+{
+	unsigned int tmp, action = 0;
+	u8 stat = tf->command, err = tf->feature;
+
+	if ((stat & (ATA_BUSY | ATA_DRQ | ATA_DRDY)) != ATA_DRDY) {
+		qc->err_mask |= AC_ERR_HSM;
+		return ATA_PORT_SOFTRESET;
+	}
+
+	if (!(qc->err_mask & AC_ERR_DEV))
+		return 0;
+
+	switch (qc->dev->class) {
+	case ATA_DEV_ATA:
+		if (err & ATA_ICRC)
+			qc->err_mask |= AC_ERR_ATA_BUS;
+		if (err & ATA_UNC)
+			qc->err_mask |= AC_ERR_MEDIA;
+		if (err & ATA_IDNF)
+			qc->err_mask |= AC_ERR_INVALID;
+		break;
+
+	case ATA_DEV_ATAPI:
+		tmp = atapi_eh_request_sense(qc->ap, qc->dev,
+					     qc->scsicmd->sense_buffer);
+		if (!tmp) {
+			/*
+			 * ATA_QCFLAG_SENSE_VALID is used to tell
+			 * atapi_qc_complete() that sense data is
+			 * already valid.
+			 *
+			 * TODO: interpret sense data and set
+			 * appropriate err_mask.
+			 */
+			qc->err_mask &= ~AC_ERR_DEV;
+			qc->flags |= ATA_QCFLAG_SENSE_VALID;
+		} else
+			qc->err_mask |= tmp;
+	}
+
+	if (qc->err_mask) {
+		action |= ATA_PORT_REVALIDATE;
+		if (qc->err_mask &
+		    (AC_ERR_HSM | AC_ERR_TIMEOUT | AC_ERR_ATA_BUS))
+			action |= ATA_PORT_SOFTRESET;
+	}
+
+	return action;
+}
+
+/**
+ *	ata_eh_analyze_serror - analyze SError of a failed qc
+ *	@serror: SError to analyze
+ *	@p_err_mask: Resulting err_mask
+ *
+ *	Analyze SError if available and further determine cause of
+ *	failure.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Determined recovery action
+ */
+static unsigned int ata_eh_analyze_serror(u32 serror, unsigned int *p_err_mask)
+{
+	unsigned int action = 0;
+
+	/* read SError and clear it */
+	if (serror & SERR_PERSISTENT) {
+		*p_err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_PORT_HARDRESET;
+	}
+	if (serror &
+	    (SERR_DATA_RECOVERED | SERR_COMM_RECOVERED | SERR_DATA)) {
+		*p_err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_PORT_SOFTRESET;
+	}
+	if (serror & SERR_PROTOCOL) {
+		*p_err_mask |= AC_ERR_HSM;
+		action |= ATA_PORT_SOFTRESET;
+	}
+	if (serror & SERR_INTERNAL) {
+		*p_err_mask |= AC_ERR_SYSTEM;
+		action |= ATA_PORT_SOFTRESET;
+	}
+
+	return action;
+}
+
+static int ata_eh_categorize_ering_entry(struct ata_ering_entry *ent)
+{
+	if (ent->err_mask & (AC_ERR_ATA_BUS | AC_ERR_TIMEOUT))
+		return 1;
+
+	if (ent->is_io) {
+		if (ent->err_mask & AC_ERR_HSM)
+			return 1;
+		if ((ent->err_mask &
+		     (AC_ERR_DEV|AC_ERR_MEDIA|AC_ERR_INVALID)) == AC_ERR_DEV)
+			return 2;
+	}
+
+	return 0;
+}
+
+struct speed_down_needed_arg {
+	u64 since;
+	int nr_errors[3];
+};
+
+static int speed_down_needed_cb(struct ata_ering_entry *ent, void *void_arg)
+{
+	struct speed_down_needed_arg *arg = void_arg;
+
+	if (ent->timestamp < arg->since)
+		return -1;
+
+	arg->nr_errors[ata_eh_categorize_ering_entry(ent)]++;
+	return 0;
+}
+
+/**
+ *	ata_eh_speed_down_needed - Determine wheter speed down is necessary
+ *	@dev: Device of interest
+ *
+ *	This function examines error ring of @dev and determines
+ *	whether speed down is necessary.  Speed down is necessary if
+ *	there have been more than 3 of CAT-1 errors or 10 of Cat-2
+ *	errors during last 15 minutes.
+ *
+ *	Cat-1 errors are ATA_BUS, TIMEOUT for any command and HSM
+ *	violation for known supported commands.
+ *
+ *	Cat-2 errors are unclassified DEV error for known supported
+ *	command.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	1 if speed down is necessary, 0 otherwise
+ */
+static int ata_eh_speed_down_needed(struct ata_device *dev)
+{
+	const u64 interval = 15LLU * 60 * HZ;
+	static const int err_limits[3] = { -1, 3, 10 };
+	struct speed_down_needed_arg arg;
+	struct ata_ering_entry *ent;
+	int err_cat;
+	u64 j64;
+
+	ent = ata_ering_top(&dev->ering);
+	if (!ent)
+		return 0;
+
+	err_cat = ata_eh_categorize_ering_entry(ent);
+	if (err_cat == 0)
+		return 0;
+
+	memset(&arg, 0, sizeof(arg));
+
+	j64 = get_jiffies_64();
+	if (j64 >= interval)
+		arg.since = j64 - interval;
+	else
+		arg.since = 0;
+
+	ata_ering_map(&dev->ering, speed_down_needed_cb, &arg);
+
+	return arg.nr_errors[err_cat] > err_limits[err_cat];
+}
+
+/**
+ *	ata_eh_speed_down - record error and speed down if necessary
+ *	@ap: Host port failed device lives on
+ *	@dev: Failed device
+ *	@is_io: Did the device fail during normal IO?
+ *	@err_mask: err_mask of the error
+ *
+ *	Record error and examine error history to determine whether
+ *	adjusting transmission speed is necessary.  It also sets
+ *	transmission limits appropriately if such adjustment is
+ *	necessary.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise
+ */
+static int ata_eh_speed_down(struct ata_port *ap, struct ata_device *dev,
+			     int is_io, unsigned int err_mask)
+{
+	if (!err_mask)
+		return 0;
+
+	/* record error and determine whether speed down is necessary */
+	ata_ering_record(&dev->ering, is_io, err_mask);
+
+	if (!ata_eh_speed_down_needed(dev))
+		return 0;
+
+	/* speed down SATA link speed if possible */
+	if (ata_down_sata_spd_limit(ap) == 0)
+		return ATA_PORT_HARDRESET;
+
+	/* lower transfer mode */
+	if (ata_down_xfermask_limit(ap, dev, 0) == 0)
+		return ATA_PORT_SOFTRESET;
+
+	printk(KERN_ERR "ata%u: dev %u speed down requested but no "
+	       "transfer mode left\n", ap->id, dev->devno);
+	return 0;
+}
+
+/**
+ *	ata_eh_autopsy - analyze error and determine recovery action
+ *	@ap: host port to perform autopsy on
+ *	@qc: failed command
+ *	@tf: taskfile registers to analyze
+ *	@serror: SError value to analyze
+ *
+ *	Analyze why @qc failed and determine which recovery action is
+ *	needed.  This function also sets more detailed AC_ERR_* values
+ *	and fills sense data for ATAPI CHECK SENSE.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	Determined recovery action
+ */
+unsigned int ata_eh_autopsy(struct ata_port *ap, struct ata_queued_cmd *qc,
+			    const struct ata_taskfile *tf, u32 serror)
+{
+	unsigned int action = 0;
+
+	if (ap->flags & ATA_FLAG_FROZEN)
+		action |= ATA_PORT_SOFTRESET;
+
+	if (!qc)
+		return action;
+
+	if (qc->err_mask & AC_ERR_TIMEOUT)
+		action |= ATA_PORT_SOFTRESET;
+
+	/* determine cause of failure. */
+	action |= ata_eh_analyze_tf(qc, tf);
+	action |= ata_eh_analyze_serror(serror, &qc->err_mask);
+	action |= ata_eh_speed_down(ap, qc->dev, qc->flags & ATA_QCFLAG_IO,
+				    qc->err_mask);
+
+	/* DEV errors are probably spurious in case of ATA_BUS error */
+	if (qc->err_mask & AC_ERR_ATA_BUS)
+		qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_MEDIA | AC_ERR_INVALID);
+
+	if (qc->err_mask)
+		action |= ATA_PORT_REVALIDATE;
+
+	return action;
+}
+
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 789dd75..f65bde5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -686,6 +686,9 @@ extern void ata_eh_qc_complete(struct at
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 extern struct ata_queued_cmd * ata_eh_determine_qc(struct ata_port *ap,
 						   struct ata_taskfile *tf);
+extern unsigned int ata_eh_autopsy(struct ata_port *ap,
+				   struct ata_queued_cmd *qc,
+				   const struct ata_taskfile *tf, u32 serror);
 
 
 static inline int
-- 
1.2.4


