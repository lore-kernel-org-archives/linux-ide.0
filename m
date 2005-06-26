From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata-dev-2.6-ncq: do ata_qc_new inside host_set lock
Date: Sun, 26 Jun 2005 23:36:23 +0900
Message-ID: <20050626143623.GC24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:55992 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261279AbVFZOg3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 10:36:29 -0400
Received: by zproxy.gmail.com with SMTP id f1so96593nzc
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 07:36:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, linux-ide@vger.kernel.org

 Hello, Jeff.
 Hello, Jens.

 This is the third of six misc updates to ncq.

 ata_qc_new() used to use atomic test_and_set_bit() to allocate qc.
This makes grabbing host_set lock before calling ata_qc_new_init()
unncessary, but in most cases (normal SCSI requests) we're holding the
lock on entry anyway, so the optimization just adds expensive atomic
bitops.  This patch makes qc allocation performed inside host_set lock
and uses ffz() instead of atomic bitops.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-26 21:07:27.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-26 21:20:43.000000000 +0900
@@ -59,6 +59,8 @@ static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(struct ata_port *ap,
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
+static struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
+					      struct ata_device *dev);
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
 static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
@@ -2997,31 +2999,32 @@ out:
  *	@dev: Device from whom we request an available command structure
  *
  *	LOCKING:
- *	None.
+ *	spin_lock_irqsave(host_set lock)
  */
 
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
-	unsigned int i;
+	int i;
 
-	for (i = 0; i < ATA_MAX_CMDS; i++)
-		if (!test_and_set_bit(i, &ap->qactive))
-			return &ap->qcmd[i];
+	if (unlikely(ap->qactive == (1LU << ATA_MAX_CMDS) - 1))
+		return NULL;
 
-	return NULL;
+	i = ffz(ap->qactive);
+	ap->qactive |= 1 << i;
+	return &ap->qcmd[i];
 }
 
 /**
- *	ata_qc_new_init - Request an available ATA command, and initialize it
+ *	__ata_qc_new_init - Request an available ATA command, and initialize it
  *	@ap: Port associated with device @dev
  *	@dev: Device from whom we request an available command structure
  *
  *	LOCKING:
- *	None.
+ *	spin_lock_irqsave(host_set lock)
  */
 
-struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
-				      struct ata_device *dev)
+inline struct ata_queued_cmd *__ata_qc_new_init(struct ata_port *ap,
+						struct ata_device *dev)
 {
 	struct ata_queued_cmd *qc;
 
@@ -3045,6 +3048,19 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
+static struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
+					      struct ata_device *dev)
+{
+	unsigned long flags;
+	struct ata_queued_cmd *qc;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	qc = __ata_qc_new_init(ap, dev);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	return qc;
+}
+
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	return 0;
@@ -3078,7 +3094,7 @@ static void __ata_qc_complete(struct ata
 	}
 
 	if (likely(do_clear))
-		clear_bit(tag, &ap->qactive);
+		ap->qactive &= ~(1 << tag);
 	if (ap->cmd_waiters)
 		wake_up(&ap->cmd_wait_queue);
 }
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-06-26 21:07:27.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-06-26 21:17:25.000000000 +0900
@@ -169,7 +169,7 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 			return NULL;
 	}
 
-	qc = ata_qc_new_init(ap, dev);
+	qc = __ata_qc_new_init(ap, dev);
 	if (qc) {
 		qc->scsicmd = cmd;
 		qc->scsidone = done;
Index: work/drivers/scsi/libata.h
===================================================================
--- work.orig/drivers/scsi/libata.h	2005-06-26 21:07:20.000000000 +0900
+++ work/drivers/scsi/libata.h	2005-06-26 21:17:25.000000000 +0900
@@ -35,8 +35,8 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
-extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
-				      struct ata_device *dev);
+extern struct ata_queued_cmd *__ata_qc_new_init(struct ata_port *ap,
+						struct ata_device *dev);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
