From: akpm@osdl.org
Subject: [patch 05/12] libata: implement presence detection via polling IDENTIFY
Date: Fri, 20 Oct 2006 14:39:38 -0700
Message-ID: <200610202139.k9KLdcAK003574@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:32131 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992743AbWJTVkT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Oct 2006 17:40:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, htejun@gmail.com

From: Tejun Heo <htejun@gmail.com>

On some controllers (ICHs in piix mode), there is *NO* reliable way to
determine device presence other than issuing IDENTIFY and see how the
transaction proceeds by watching the TF status register.

libata acted this way before irq-pio and phantom devices caused very little
problem but now that IDENTIFY is performed using IRQ drive PIO, such phantom
devices now result in multiple 30sec timeouts during boot.

This patch implements ATA_FLAG_DETECT_POLLING.  If a LLD sets this flag,
libata core issues the initial IDENTIFY in polling mode and if the initial
data transfer fails w/ HSM violation, the port is considered to be empty thus
replicating the old libata and IDE behavior.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/libata-core.c |   19 +++++++++++++++++--
 drivers/ata/libata-eh.c   |   20 +++++++++++++++++---
 drivers/ata/libata.h      |    2 ++
 include/linux/libata.h    |    3 +++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-implement-presence-detection-via-polling-identify drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-implement-presence-detection-via-polling-identify
+++ a/drivers/ata/libata-core.c
@@ -1276,9 +1276,20 @@ int ata_dev_read_id(struct ata_device *d
 
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
@@ -4223,8 +4234,12 @@ fsm_start:
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
diff -puN drivers/ata/libata-eh.c~libata-implement-presence-detection-via-polling-identify drivers/ata/libata-eh.c
--- a/drivers/ata/libata-eh.c~libata-implement-presence-detection-via-polling-identify
+++ a/drivers/ata/libata-eh.c
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
 
diff -puN drivers/ata/libata.h~libata-implement-presence-detection-via-polling-identify drivers/ata/libata.h
--- a/drivers/ata/libata.h~libata-implement-presence-detection-via-polling-identify
+++ a/drivers/ata/libata.h
@@ -42,6 +42,8 @@ struct ata_scsi_args {
 enum {
 	/* flags for ata_dev_read_id() */
 	ATA_READID_POSTRESET	= (1 << 0), /* reading ID after reset */
+	ATA_READID_DETECT	= (1 << 1), /* perform presence detection
+					     * using polling IDENTIFY */
 };
 
 extern struct workqueue_struct *ata_aux_wq;
diff -puN include/linux/libata.h~libata-implement-presence-detection-via-polling-identify include/linux/libata.h
--- a/include/linux/libata.h~libata-implement-presence-detection-via-polling-identify
+++ a/include/linux/libata.h
@@ -176,6 +176,8 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
+	ATA_FLAG_DETECT_POLLING	= (1 << 14), /* detect device presence by
+					      * polling IDENTIFY */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -330,6 +332,7 @@ enum ata_completion_errors {
 	AC_ERR_SYSTEM		= (1 << 6), /* system error */
 	AC_ERR_INVALID		= (1 << 7), /* invalid argument */
 	AC_ERR_OTHER		= (1 << 8), /* unknown */
+	AC_ERR_NODEV_HINT	= (1 << 9), /* polling device detection hint */
 };
 
 /* forward declarations */
_
