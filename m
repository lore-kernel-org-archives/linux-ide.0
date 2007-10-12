From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 2/2] libata: track SLEEP state and issue SRST to wake it up
Date: Fri, 12 Oct 2007 20:56:57 +0900
Message-ID: <20071012115657.GB11510@htj.dyndns.org>
References: <20071012115631.GA11510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:54740 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbXJLL5E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 07:57:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so966502wah
        for <linux-ide@vger.kernel.org>; Fri, 12 Oct 2007 04:57:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071012115631.GA11510@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, ballen@gravity.phys.uwm.edu, andrew@ishiboo.com

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
 drivers/ata/libata-core.c |   12 ++++++++++++
 drivers/ata/libata-eh.c   |    4 +++-
 include/linux/ata.h       |    1 +
 include/linux/libata.h    |    1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

Index: work/include/linux/ata.h
===================================================================
--- work.orig/include/linux/ata.h
+++ work/include/linux/ata.h
@@ -179,6 +179,7 @@ enum {
 	ATA_CMD_VERIFY		= 0x40,
 	ATA_CMD_VERIFY_EXT	= 0x42,
  	ATA_CMD_STANDBYNOW1	= 0xE0,
+	ATA_CMD_SLEEP		= 0xE6,
  	ATA_CMD_IDLEIMMEDIATE	= 0xE1,
 	ATA_CMD_INIT_DEV_PARAMS	= 0x91,
 	ATA_CMD_READ_NATIVE_MAX	= 0xF8,
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -145,6 +145,7 @@ enum {
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
@@ -5553,6 +5553,10 @@ void __ata_qc_complete(struct ata_queued
 		case ATA_CMD_SET_MULTI: /* multi_count changed */
 			eh_action |= ATA_EH_REVALIDATE;
 			break;
+
+		case ATA_CMD_SLEEP:
+			qc->dev->flags |= ATA_DFLAG_SLEEPING;
+			break;
 		}
 
 		if (unlikely(eh_action) && ap->ops->error_handler) {
@@ -5757,6 +5761,14 @@ void ata_qc_issue(struct ata_queued_cmd 
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
@@ -2207,9 +2207,11 @@ int ata_eh_reset(struct ata_link *link, 
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
