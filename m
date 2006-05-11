From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/11] libata-eh: implement new EH
Date: Thu, 11 May 2006 22:21:27 +0900
Message-ID: <114735368767-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:48375 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751728AbWEKNVi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:38 -0400
Received: by py-out-1112.google.com with SMTP id f28so234245pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:38 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement new EH.  The exported interface is ata_do_eh() which is to
be called from ->error_handler and performs the following steps to
recover the failed port.

ata_eh_autopsy() : analyze SError/TF, determine the cause of failure
		   and required recovery actions and record it in
		   ap->eh_context
ata_eh_report()	 : report the failure to user
ata_eh_recover() : perform recovery actions described in ap->eh_context
ata_eh_finish()	 : finish failed qcs

LLDDs can customize error handling by modifying eh_context before
calling ata_do_eh() or, if necessary, doing so inbetween each major
steps by calling each step explicitly.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 
 drivers/scsi/libata-eh.c   |  775 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    5 
 3 files changed, 781 insertions(+), 0 deletions(-)

09973781fb6f52e6592be1aeb155547c3941370d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index afb7796..35faf66 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5440,3 +5440,4 @@ EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
 EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
+EXPORT_SYMBOL_GPL(ata_do_eh);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 5a76e22..41b36c5 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -632,3 +632,778 @@ void ata_eh_qc_retry(struct ata_queued_c
 		scmd->retries--;
 	__ata_eh_qc_complete(qc);
 }
