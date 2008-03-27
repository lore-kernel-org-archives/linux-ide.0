From: Tejun Heo <htejun@gmail.com>
Subject: Debug patch to induce errors on FLUSH
Date: Thu, 27 Mar 2008 19:23:25 +0900
Message-ID: <47EB759D.1010002@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:64739 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbYC0KXb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 06:23:31 -0400
Received: by wf-out-1314.google.com with SMTP id 28so3624924wff.4
        for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2008 03:23:31 -0700 (PDT)
In-Reply-To: <12066128663306-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca

Here's the debug patch.

NOT FOR UPSTREAM
---
 drivers/ata/libata-core.c |   52 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/ata/libata-eh.c   |    2 -
 include/linux/libata.h    |    1 
 3 files changed, 52 insertions(+), 3 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -146,6 +146,15 @@ int libata_allow_tpm = 0;
 module_param_named(allow_tpm, libata_allow_tpm, int, 0444);
 MODULE_PARM_DESC(allow_tpm, "Permit the use of TPM commands");
 
+unsigned int libata_flush_dbg_do_timeout = 0;
+unsigned int libata_flush_dbg_do_deverr = 0;
+unsigned long libata_flush_dbg_fail_sector = 123456;
+unsigned int libata_flush_dbg_fail_increment = 128;
+module_param_named(flush_dbg_do_timeout, libata_flush_dbg_do_timeout, uint, 0644);
+module_param_named(flush_dbg_do_deverr, libata_flush_dbg_do_deverr, uint, 0644);
+module_param_named(flush_dbg_fail_sector, libata_flush_dbg_fail_sector, ulong, 0644);
+module_param_named(flush_dbg_fail_increment, libata_flush_dbg_fail_increment, uint, 0644);
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -5375,6 +5384,43 @@ static void ata_hsm_qc_complete(struct a
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
 
+	if (qc->tf.command == ATA_CMD_FLUSH ||
+	    qc->tf.command == ATA_CMD_FLUSH_EXT) {
+		if (libata_flush_dbg_do_timeout) {
+			libata_flush_dbg_do_timeout--;
+			ata_dev_printk(qc->dev, KERN_WARNING, "XXX: skipping completion of %02x\n",
+				       qc->tf.command);
+			return;
+		}
+
+		if (libata_flush_dbg_do_deverr) {
+			struct ata_taskfile *tf = &qc->result_tf;
+			u64 sect = libata_flush_dbg_fail_sector;
+
+			libata_flush_dbg_do_deverr--;
+
+			qc->err_mask |= AC_ERR_DEV;
+			qc->flags |= ATA_QCFLAG_NO_RTF;
+
+			ata_tf_init(qc->dev, tf);
+
+			tf->command = ATA_DRDY | ATA_ERR;
+			tf->hob_lbah = sect >> 40;
+			tf->hob_lbam = sect >> 32;
+			tf->hob_lbal = sect >> 24;
+			tf->lbah = sect >> 16;
+			tf->lbam = sect >> 8;
+			tf->lbal = sect;
+
+			ata_dev_printk(qc->dev, KERN_WARNING,
+				       "XXX: failing %02x with sector %llu\n",
+				       qc->tf.command, (unsigned long long)sect);
+
+			libata_flush_dbg_fail_sector +=
+				libata_flush_dbg_fail_increment;
+		}
+	}
+
 	if (ap->ops->error_handler) {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
@@ -5811,8 +5857,10 @@ static void fill_result_tf(struct ata_qu
 {
 	struct ata_port *ap = qc->ap;
 
-	qc->result_tf.flags = qc->tf.flags;
-	ap->ops->tf_read(ap, &qc->result_tf);
+	if (!(qc->flags & ATA_QCFLAG_NO_RTF)) {
+		qc->result_tf.flags = qc->tf.flags;
+		ap->ops->tf_read(ap, &qc->result_tf);
+	}
 }
 
 static void ata_verify_xfer(struct ata_queued_cmd *qc)
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -226,6 +226,7 @@ enum {
 	ATA_QCFLAG_CLEAR_EXCL	= (1 << 5), /* clear excl_link on completion */
 	ATA_QCFLAG_QUIET	= (1 << 6), /* don't report device error */
 	ATA_QCFLAG_RETRY	= (1 << 7), /* retry after failure */
+	ATA_QCFLAG_NO_RTF	= (1 << 8),
 
 	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1814,7 +1814,7 @@ static void ata_eh_link_autopsy(struct a
 		 * and don't be quiet about it.  As EH is gonna retry,
 		 * skip regular retry logic.
 		 */
-		if (dev->class == ATA_DEV_ATA && ata_try_flush_cache(dev) &&
+		if (dev->class == ATA_DEV_ATA && /*ata_try_flush_cache(dev) &&*/
 		    (qc->tf.command == ATA_CMD_FLUSH ||
 		     qc->tf.command == ATA_CMD_FLUSH_EXT)) {
 			ehc->i.dev_action[dev->devno] |= ATA_EH_RETRY_FLUSH;
