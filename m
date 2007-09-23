From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] libata-pmp-prep: implement ATA_LFLAG_NO_SRST, ASSUME_ATA and ASSUME_SEMB
Date: Sun, 23 Sep 2007 13:14:12 +0900
Message-ID: <11905208522729-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:50630 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbXIWEOZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1140954rvb
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:25 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Some links on some PMPs locks up on SRST and/or report incorrect
device signature.  Implement ATA_LFLAG_NO_SRST, ASSUME_ATA and
ASSUME_SEMB to handle these quirky links.  NO_SRST makes EH avoid
SRST.  ASSUME_ATA and SEMB forces class code to ATA and SEMB_UNSUP
respectively.  Note that SEMB isn't currently supported yet so the
_UNSUP variant is used.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   42 ++++++++++++++++++++++++++++++++----------
 include/linux/libata.h  |    4 ++++
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5244723..7be04bd 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1906,14 +1906,18 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 	return 0;
 }
 
-static int ata_eh_followup_srst_needed(int rc, int classify,
+static int ata_eh_followup_srst_needed(struct ata_link *link,
+				       int rc, int classify,
 				       const unsigned int *classes)
 {
+	if (link->flags & ATA_LFLAG_NO_SRST)
+		return 0;
 	if (rc == -EAGAIN)
 		return 1;
 	if (rc != 0)
 		return 0;
-	if (classify && classes[0] == ATA_DEV_UNKNOWN)
+	if (classify && !(link->flags & ATA_LFLAG_ASSUME_CLASS) &&
+	    classes[0] == ATA_DEV_UNKNOWN)
 		return 1;
 	return 0;
 }
@@ -1940,7 +1944,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	 */
 	action = ehc->i.action;
 	ehc->i.action &= ~ATA_EH_RESET_MASK;
-	if (softreset && (!hardreset || (!sata_set_spd_needed(link) &&
+	if (softreset && (!hardreset || (!(link->flags & ATA_LFLAG_NO_SRST) &&
+					 !sata_set_spd_needed(link) &&
 					 !(action & ATA_EH_HARDRESET))))
 		ehc->i.action |= ATA_EH_SOFTRESET;
 	else
@@ -2003,7 +2008,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	rc = ata_do_reset(link, reset, classes, deadline);
 
 	if (reset == hardreset &&
-	    ata_eh_followup_srst_needed(rc, classify, classes)) {
+	    ata_eh_followup_srst_needed(link, rc, classify, classes)) {
 		/* okay, let's do follow-up softreset */
 		reset = softreset;
 
@@ -2018,8 +2023,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
 		rc = ata_do_reset(link, reset, classes, deadline);
 
-		if (rc == 0 && classify &&
-		    classes[0] == ATA_DEV_UNKNOWN) {
+		if (rc == 0 && classify && classes[0] == ATA_DEV_UNKNOWN &&
+		    !(link->flags & ATA_LFLAG_ASSUME_CLASS)) {
 			ata_link_printk(link, KERN_ERR,
 					"classification failed\n");
 			rc = -EINVAL;
@@ -2027,6 +2032,10 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		}
 	}
 
+	/* if we skipped follow-up srst, clear rc */
+	if (rc == -EAGAIN)
+		rc = 0;
+
 	if (rc && try < ARRAY_SIZE(ata_eh_reset_timeouts)) {
 		unsigned long now = jiffies;
 
@@ -2051,12 +2060,25 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	if (rc == 0) {
 		u32 sstatus;
 
-		/* After the reset, the device state is PIO 0 and the
-		 * controller state is undefined.  Record the mode.
-		 */
-		ata_link_for_each_dev(dev, link)
+		ata_link_for_each_dev(dev, link) {
+			/* After the reset, the device state is PIO 0
+			 * and the controller state is undefined.
+			 * Record the mode.
+			 */
 			dev->pio_mode = XFER_PIO_0;
 
+			if (ata_link_offline(link))
+				continue;
+
+			/* apply class override and convert UNKNOWN to NONE */
+			if (link->flags & ATA_LFLAG_ASSUME_ATA)
+				classes[dev->devno] = ATA_DEV_ATA;
+			else if (link->flags & ATA_LFLAG_ASSUME_SEMB)
+				classes[dev->devno] = ATA_DEV_SEMB_UNSUP; /* not yet */
+			else if (classes[dev->devno] == ATA_DEV_UNKNOWN)
+				classes[dev->devno] = ATA_DEV_NONE;
+		}
+
 		/* record current link speed */
 		if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0)
 			link->sata_spd = (sstatus >> 4) & 0xf;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f9f81fd..6266fff 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -165,6 +165,10 @@ enum {
 	ATA_LFLAG_HRST_TO_RESUME = (1 << 0), /* hardreset to resume link */
 	ATA_LFLAG_SKIP_D2H_BSY	= (1 << 1), /* can't wait for the first D2H
 					     * Register FIS clearing BSY */
+	ATA_LFLAG_NO_SRST	= (1 << 2), /* avoid softreset */
+	ATA_LFLAG_ASSUME_ATA	= (1 << 3), /* assume ATA class */
+	ATA_LFLAG_ASSUME_SEMB	= (1 << 4), /* assume SEMB class */
+	ATA_LFLAG_ASSUME_CLASS	= ATA_LFLAG_ASSUME_ATA | ATA_LFLAG_ASSUME_SEMB,
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
-- 
1.5.0.3