+
+/**
+ *	ata_eh_about_to_do - about to perform eh_action
+ *	@ap: target ATA port
+ *	@action: action about to be performed
+ *
+ *	Called just before performing EH actions to clear related bits
+ *	in @ap->eh_info such that eh actions are not unnecessarily
+ *	repeated.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_eh_about_to_do(struct ata_port *ap, unsigned int action)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->eh_info.action &= ~action;
+	ap->flags |= ATA_FLAG_RECOVERED;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
+/**
+ *	ata_err_string - convert err_mask to descriptive string
+ *	@err_mask: error mask to convert to string
+ *
+ *	Convert @err_mask to descriptive string.  Errors are
+ *	prioritized according to severity and only the most severe
+ *	error is reported.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Descriptive string for @err_mask
+ */
+static const char * ata_err_string(unsigned int err_mask)
+{
+	if (err_mask & AC_ERR_HOST_BUS)
+		return "host bus error";
+	if (err_mask & AC_ERR_ATA_BUS)
+		return "ATA bus error";
+	if (err_mask & AC_ERR_TIMEOUT)
+		return "timeout";
+	if (err_mask & AC_ERR_HSM)
+		return "HSM violation";
+	if (err_mask & AC_ERR_SYSTEM)
+		return "internal error";
+	if (err_mask & AC_ERR_MEDIA)
+		return "media error";
+	if (err_mask & AC_ERR_INVALID)
+		return "invalid argument";
+	if (err_mask & AC_ERR_DEV)
+		return "device error";
+	return "unknown error";
+}
+
+/**
+ *	atapi_eh_request_sense - perform ATAPI REQUEST_SENSE
+ *	@dev: device to perform REQUEST_SENSE to
+ *	@sense_buf: result sense data buffer (SCSI_SENSE_BUFFERSIZE bytes long)
+ *
+ *	Perform ATAPI REQUEST_SENSE after the device reported CHECK
+ *	SENSE.  This function is EH helper.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask on failure
+ */
+static unsigned int atapi_eh_request_sense(struct ata_device *dev,
+					   unsigned char *sense_buf)
+{
+	struct ata_port *ap = dev->ap;
+	struct ata_taskfile tf;
+	u8 cdb[ATAPI_CDB_LEN];
+
+	DPRINTK("ATAPI request sense\n");
+
+	ata_tf_init(dev, &tf);
+
+	/* FIXME: is this needed? */
+	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
+
+	/* XXX: why tf_read here? */
+	ap->ops->tf_read(ap, &tf);
+
+	/* fill these in, for the case where they are -not- overwritten */
+	sense_buf[0] = 0x70;
+	sense_buf[2] = tf.feature >> 4;
+
+	memset(cdb, 0, ATAPI_CDB_LEN);
+	cdb[0] = REQUEST_SENSE;
+	cdb[4] = SCSI_SENSE_BUFFERSIZE;
+
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.command = ATA_CMD_PACKET;
+
+	/* is it pointless to prefer PIO for "safety reasons"? */
+	if (ap->flags & ATA_FLAG_PIO_DMA) {
+		tf.protocol = ATA_PROT_ATAPI_DMA;
+		tf.feature |= ATAPI_PKT_DMA;
+	} else {
+		tf.protocol = ATA_PROT_ATAPI;
+		tf.lbam = (8 * 1024) & 0xff;
+		tf.lbah = (8 * 1024) >> 8;
+	}
+
+	return ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,
+				 sense_buf, SCSI_SENSE_BUFFERSIZE);
+}
+
+/**
+ *	ata_eh_analyze_serror - analyze SError for a failed port
+ *	@ap: ATA port to analyze SError for
+ *
+ *	Analyze SError if available and further determine cause of
+ *	failure.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_eh_analyze_serror(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	u32 serror = ehc->i.serror;
+	unsigned int err_mask = 0, action = 0;
+
+	if (serror & SERR_PERSISTENT) {
+		err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_EH_HARDRESET;
+	}
+	if (serror &
+	    (SERR_DATA_RECOVERED | SERR_COMM_RECOVERED | SERR_DATA)) {
+		err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_EH_SOFTRESET;
+	}
+	if (serror & SERR_PROTOCOL) {
+		err_mask |= AC_ERR_HSM;
+		action |= ATA_EH_SOFTRESET;
+	}
+	if (serror & SERR_INTERNAL) {
+		err_mask |= AC_ERR_SYSTEM;
+		action |= ATA_EH_SOFTRESET;
+	}
+	if (serror & (SERR_PHYRDY_CHG | SERR_DEV_XCHG)) {
+		err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_EH_HARDRESET;
+	}
+
+	ehc->i.err_mask |= err_mask;
+	ehc->i.action |= action;
+}
+
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
+ *	Kernel thread context (may sleep).
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
+		return ATA_EH_SOFTRESET;
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
+		tmp = atapi_eh_request_sense(qc->dev,
+					     qc->scsicmd->sense_buffer);
+		if (!tmp) {
+			/* ATA_QCFLAG_SENSE_VALID is used to tell
+			 * atapi_qc_complete() that sense data is
+			 * already valid.
+			 *
+			 * TODO: interpret sense data and set
+			 * appropriate err_mask.
+			 */
+			qc->flags |= ATA_QCFLAG_SENSE_VALID;
+		} else
+			qc->err_mask |= tmp;
+	}
+
+	if (qc->err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT | AC_ERR_ATA_BUS))
+		action |= ATA_EH_SOFTRESET;
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
+ *	there have been more than 3 of Cat-1 errors or 10 of Cat-2
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
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise
+ */
+static int ata_eh_speed_down(struct ata_device *dev, int is_io,
+			     unsigned int err_mask)
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
+	if (ata_down_sata_spd_limit(dev->ap) == 0)
+		return ATA_EH_HARDRESET;
+
+	/* lower transfer mode */
+	if (ata_down_xfermask_limit(dev, 0) == 0)
+		return ATA_EH_SOFTRESET;
+
+	ata_dev_printk(dev, KERN_ERR,
+		       "speed down requested but no transfer mode left\n");
+	return 0;
+}
+
+/**
+ *	ata_eh_autopsy - analyze error and determine recovery action
+ *	@ap: ATA port to perform autopsy on
+ *
+ *	Analyze why @ap failed and determine which recovery action is
+ *	needed.  This function also sets more detailed AC_ERR_* values
+ *	and fills sense data for ATAPI CHECK SENSE.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_autopsy(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	unsigned int action = ehc->i.action;
+	struct ata_device *failed_dev = NULL;
+	unsigned int all_err_mask = 0;
+	int tag, is_io = 0;
+	u32 serror;
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* obtain and analyze SError */
+	rc = ata_scr_read(ap, SCR_ERROR, &serror);
+	if (rc == 0) {
+		ehc->i.serror |= serror;
+		ata_eh_analyze_serror(ap);
+	} else if (rc != -EOPNOTSUPP)
+		action |= ATA_EH_HARDRESET;
+
+	/* any real error trumps AC_ERR_OTHER */
+	if (ehc->i.err_mask & ~AC_ERR_OTHER)
+		ehc->i.err_mask &= ~AC_ERR_OTHER;
+
+	all_err_mask |= ehc->i.err_mask;
+
+	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+
+		if (!(qc->flags & ATA_QCFLAG_FAILED))
+			continue;
+
+		/* inherit upper level err_mask */
+		qc->err_mask |= ehc->i.err_mask;
+
+		if (qc->err_mask & AC_ERR_TIMEOUT)
+			action |= ATA_EH_SOFTRESET;
+
+		/* analyze TF */
+		action |= ata_eh_analyze_tf(qc, &qc->result_tf);
+
+		/* DEV errors are probably spurious in case of ATA_BUS error */
+		if (qc->err_mask & AC_ERR_ATA_BUS)
+			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_MEDIA |
+					  AC_ERR_INVALID);
+
+		/* any real error trumps unknown error */
+		if (qc->err_mask & ~AC_ERR_OTHER)
+			qc->err_mask &= ~AC_ERR_OTHER;
+
+		/* SENSE_VALID trumps dev/unknown error and revalidation */
+		if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
+			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER);
+			action &= ~ATA_EH_REVALIDATE;
+		}
+
+		/* accumulate error info */
+		failed_dev = qc->dev;
+		all_err_mask |= qc->err_mask;
+		if (qc->flags & ATA_QCFLAG_IO)
+			is_io = 1;
+	}
+
+	/* speed down iff command was in progress */
+	if (failed_dev)
+		action |= ata_eh_speed_down(failed_dev, is_io, all_err_mask);
+
+	if (all_err_mask)
+		action |= ATA_EH_REVALIDATE;
+
+	ehc->i.dev = failed_dev;
+	ehc->i.action = action;
+
+	DPRINTK("EXIT\n");
+}
+
+/**
+ *	ata_eh_report - report error handling to user
+ *	@ap: ATA port EH is going on
+ *
+ *	Report EH to user.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_eh_report(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	const char *frozen, *desc;
+	int tag, nr_failed = 0;
+
+	desc = NULL;
+	if (ehc->i.desc[0] != '\0')
+		desc = ehc->i.desc;
+
+	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+
+		if (!(qc->flags & ATA_QCFLAG_FAILED))
+			continue;
+		if (qc->flags & ATA_QCFLAG_SENSE_VALID && !qc->err_mask)
+			continue;
+
+		nr_failed++;
+	}
+
+	if (!nr_failed && !ehc->i.err_mask)
+		return;
+
+	frozen = "";
+	if (ap->flags & ATA_FLAG_FROZEN)
+		frozen = " frozen";
+
+	if (ehc->i.dev) {
+		ata_dev_printk(ehc->i.dev, KERN_ERR,
+			       "exception Emask 0x%x SErr 0x%x action 0x%x%s\n",
+			       ehc->i.err_mask, ehc->i.serror, ehc->i.action,
+			       frozen);
+		if (desc)
+			ata_dev_printk(ehc->i.dev, KERN_ERR, "(%s)\n", desc);
+	} else {
+		ata_port_printk(ap, KERN_ERR,
+				"exception Emask 0x%x SErr 0x%x action 0x%x%s\n",
+				ehc->i.err_mask, ehc->i.serror, ehc->i.action,
+				frozen);
+		if (desc)
+			ata_port_printk(ap, KERN_ERR, "(%s)\n", desc);
+	}
+
+	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+
+		if (!(qc->flags & ATA_QCFLAG_FAILED) || !qc->err_mask)
+			continue;
+
+		ata_dev_printk(qc->dev, KERN_ERR, "tag %d cmd 0x%x "
+			       "Emask 0x%x stat 0x%x err 0x%x (%s)\n",
+			       qc->tag, qc->tf.command, qc->err_mask,
+			       qc->result_tf.command, qc->result_tf.feature,
+			       ata_err_string(qc->err_mask));
+	}
+}
+
+static int ata_eh_reset(struct ata_port *ap, ata_reset_fn_t softreset,
+			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	unsigned int classes[ATA_MAX_DEVICES];
+	int tries = ATA_EH_RESET_TRIES;
+	ata_reset_fn_t reset;
+	int rc;
+
+	if (softreset && (!hardreset || (!ata_set_sata_spd_needed(ap) &&
+					 !(ehc->i.action & ATA_EH_HARDRESET))))
+		reset = softreset;
+	else
+		reset = hardreset;
+
+ retry:
+	ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
+			reset == softreset ? "soft" : "hard");
+
+	/* reset */
+	ata_eh_about_to_do(ap, ATA_EH_RESET_MASK);
+	ehc->flags |= ATA_EHC_DID_RESET;
+
+	rc = ata_do_reset(ap, reset, classes);
+
+	if (rc && --tries) {
+		ata_port_printk(ap, KERN_WARNING,
+				"%sreset failed, retrying in 5 secs\n",
+				reset == softreset ? "soft" : "hard");
+		ssleep(5);
+
+		if (reset == hardreset)
+			ata_down_sata_spd_limit(ap);
+		if (hardreset)
+			reset = hardreset;
+		goto retry;
+	}
+
+	if (rc == 0) {
+		if (postreset)
+			postreset(ap, classes);
+
+		/* reset successful, schedule revalidation */
+		ehc->i.dev = NULL;
+		ehc->i.action &= ~ATA_EH_RESET_MASK;
+		ehc->i.action |= ATA_EH_REVALIDATE;
+	}
+
+	return rc;
+}
+
+static int ata_eh_revalidate(struct ata_port *ap,
+			     struct ata_device **r_failed_dev)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_device *dev;
+	int i, rc = 0;
+
+	DPRINTK("ENTER\n");
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+
+		if (ehc->i.action & ATA_EH_REVALIDATE && ata_dev_enabled(dev) &&
+		    (!ehc->i.dev || ehc->i.dev == dev)) {
+			if (ata_port_offline(ap)) {
+				rc = -EIO;
+				break;
+			}
+
+			ata_eh_about_to_do(ap, ATA_EH_REVALIDATE);
+			rc = ata_dev_revalidate(dev,
+						ehc->flags & ATA_EHC_DID_RESET);
+			if (rc)
+				break;
+
+			ehc->i.action &= ~ATA_EH_REVALIDATE;
+		}
+	}
+
+	if (rc)
+		*r_failed_dev = dev;
+
+	DPRINTK("EXIT\n");
+	return rc;
+}
+
+static int ata_port_nr_enabled(struct ata_port *ap)
+{
+	int i, cnt = 0;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (ata_dev_enabled(&ap->device[i]))
+			cnt++;
+	return cnt;
+}
+
+/**
+ *	ata_eh_recover - recover host port after error
+ *	@ap: host port to recover
+ *	@softreset: softreset method (can be NULL)
+ *	@hardreset: hardreset method (can be NULL)
+ *	@postreset: postreset method (can be NULL)
+ *
+ *	This is the alpha and omega, eum and yang, heart and soul of
+ *	libata exception handling.  On entry, actions required to
+ *	recover each devices are recorded in eh_context.  This
+ *	function executes all the operations with appropriate retrials
+ *	and fallbacks to resurrect failed devices.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+static int ata_eh_recover(struct ata_port *ap, ata_reset_fn_t softreset,
+			  ata_reset_fn_t hardreset,
+			  ata_postreset_fn_t postreset)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_device *dev;
+	int down_xfermask, i, rc;
+
+	DPRINTK("ENTER\n");
+
+	/* prep for recovery */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+
+		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
+	}
+
+ retry:
+	down_xfermask = 0;
+	rc = 0;
+
+	/* skip EH if possible. */
+	if (!ata_port_nr_enabled(ap) && !(ap->flags & ATA_FLAG_FROZEN))
+		ehc->i.action = 0;
+
+	/* reset */
+	if (ehc->i.action & ATA_EH_RESET_MASK) {
+		ata_eh_freeze_port(ap);
+
+		rc = ata_eh_reset(ap, softreset, hardreset, postreset);
+		if (rc) {
+			ata_port_printk(ap, KERN_ERR,
+					"reset failed, giving up\n");
+			goto out;
+		}
+
+		ata_eh_thaw_port(ap);
+	}
+
+	/* revalidate existing devices */
+	rc = ata_eh_revalidate(ap, &dev);
+	if (rc)
+		goto dev_fail;
+
+	/* configure transfer mode if the port has been reset */
+	if (ehc->flags & ATA_EHC_DID_RESET) {
+		rc = ata_set_mode(ap, &dev);
+		if (rc) {
+			down_xfermask = 1;
+			goto dev_fail;
+		}
+	}
+
+	goto out;
+
+ dev_fail:
+	switch (rc) {
+	case -ENODEV:
+	case -EINVAL:
+		ehc->tries[dev->devno] = 0;
+		break;
+	case -EIO:
+		ata_down_sata_spd_limit(ap);
+	default:
+		ehc->tries[dev->devno]--;
+		if (down_xfermask &&
+		    ata_down_xfermask_limit(dev, ehc->tries[dev->devno] == 1))
+			ehc->tries[dev->devno] = 0;
+	}
+
+	/* disable device if it has used up all its chances */
+	if (ata_dev_enabled(dev) && !ehc->tries[dev->devno])
+		ata_dev_disable(dev);
+
+	/* soft didn't work?  be haaaaard */
+	if (ehc->flags & ATA_EHC_DID_RESET)
+		ehc->i.action |= ATA_EH_HARDRESET;
+	else
+		ehc->i.action |= ATA_EH_SOFTRESET;
+
+	if (ata_port_nr_enabled(ap)) {
+		ata_port_printk(ap, KERN_WARNING, "failed to recover some "
+				"devices, retrying in 5 secs\n");
+		ssleep(5);
+	} else {
+		/* no device left, repeat fast */
+		msleep(500);
+	}
+
+	goto retry;
+
+ out:
+	if (rc) {
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			ata_dev_disable(&ap->device[i]);
+	}
+
+	DPRINTK("EXIT, rc=%d\n", rc);
+	return rc;
+}
+
+/**
+ *	ata_eh_finish - finish up EH
+ *	@ap: host port to finish EH for
+ *
+ *	Recovery is complete.  Clean up EH states and retry or finish
+ *	failed qcs.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_eh_finish(struct ata_port *ap)
+{
+	int tag;
+
+	/* retry or finish qcs */
+	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+
+		if (!(qc->flags & ATA_QCFLAG_FAILED))
+			continue;
+
+		if (qc->err_mask) {
+			/* FIXME: Once EH migration is complete,
+			 * generate sense data in this function,
+			 * considering both err_mask and tf.
+			 */
+			if (qc->err_mask & AC_ERR_INVALID)
+				ata_eh_qc_complete(qc);
+			else
+				ata_eh_qc_retry(qc);
+		} else {
+			if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
+				ata_eh_qc_complete(qc);
+			} else {
+				/* feed zero TF to sense generation */
+				memset(&qc->result_tf, 0, sizeof(qc->result_tf));
+				ata_eh_qc_retry(qc);
+			}
+		}
+	}
+}
+
+/**
+ *	ata_do_eh - do standard error handling
+ *	@ap: host port to handle error for
+ *	@softreset: softreset method (can be NULL)
+ *	@hardreset: hardreset method (can be NULL)
+ *	@postreset: postreset method (can be NULL)
+ *
+ *	Perform standard error handling sequence.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_do_eh(struct ata_port *ap, ata_reset_fn_t softreset,
+	       ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
+{
+	ata_eh_autopsy(ap);
+	ata_eh_report(ap);
+	ata_eh_recover(ap, softreset, hardreset, postreset);
+	ata_eh_finish(ap);
+}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c5c5f18..867f1d5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -246,6 +246,8 @@ enum {
 
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
+	ATA_EH_RESET_TRIES	= 3,
+	ATA_EH_DEV_TRIES	= 3,
 };
 
 enum hsm_task_states {
@@ -730,6 +732,9 @@ extern void ata_eh_thaw_port(struct ata_
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 
+extern void ata_do_eh(struct ata_port *ap, ata_reset_fn_t softreset,
+		      ata_reset_fn_t hardreset, ata_postreset_fn_t postreset);
+
 /*
  * printk helpers
  */
-- 
1.2.4


