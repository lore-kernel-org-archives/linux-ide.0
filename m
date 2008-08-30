From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream UPDATED 2/2] libata-eh: clear UNIT ATTENTION after
 reset
Date: Sat, 30 Aug 2008 14:20:01 +0200
Message-ID: <48B93AF1.9030401@gmail.com>
References: <484E4925.30202@gmail.com> <484E4945.3050907@gmail.com> <48648B97.8000409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:17060 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbYH3MVQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Aug 2008 08:21:16 -0400
Received: by ti-out-0910.google.com with SMTP id b6so693886tic.23
        for <linux-ide@vger.kernel.org>; Sat, 30 Aug 2008 05:21:14 -0700 (PDT)
In-Reply-To: <48648B97.8000409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

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

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Ah... It slipped through the cracks somehow.  Updated to the current
#upstream.  Thanks.

 drivers/ata/libata-eh.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 58bdc53..e02ca0d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -79,6 +79,8 @@ enum {
 	 */
 	ATA_EH_PRERESET_TIMEOUT		= 10000,
 	ATA_EH_FASTDRAIN_INTERVAL	=  3000,
+
+	ATA_EH_UA_TRIES			= 5,
 };
 
 /* The following table determines how we sequence resets.  Each entry
@@ -1357,6 +1359,37 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
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
@@ -2614,6 +2647,53 @@ int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
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
@@ -2856,6 +2936,20 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
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
