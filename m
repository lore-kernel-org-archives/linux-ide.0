From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: skip FLUSH and STADNBYNOW1 during shutdown if device is already spun down
Date: Tue, 24 Apr 2007 04:12:57 +0900
Message-ID: <20070423191257.GP10619@htj.dyndns.org>
References: <20070423191202.GO10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:25280 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbXDWTNG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 15:13:06 -0400
Received: by nz-out-0506.google.com with SMTP id o1so194167nzf
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 12:13:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070423191202.GO10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, liml@rtr.ca, hancockr@shaw.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, linux-ide@vger.kernel.org, Stephen.Clark@seclark.us, fabio.comolli@gmail.com, a.p.zijlstra@chello.nl

libata didn't use to spin down disks properly on shutdown and userland
shutdown(8) worked around it by synchronizing cache and spinning down
by itself before telling the kernel to shutdown.  However, this
userland work around collides with libata shutdown because some drives
spin up if it receives FLUSH or STANDBYNOW1 while spun down.  This
results in unpleasant spin down-up-down sequence.

This patch makes libata skip FLUSH and STANDBYNOW1 during shutdown if
the drive is already spun down.  Note that whether FLUSH has been
performed is not checked.  This is because some userland shutdown(8)'s
only do STANDBYNOW1.  Transition to standby mode implies cache flush,
so this should be safe.

libata prints informational messages when skipping commands.  This is
for debugging and to urge distributions to update shutdown(8) such
that it doesn't do superflous flush and spindown.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   29 +++++++++++++++++++++++++++++
 include/linux/libata.h    |    1 +
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8f80019..2a0717c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1309,6 +1309,7 @@ nothing_to_do:
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_device *adev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
  	int need_sense = (qc->err_mask != 0);
@@ -1349,6 +1350,13 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 		}
 	}
 
+	/* Set spundown status.  Some userland tools use STANDBY
+	 * instead of STANDBYNOW1.  Take both into account.
+	 */
+	if (unlikely(qc->tf.command == ATA_CMD_STANDBY ||
+		     qc->tf.command == ATA_CMD_STANDBYNOW1))
+		adev->flags |= ATA_DFLAG_SPUNDOWN;
+
 	if (need_sense && !ap->ops->error_handler)
 		ata_dump_status(ap->print_id, &qc->result_tf);
 
@@ -1454,6 +1462,27 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	if (xlat_func(qc))
 		goto early_finish;
 
+	/* Some userland shutdown(8) spins down device to work around
+	 * previous kernel bugs.  Issuing cache flush or spin down
+	 * again might spin up some drives.  Skip cache flush and
+	 * spindown for ->shutdown if it's already spun down.
+	 */
+	switch (qc->tf.command) {
+	case ATA_CMD_FLUSH:
+	case ATA_CMD_FLUSH_EXT:
+	case ATA_CMD_STANDBYNOW1: /* ->shutdown always uses STANDBYNOW1 */
+		if (unlikely((system_state > SYSTEM_RUNNING) &&
+			     (dev->flags & ATA_DFLAG_SPUNDOWN))) {
+			ata_dev_printk(dev, KERN_INFO, "already spun down, "
+				       "skipping cmd 0x%x\n", qc->tf.command);
+			cmd->result = SAM_STAT_GOOD;
+			goto early_finish;
+		}
+		break;
+	default:
+		dev->flags &= ~ATA_DFLAG_SPUNDOWN;
+	}
+
 	/* select device, send command to hardware */
 	ata_qc_issue(qc);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6ef4055..fa551fd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -136,6 +136,7 @@ enum {
 	ATA_DFLAG_CDB_INTR	= (1 << 2), /* device asserts INTRQ when ready for CDB */
 	ATA_DFLAG_NCQ		= (1 << 3), /* device supports NCQ */
 	ATA_DFLAG_FLUSH_EXT	= (1 << 4), /* do FLUSH_EXT instead of FLUSH */
+	ATA_DFLAG_SPUNDOWN	= (1 << 5), /* device is spun down by user */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */
-- 
1.5.0.3

