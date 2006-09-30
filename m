From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] libata: implement presence detection via polling IDENTIFY
Date: Sat, 30 Sep 2006 15:46:50 +0900
Message-ID: <11595988103169-git-send-email-htejun@gmail.com>
References: <11595988092938-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:36573 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751087AbWI3Gq5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 02:46:57 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1162647wxc
        for <linux-ide@vger.kernel.org>; Fri, 29 Sep 2006 23:46:56 -0700 (PDT)
In-Reply-To: <11595988092938-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, jgarzik@pobox.com, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

On some controllers (ICHs in piix mode), there is *NO* reliable way to
determine device presence other than issuing IDENTIFY and see how the
transaction proceeds by watching the TF status register.

libata acted this way before irq-pio and phantom devices caused very
little problem but now that IDENTIFY is performed using IRQ drive PIO,
such phantom devices now result in multiple 30sec timeouts during
boot.

This patch implements ATA_FLAG_DETECT_POLLING.  If a LLD sets this
flag, libata core issues the initial IDENTIFY in polling mode and if
the initial data transfer fails w/ HSM violation, the port is
considered to be empty thus replicating the old libata and IDE
behavior.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   19 +++++++++++++++++--
 drivers/ata/libata-eh.c   |   20 +++++++++++++++++---
 drivers/ata/libata.h      |    2 ++
 include/linux/libata.h    |    3 +++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8e8f359..9c3963e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1268,9 +1268,20 @@ int ata_dev_read_id(struct ata_device *d
 
 	tf.protocol = ATA_PROT_PIO;
 
+	/* presence detection using polling IDENTIFY? */
+	if (flags & ATA_READID_DETECT)
+		tf.flags |= ATA_TFLAG_POLLING;
+
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
 	if (err_mask) {
+		if ((flags & ATA_READID_DETECT) &&
+		    (err_mask & AC_ERR_NODEV_HINT)) {
+			DPRINTK("ata%u.%d: NODEV after polling detection\n",
+				ap->id, dev->devno);
+			return -ENOENT;
+		}
+
 		rc = -EIO;
 		reason = "I/O error";
 		goto err_out;
@@ -4197,8 +4208,12 @@ fsm_start:
 					/* device stops HSM for abort/error */
 					qc->err_mask |= AC_ERR_DEV;
 				else
-					/* HSM violation. Let EH handle this */
-					qc->err_mask |= AC_ERR_HSM;
+					/* HSM violation. Let EH handle this.
+					 * Phantom devices also trigger this
+					 * condition.  Mark hint.
+					 */
+					qc->err_mask |= AC_ERR_HSM |
+							AC_ERR_NODEV_HINT;
 
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 94faeee..76405fe 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1662,19 +1662,33 @@ static int ata_eh_revalidate_and_attach(
 			   ata_class_enabled(ehc->classes[dev->devno])) {
 			dev->class = ehc->classes[dev->devno];
 
+			if (ap->flags & ATA_FLAG_DETECT_POLLING)
+				readid_flags |= ATA_READID_DETECT;
+
 			rc = ata_dev_read_id(dev, &dev->class, readid_flags,
 					     dev->id);
 			if (rc == 0)
 				rc = ata_dev_configure(dev, 1);
+			else if (rc == -ENOENT) {
+				/* IDENTIFY was issued to non-existent
+				 * device.  No need to reset.  Just
+				 * thaw and kill the device.
+				 */
+				ata_eh_thaw_port(ap);
+				dev->class = ATA_DEV_UNKNOWN;
+				rc = 0;
+			}
 
 			if (rc) {
 				dev->class = ATA_DEV_UNKNOWN;
 				break;
 			}
 
-			spin_lock_irqsave(ap->lock, flags);
-			ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
-			spin_unlock_irqrestore(ap->lock, flags);
+			if (ata_dev_enabled(dev)) {
+				spin_lock_irqsave(ap->lock, flags);
+				ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
+				spin_unlock_irqrestore(ap->lock, flags);
+			}
 		}
 	}
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 34c4054..9d830ef 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -42,6 +42,8 @@ struct ata_scsi_args {
 enum {
 	/* flags for ata_dev_read_id() */
 	ATA_READID_POSTRESET	= (1 << 0), /* reading ID after reset */
+	ATA_READID_DETECT	= (1 << 1), /* perform presence detection
+					     * using polling IDENTIFY */
 };
 
 extern struct workqueue_struct *ata_aux_wq;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0cd6699..41180cc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -174,6 +174,8 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
+	ATA_FLAG_DETECT_POLLING	= (1 << 14), /* detect device presence by
+					      * polling IDENTIFY */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -328,6 +330,7 @@ enum ata_completion_errors {
 	AC_ERR_SYSTEM		= (1 << 6), /* system error */
 	AC_ERR_INVALID		= (1 << 7), /* invalid argument */
 	AC_ERR_OTHER		= (1 << 8), /* unknown */
+	AC_ERR_NODEV_HINT	= (1 << 9), /* polling device detection hint */
 };
 
 /* forward declarations */
-- 
1.4.2.1


