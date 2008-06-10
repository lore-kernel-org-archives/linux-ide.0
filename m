From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 2/2] libata-eh: clear UNIT ATTENTION after reset
Date: Tue, 10 Jun 2008 18:28:37 +0900
Message-ID: <484E4945.3050907@gmail.com>
References: <484E4925.30202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:48648 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbYFJJ2n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 05:28:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so793918rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 02:28:43 -0700 (PDT)
In-Reply-To: <484E4925.30202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Resets make ATAPI devices raise UNIT ATTENTION which fails the next
command.  As resets can happen asynchronously for unrelated reasons,
this sometimes disrupts innocent users.  For example, reading DVD
fails after the system wakes up from suspend or the other device
sharing the channel went through bus error.

Clearing UA has some problems as it might clear UA which the userland
needs to know about.  However, UA after resets can only be about the
reset itself and benefits of clearing it overweights cons.  Missing UA
can only delay failure to one of the following commands anyway.  For
example, timeout while burning is in progress will trigger reset and
reset the device state and probably corrupt the burning run.  Although
the userland application won't get the UA, its pending writes will
fail.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |  105 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 99 insertions(+), 6 deletions(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -66,15 +66,16 @@ enum {
 	ATA_ECAT_DUBIOUS_TOUT_HSM	= 6,
 	ATA_ECAT_DUBIOUS_UNK_DEV	= 7,
 	ATA_ECAT_NR			= 8,
-};
 
-/* Waiting in ->prereset can never be reliable.  It's sometimes nice
- * to wait there but it can't be depended upon; otherwise, we wouldn't
- * be resetting.  Just give it enough time for most drives to spin up.
- */
-enum {
+	/* Waiting in ->prereset can never be reliable.  It's
+	 * sometimes nice to wait there but it can't be depended upon;
+	 * otherwise, we wouldn't be resetting.  Just give it enough
+	 * time for most drives to spin up.
+	 */
 	ATA_EH_PRERESET_TIMEOUT		= 10 * HZ,
 	ATA_EH_FASTDRAIN_INTERVAL	= 3 * HZ,
+
+	ATA_EH_UA_TRIES			= 5,
 };
 
 /* The following table determines how we sequence resets.  Each entry
@@ -1235,6 +1236,37 @@ static int ata_eh_read_log_10h(struct at
 }
 
 /**
+ *	atapi_eh_tur - perform ATAPI TEST_UNIT_READY
+ *	@dev: target ATAPI device
+ *	@r_sense_key: out parameter for sense_key
+ *
+ *	Perform ATAPI TEST_UNIT_READY.
+ *
+ *	LOCKING:
+ *	EH context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask on failure.
+ */
+static unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
+{
+	u8 cdb[ATAPI_CDB_LEN] = { TEST_UNIT_READY, 0, 0, 0, 0, 0 };
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	ata_tf_init(dev, &tf);
+
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.command = ATA_CMD_PACKET;
+	tf.protocol = ATAPI_PROT_NODATA;
+
+	err_mask = ata_exec_internal(dev, &tf, cdb, DMA_NONE, NULL, 0, 0);
+	if (err_mask == AC_ERR_DEV)
+		*r_sense_key = tf.feature >> 4;
+	return err_mask;
+}
+
+/**
  *	atapi_eh_request_sense - perform ATAPI REQUEST_SENSE
  *	@dev: device to perform REQUEST_SENSE to
  *	@sense_buf: result sense data buffer (SCSI_SENSE_BUFFERSIZE bytes long)
@@ -2445,6 +2477,53 @@ int ata_set_mode(struct ata_link *link, 
 	return rc;
 }
 
+/**
+ *	atapi_eh_clear_ua - Clear ATAPI UNIT ATTENTION after reset
+ *	@dev: ATAPI device to clear UA for
+ *
+ *	Resets and other operations can make an ATAPI device raise
+ *	UNIT ATTENTION which causes the next operation to fail.  This
+ *	function clears UA.
+ *
+ *	LOCKING:
+ *	EH context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+static int atapi_eh_clear_ua(struct ata_device *dev)
+{
+	int i;
+
+	for (i = 0; i < ATA_EH_UA_TRIES; i++) {
+		u8 sense_buffer[SCSI_SENSE_BUFFERSIZE];
+		u8 sense_key = 0;
+		unsigned int err_mask;
+
+		err_mask = atapi_eh_tur(dev, &sense_key);
+		if (err_mask != 0 && err_mask != AC_ERR_DEV) {
+			ata_dev_printk(dev, KERN_WARNING, "TEST_UNIT_READY "
+				"failed (err_mask=0x%x)\n", err_mask);
+			return -EIO;
+		}
+
+		if (!err_mask || sense_key != UNIT_ATTENTION)
+			return 0;
+
+		err_mask = atapi_eh_request_sense(dev, sense_buffer, sense_key);
+		if (err_mask) {
+			ata_dev_printk(dev, KERN_WARNING, "failed to clear "
+				"UNIT ATTENTION (err_mask=0x%x)\n", err_mask);
+			return -EIO;
+		}
+	}
+
+	ata_dev_printk(dev, KERN_WARNING,
+		"UNIT ATTENTION persists after %d tries\n", ATA_EH_UA_TRIES);
+
+	return 0;
+}
+
 static int ata_link_nr_enabled(struct ata_link *link)
 {
 	struct ata_device *dev;
@@ -2702,6 +2781,20 @@ int ata_eh_recover(struct ata_port *ap, 
 			ehc->i.flags &= ~ATA_EHI_SETMODE;
 		}
 
+		/* If reset has been issued, clear UA to avoid
+		 * disrupting the current users of the device.
+		 */
+		if (ehc->i.flags & ATA_EHI_DID_RESET) {
+			ata_link_for_each_dev(dev, link) {
+				if (dev->class != ATA_DEV_ATAPI)
+					continue;
+				rc = atapi_eh_clear_ua(dev);
+				if (rc)
+					goto dev_fail;
+			}
+		}
+
+		/* configure link power saving */
 		if (ehc->i.action & ATA_EH_LPM)
 			ata_link_for_each_dev(dev, link)
 				ata_dev_enable_pm(dev, ap->pm_policy);
