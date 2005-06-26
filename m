From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata-dev-2.6-ncq: make tag 31 reserved for EH
Date: Sun, 26 Jun 2005 23:50:54 +0900
Message-ID: <20050626145054.GE24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:38613 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261293AbVFZOvC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 10:51:02 -0400
Received: by wproxy.gmail.com with SMTP id i1so197572wra
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 07:51:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, linux-ide@vger.kernel.org

 Hello, Jeff.
 Hello, Jens.

 This is the fifth of six misc updates to ncq.

 This patch makes tag 31 reserved for EH (currently only
ata_read_log_page).  Previously, when EH competes w/ other special
commands, it could lose hitting BUG().  Also, as tag 31 will never be
used for NCQ commands, we can use tag 30 for NCQ commands without
worrying about SActive 0xffffffff error, thus increasing ATA_MAX_QUEUE
by one.  (BTW, what's this error?  I couldn't find anything in the
docs.)

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-26 22:11:49.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-26 23:15:44.000000000 +0900
@@ -61,6 +61,8 @@ static int ata_choose_xfer_mode(struct a
 				unsigned int *xfer_shift_out);
 static struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 					      struct ata_device *dev);
+static struct ata_queued_cmd *ata_eh_qc_new_init(struct ata_port *ap,
+						 struct ata_device *dev);
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
 static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
@@ -1335,7 +1337,7 @@ int ata_read_log_page(struct ata_port *a
 
 	assert(dev->class == ATA_DEV_ATA);
 
-	qc = ata_qc_new_init(ap, dev);
+	qc = ata_eh_qc_new_init(ap, dev);
 	BUG_ON(qc == NULL);
 
 	ata_sg_init_one(qc, buffer, sectors << 9);
@@ -3004,9 +3006,10 @@ out:
 
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
+	unsigned long mask = (1LU << ATA_MAX_QUEUE) - 1;
 	int i;
 
-	if (unlikely(ap->qactive == (1LU << ATA_MAX_CMDS) - 1))
+	if (unlikely((ap->qactive & mask) == mask))
 		return NULL;
 
 	i = ffz(ap->qactive);
@@ -3014,6 +3017,33 @@ static struct ata_queued_cmd *ata_qc_new
 	return &ap->qcmd[i];
 }
 
+/*
+ *	ata_qc_init - Initialize an ATA command
+ *	@qc: Command to initialize
+ *	@ap: Port associated with device @dev
+ *	@dev: Device from whom we allocated @qc
+ *
+ *	LOCKING:
+ *	Don't care.
+ */
+static inline void ata_qc_init(struct ata_queued_cmd *qc,
+			       struct ata_port *ap, struct ata_device *dev)
+{
+	qc->sg = NULL;
+	qc->flags = 0;
+	qc->scsicmd = NULL;
+	qc->ap = ap;
+	qc->dev = dev;
+	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
+	qc->nsect = 0;
+	qc->nbytes = qc->curbytes = 0;
+
+	ata_tf_init(ap, &qc->tf, dev->devno);
+
+	if (dev->flags & ATA_DFLAG_LBA48)
+		qc->tf.flags |= ATA_TFLAG_LBA48;
+}
+
 /**
  *	__ata_qc_new_init - Request an available ATA command, and initialize it
  *	@ap: Port associated with device @dev
@@ -3028,23 +3058,8 @@ inline struct ata_queued_cmd *__ata_qc_n
 {
 	struct ata_queued_cmd *qc;
 
-	qc = ata_qc_new(ap);
-	if (qc) {
-		qc->sg = NULL;
-		qc->flags = 0;
-		qc->scsicmd = NULL;
-		qc->ap = ap;
-		qc->dev = dev;
-		qc->cursect = qc->cursg = qc->cursg_ofs = 0;
-		qc->nsect = 0;
-		qc->nbytes = qc->curbytes = 0;
-
-		ata_tf_init(ap, &qc->tf, dev->devno);
-
-		if (dev->flags & ATA_DFLAG_LBA48)
-			qc->tf.flags |= ATA_TFLAG_LBA48;
-	}
-
+	if ((qc = ata_qc_new(ap)) != NULL)
+		ata_qc_init(qc, ap, dev);
 	return qc;
 }
 
@@ -3061,6 +3076,30 @@ static struct ata_queued_cmd *ata_qc_new
 	return qc;
 }
 
+/**
+ *	ata_eh_qc_new_init - Request an eh ATA command, and initialize it
+ *	@ap: Port associated with device @dev
+ *	@dev: Device from whom we request an eh command structure
+ *
+ *	Currently, ata_read_log_page is the only user of eh qc.  Don't
+ *	forget to add synchronizaton (simple mutex will suffice) when
+ *	adding other users of eh qc.
+ *
+ *	LOCKING:
+ *	None.
+ */
+
+static struct ata_queued_cmd *ata_eh_qc_new_init(struct ata_port *ap,
+						 struct ata_device *dev)
+{
+	struct ata_queued_cmd *qc = &ap->qcmd[ATA_MAX_QUEUE];
+	BUG_ON((ap->qactive & (1 << ATA_MAX_QUEUE)) ||
+	       (qc->flags & ATA_QCFLAG_ACTIVE));
+	ap->qactive |= 1 << ATA_MAX_QUEUE;
+	ata_qc_init(qc, ap, dev);
+	return qc;
+}
+
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	return 0;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-06-26 22:11:49.000000000 +0900
+++ work/include/linux/libata.h	2005-06-26 23:15:44.000000000 +0900
@@ -80,8 +80,9 @@ enum {
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
 	ATA_MAX_PORTS		= 8,
 	ATA_DEF_QUEUE		= 1,
-	ATA_MAX_CMDS		= 31,	/* to avoid SActive 0xffffffff error */
-	ATA_MAX_QUEUE		= 30,	/* leave one command for errors */
+	ATA_MAX_CMDS		= 32,	/* slot 31 is EH only,
+					 * SActive 0xffffffff won't occur */
+	ATA_MAX_QUEUE		= 31,	/* leave one command for errors */
 	ATA_MAX_SECTORS		= 200,	/* FIXME */
 	ATA_MAX_BUS		= 2,
 	ATA_DEF_BUSY_WAIT	= 10000,
