From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/8] libata: adjust speed down rules
Date: Tue, 27 Nov 2007 19:28:57 +0900
Message-ID: <11961593403415-git-send-email-htejun@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:12188 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbXK0K3U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:29:20 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1179675wah
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:29:19 -0800 (PST)
In-Reply-To: <11961593392491-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, Tejun Heo <htejun@gmail.com>

Speed down rules were too conservative.  Adjust them a bit.

* More than 10 timeouts can't happen in 5 minutes as command timeout
  is 30secs.  Lower the limit for rule #1 to 6.

* 10 timeouts is too high for rule #3 too.  Lower it to 6.

* SATAPI can benefit from falling back to PIO too.  Allow SATAPI
  devices to fall back to PIO.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1245b96..e479df2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1525,13 +1525,13 @@ static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
  *	Even if multiple verdicts are returned, only one action is
  *	taken per error.  ering is cleared after an action is taken.
  *
- *	1. If more than 10 ATA_BUS, TOUT_HSM or UNK_DEV errors
+ *	1. If more than 6 ATA_BUS, TOUT_HSM or UNK_DEV errors
  *	   ocurred during last 5 mins, FALLBACK_TO_PIO
  *
  *	2. If more than 3 TOUT_HSM or UNK_DEV errors occurred
  *	   during last 10 mins, NCQ_OFF.
  *
- *	3. If more than 3 ATA_BUS or TOUT_HSM errors, or more than 10
+ *	3. If more than 3 ATA_BUS or TOUT_HSM errors, or more than 6
  *	   UNK_DEV errors occurred during last 10 mins, SPEED_DOWN.
  *
  *	LOCKING:
@@ -1554,7 +1554,7 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
 
 	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
 	    arg.nr_errors[ATA_ECAT_TOUT_HSM] +
-	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 10)
+	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 6)
 		verdict |= ATA_EH_SPDN_FALLBACK_TO_PIO;
 
 	/* scan past 10 mins of error history */
@@ -1568,7 +1568,7 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
 
 	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
 	    arg.nr_errors[ATA_ECAT_TOUT_HSM] > 3 ||
-	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 10)
+	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 6)
 		verdict |= ATA_EH_SPDN_SPEED_DOWN;
 
 	return verdict;
@@ -1647,10 +1647,10 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
 	}
 
 	/* Fall back to PIO?  Slowing down to PIO is meaningless for
-	 * SATA.  Consider it only for PATA.
+	 * SATA ATA devices.  Consider it only for PATA and SATAPI.
 	 */
 	if ((verdict & ATA_EH_SPDN_FALLBACK_TO_PIO) && (dev->spdn_cnt >= 2) &&
-	    (link->ap->cbl != ATA_CBL_SATA) &&
+	    (link->ap->cbl != ATA_CBL_SATA || dev->class == ATA_DEV_ATAPI) &&
 	    (dev->xfer_shift != ATA_SHIFT_PIO)) {
 		if (ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO) == 0) {
 			dev->spdn_cnt = 0;
-- 
1.5.2.4

