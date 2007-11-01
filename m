From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/8] libata: adjust speed down rules
Date: Fri,  2 Nov 2007 00:51:42 +0900
Message-ID: <11939323064029-git-send-email-htejun@gmail.com>
References: <11939323042554-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:20827 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754415AbXKAPvs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 11:51:48 -0400
In-Reply-To: <11939323042554-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

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
index d0c8d77..b5c5388 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1620,13 +1620,13 @@ static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
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
@@ -1649,7 +1649,7 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
 
 	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
 	    arg.nr_errors[ATA_ECAT_TOUT_HSM] +
-	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 10)
+	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 6)
 		verdict |= ATA_EH_SPDN_FALLBACK_TO_PIO;
 
 	/* scan past 10 mins of error history */
@@ -1663,7 +1663,7 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
 
 	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
 	    arg.nr_errors[ATA_ECAT_TOUT_HSM] > 3 ||
-	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 10)
+	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 6)
 		verdict |= ATA_EH_SPDN_SPEED_DOWN;
 
 	return verdict;
@@ -1742,10 +1742,10 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
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

