From: Tejun Heo <htejun@gmail.com>
Subject: [RFC PATCH libata:upstream] multi-qc SCSI cmd translation - preview
Date: Tue, 30 Aug 2005 15:25:57 +0900
Message-ID: <20050830062556.GA13245@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:16979 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750964AbVH3G0G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2005 02:26:06 -0400
Received: by wproxy.gmail.com with SMTP id i2so991279wra
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2005 23:26:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dougg@torque.net, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

 Hello, Douglas & Jeff.

 This is preview implementation of multi-qc SCSI command translation.
New translation type 'sequence' is defined and handled by sat_task
running on ata_sat_wq.  Rationale...

 a. inside qc chaining as in sil m15w workaround is too hacky & fragile.

 b. multi qc chaining without task is possible but, with thread...
	- translation implementation is easier (simple contexts on
	  stack, easier code flow...)
	- we are much less restriced in what we can do (in case full
	  SAT implementation requires something weird).
	- this isn't a hot path, simplicity & maintainability weigh
	  more than performance.

 Current implementation is broken in that each qc's completion status
cannot be acquired.  This can be fixed by adding opaque user data
field to ->complete_fn and unifying ->waiting mechanism into
->complete_fn.  If this task-based approach is okay with other ATA
developers, I'll do that and post splitted patches.

 The following is one big patch containing multi-qc sequencing
infrastructure and stupid & broken MODE_SELECT_10 implementation.
msel10 implemented here only deals with WCE and DRA of caching mode
page.  It's stupid but demonstrates enough, hopefully.

 Thanks.


diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3924,6 +3924,7 @@ static void ata_host_init(struct ata_por
 
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
+	INIT_WORK(&ap->sat_task, ata_sat_task, ap);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		ap->device[i].devno = i;
@@ -4530,6 +4531,12 @@ static int __init ata_init(void)
 	if (!ata_wq)
 		return -ENOMEM;
 
+	ata_sat_wq = create_workqueue("sat");
+	if (!ata_sat_wq) {
+		destroy_workqueue(ata_wq);
+		return -ENOMEM;
+	}
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 }
@@ -4537,6 +4544,7 @@ static int __init ata_init(void)
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
+	destroy_workqueue(ata_sat_wq);
 }
 
 module_init(ata_init);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -36,6 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
@@ -44,10 +45,26 @@
 
 #include "libata.h"
 
-typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, u8 *scsicmd);
+enum {
+	ATA_SAT_SIMULATE,	/* scmd is to be simulated */
+	ATA_SAT_XLAT,		/* scmd -> single qc translation */
+	ATA_SAT_SEQUENCE,	/* scmd -> qc sequence translation */
+};
+
+struct ata_sat_info {
+	int mode;
+	union {
+		ata_sat_xlat_func_t xlat_func;
+		ata_sat_seq_func_t seq_func;
+	} f; /* No anonymous union yet */
+};
+
+struct workqueue_struct *ata_sat_wq;
+
 static struct ata_device *
 ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev);
