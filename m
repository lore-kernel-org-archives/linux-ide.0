From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream] libata: track SLEEP state and issue SRST to wake
	it up
Date: Thu, 25 Oct 2007 18:30:36 +0900
Message-ID: <20071025093036.GK11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:53025 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbXJYJaq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 05:30:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so556224wah
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 02:30:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, andrew.m.paprocki@gmail.com, ballen@gravity.phys.uwm.edu

ATA devices in SLEEP mode don't respond to any commands.  SRST is
necessary to wake it up.  Till now, when a command is issued to a
device in SLEEP mode, the command times out, which makes EH reset the
device and retry the command after that, causing a long delay.

This patch makes libata track SLEEP state and issue SRST automatically
if a command is about to be issued to a device in SLEEP.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Andrew Paprocki <andrew@ishiboo.com>
---
This patch is against

 #upstream
 + relocate-and-fix-post-command-processing patch
   (http://article.gmane.org/gmane.linux.ide/24001)

The infinite loop with the previous patch wasn't caused by bug in
sleep state tracking.  It was happening because post-command
processing was being performed for commands which are being retried
from EH, so what happened was.

1. device is flagged SLEEPING

2. SLEEP is issued, as device is sleeping, EH is rescheduled against
   the qc for SLEEP.

3. EH kicks in and wakes up the device and clears SLEEPING.

4. EH finishes up failed qc which triggers post-command processing and
   sets SLEEPING.

5. SCSI command is retried, go back to #2.

relocate-and-fix-post-command-processing patch fixes the original bug
in post-command processing and this patch doesn't cause infinite loop
anymore.

 drivers/ata/libata-core.c |   12 ++++++++++++
 drivers/ata/libata-eh.c   |    4 +++-
 include/linux/ata.h       |    1 +
 include/linux/libata.h    |    1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

Index: work/include/linux/ata.h
===================================================================
--- work.orig/include/linux/ata.h
+++ work/include/linux/ata.h
@@ -180,6 +180,7 @@ enum {
 	ATA_CMD_VERIFY_EXT	= 0x42,
 	ATA_CMD_STANDBYNOW1	= 0xE0,
 	ATA_CMD_IDLEIMMEDIATE	= 0xE1,
+	ATA_CMD_SLEEP		= 0xE6,
 	ATA_CMD_INIT_DEV_PARAMS	= 0x91,
 	ATA_CMD_READ_NATIVE_MAX	= 0xF8,
 	ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -138,6 +138,7 @@ enum {
 	ATA_DFLAG_PIO		= (1 << 12), /* device limited to PIO mode */
 	ATA_DFLAG_NCQ_OFF	= (1 << 13), /* device limited to non-NCQ mode */
 	ATA_DFLAG_SPUNDOWN	= (1 << 14), /* XXX: for spindown_compat */
+	ATA_DFLAG_SLEEPING	= (1 << 15), /* device is sleeping */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 16),
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -5630,6 +5630,10 @@ void ata_qc_complete(struct ata_queued_c
 			ehi->dev_action[dev->devno] |= ATA_EH_REVALIDATE;
 			ata_port_schedule_eh(ap);
 			break;
+
+		case ATA_CMD_SLEEP:
+			dev->flags |= ATA_DFLAG_SLEEPING;
+			break;
 		}
 
 		__ata_qc_complete(qc);
@@ -5769,6 +5773,14 @@ void ata_qc_issue(struct ata_queued_cmd 
 		qc->flags &= ~ATA_QCFLAG_DMAMAP;
 	}
 
+	/* if device is sleeping, schedule softreset and abort the link */
+	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
+		link->eh_info.action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
+		ata_link_abort(link);
+		return;
+	}
+
 	ap->ops->qc_prep(qc);
 
 	qc->err_mask |= ap->ops->qc_issue(qc);
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2208,9 +2208,11 @@ int ata_eh_reset(struct ata_link *link, 
 		ata_link_for_each_dev(dev, link) {
 			/* After the reset, the device state is PIO 0
 			 * and the controller state is undefined.
-			 * Record the mode.
+			 * Reset also wakes up drives from sleeping
+			 * mode.
 			 */
 			dev->pio_mode = XFER_PIO_0;
+			dev->flags &= ~ATA_DFLAG_SLEEPING;
 
 			if (ata_link_offline(link))
 				continue;