-
+static unsigned int ata_scsi_rbuf_get(struct scsi_cmnd *cmd, u8 **buf_out);
+static void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, u8 *buf);
 
 /**
  *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
@@ -738,7 +755,7 @@ static int ata_scsi_qc_complete(struct a
 static void ata_scsi_translate(struct ata_port *ap, struct ata_device *dev,
 			      struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *),
-			      ata_xlat_func_t xlat_func)
+			      ata_sat_xlat_func_t xlat_func)
 {
 	struct ata_queued_cmd *qc;
 	u8 *scsicmd = cmd->cmnd;
@@ -785,6 +802,132 @@ err_out:
 	DPRINTK("EXIT - badcmd\n");
 }
 
+static int ata_scsi_seq_exec_qc(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	DECLARE_COMPLETION(wait);
+	unsigned long flags;
+	int rc;
+
+	qc->waiting = &wait;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	if (rc)
+		ata_qc_free(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (!rc)
+		wait_for_completion(&wait);
+	return rc;
+}
+
+static void ata_scsi_modeselect10_seq(struct ata_port *ap,
+				      struct ata_device *dev,
+				      struct scsi_cmnd *cmd,
+				      void (*done)(struct scsi_cmnd *))
+{
+	u8 *rbuf;
+	unsigned buflen;
+	int okay = 0, wce = 0, dra = 0;
+	struct ata_queued_cmd *qc;
+
+	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
+
+	if (buflen >= 21 && rbuf[8 + 0] == 0x08) {
+		wce = rbuf[8 + 2] & 0x04;
+		dra = rbuf[8 + 12] & 0x20;
+		okay = 1;
+	}
+
+	ata_scsi_rbuf_put(cmd, rbuf);
+
+	if (!okay)
+		goto err_out;
+
+	/* WCE first */
+	qc = ata_scsi_qc_new(ap, dev, cmd, done);
+	if (!qc)
+		return;
+
+	qc->tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	qc->tf.protocol = ATA_PROT_NODATA;
+	qc->tf.command = ATA_CMD_SET_FEATURES;
+	qc->tf.feature = wce ? 0x02 : 0x82;
+
+	if (ata_scsi_seq_exec_qc(qc))
+		goto err_out;
+
+	/* DRA now */
+	qc = ata_scsi_qc_new(ap, dev, cmd, done);
+	if (!qc)
+		return;
+
+	qc->tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	qc->tf.protocol = ATA_PROT_NODATA;
+	qc->tf.command = ATA_CMD_SET_FEATURES;
+	qc->tf.feature = !dra ? 0xaa : 0x55;
+
+	if (ata_scsi_seq_exec_qc(qc))
+		goto err_out;
+
+	cmd->result = SAM_STAT_GOOD;
+	done(cmd);
+	return;
+
+ err_out:
+	ata_scsi_badcmd(cmd, done, 0x20, 0x00);
+}
+
+void ata_sat_task(void *_data)
+{
+	struct ata_port *ap = _data;
+
+	ap->sat_seq_func(ap, ap->sat_dev, ap->sat_scsicmd, ap->sat_done);
+	smp_wmb();
+	ap->sat_scsicmd = NULL;
+}
+
+/**
+ *	ata_scsi_sequence - 
+ *	@ap: ATA port to which the command is addressed
+ *	@dev: ATA device to which the command is addressed
+ *	@cmd: SCSI command to execute
+ *	@done: SCSI command completion function
+ *	@seq_func: Actor which sequences @cmd
+ *
+ *	Our ->queuecommand() function has decided that the SCSI
+ *	command issued should be sequenced.  Note that only one
+ *	concurrent sequencing is allowed per port.
+ *
+ *	This function sets up an per dev sequence data and queues
+ *	dev->sat_task.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_scsi_sequence(struct ata_port *ap, struct ata_device *dev,
+			      struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *),
+			      ata_sat_seq_func_t seq_func)
+{
+	if (ap->sat_scsicmd != NULL) {
+		cmd->result = (DID_OK << 16) | (QUEUE_FULL << 1);
+		done(cmd);
+		return;
+	}
+
+	ap->sat_scsicmd = cmd;
+	ap->sat_dev = dev;
+	ap->sat_seq_func = seq_func;
+	ap->sat_done = done;
+
+	queue_work(ata_sat_wq, &ap->sat_task);
+
+	return;
+}
+
 /**
  *	ata_scsi_rbuf_get - Map response buffer.
  *	@cmd: SCSI command containing buffer to be mapped.
@@ -1479,19 +1622,22 @@ ata_scsi_find_dev(struct ata_port *ap, s
 }
 
 /**
- *	ata_get_xlat_func - check if SCSI to ATA translation is possible
+ *	ata_get_sat_info - determine how a SCSI command should be handled
  *	@dev: ATA device
  *	@cmd: SCSI command opcode to consider
  *
  *	Look up the SCSI command given, and determine whether the
- *	SCSI command is to be translated or simulated.
+ *	SCSI command is to be simulated, translated or sequenced.
  *
  *	RETURNS:
  *	Pointer to translation function if possible, %NULL if not.
  */
 
-static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
+static inline struct ata_sat_info ata_get_sat_info(struct ata_device *dev,
+						   u8 cmd)
 {
+	struct ata_sat_info si = { .mode = ATA_SAT_SIMULATE };
+
 	switch (cmd) {
 	case READ_6:
 	case READ_10:
@@ -1500,21 +1646,35 @@ static inline ata_xlat_func_t ata_get_xl
 	case WRITE_6:
 	case WRITE_10:
 	case WRITE_16:
-		return ata_scsi_rw_xlat;
+		si.mode = ATA_SAT_XLAT;
+		si.f.xlat_func = ata_scsi_rw_xlat;
+		break;
 
 	case SYNCHRONIZE_CACHE:
-		if (ata_try_flush_cache(dev))
-			return ata_scsi_flush_xlat;
+		if (ata_try_flush_cache(dev)) {
+			si.mode = ATA_SAT_XLAT;
+			si.f.xlat_func = ata_scsi_flush_xlat;
+		}
 		break;
 
 	case VERIFY:
 	case VERIFY_16:
-		return ata_scsi_verify_xlat;
+		si.mode = ATA_SAT_XLAT;
+		si.f.xlat_func = ata_scsi_verify_xlat;
+		break;
+
 	case START_STOP:
-		return ata_scsi_start_stop_xlat;
+		si.mode = ATA_SAT_XLAT;
+		si.f.xlat_func = ata_scsi_start_stop_xlat;
+		break;
+
+	case MODE_SELECT_10:
+		si.mode = ATA_SAT_SEQUENCE;
+		si.f.seq_func = ata_scsi_modeselect10_seq;
+		break;
 	}
 
-	return NULL;
+	return si;
 }
 
 /**
@@ -1578,13 +1738,19 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 	}
 
 	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      cmd->cmnd[0]);
+		struct ata_sat_info si = ata_get_sat_info(dev, cmd->cmnd[0]);
 
-		if (xlat_func)
-			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
-		else
+		switch (si.mode) {
+		case ATA_SAT_SIMULATE:
 			ata_scsi_simulate(dev->id, cmd, done);
+			break;
+		case ATA_SAT_XLAT:
+			ata_scsi_translate(ap, dev, cmd, done, si.f.xlat_func);
+			break;
+		case ATA_SAT_SEQUENCE:
+			ata_scsi_sequence(ap, dev, cmd, done, si.f.seq_func);
+			break;
+		}
 	} else
 		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -50,6 +50,10 @@ extern void swap_buf_le16(u16 *buf, unsi
 
 
 /* libata-scsi.c */
+extern struct workqueue_struct *ata_sat_wq;
+
+extern void ata_sat_task(void *_data);
+
 extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -172,10 +172,16 @@ enum pio_task_states {
 struct scsi_device;
 struct ata_port_operations;
 struct ata_port;
+struct ata_device;
 struct ata_queued_cmd;
 
 /* typedefs */
 typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat);
+typedef unsigned int (*ata_sat_xlat_func_t)(struct ata_queued_cmd *qc,
+					    u8 *scsicmd);
+typedef void (*ata_sat_seq_func_t)(struct ata_port *ap,struct ata_device *dev,
+				   struct scsi_cmnd *cmd,
+				   void (*done)(struct scsi_cmnd *));
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -323,6 +329,12 @@ struct ata_port {
 	unsigned int		pio_task_state;
 	unsigned long		pio_task_timeout;
 
+	struct work_struct	sat_task;
+	struct scsi_cmnd	*sat_scsicmd;
+	struct ata_device	*sat_dev;
+	ata_sat_seq_func_t	sat_seq_func;
+	void (*sat_done)(struct scsi_cmnd *);
+
 	void			*private_data;
 };
 
