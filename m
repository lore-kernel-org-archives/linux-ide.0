From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] libata-pmp-prep: implement ATA_LFLAG_NO_SRST, ASSUME_ATA and ASSUME_SEMB
Date: Sun, 1 Jul 2007 19:26:08 +0900
Message-ID: <11832855682853-git-send-email-htejun@gmail.com>
References: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:25349 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843AbXGAK0P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:15 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1884678wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:15 -0700 (PDT)
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
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
index 3779067..5d06509 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1768,14 +1768,18 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
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
@@ -1802,7 +1806,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	 */
 	action = ehc->i.action;
 	ehc->i.action &= ~ATA_EH_RESET_MASK;
-	if (softreset && (!hardreset || (!sata_set_spd_needed(link) &&
+	if (softreset && (!hardreset || (!(link->flags & ATA_LFLAG_NO_SRST) &&
+					 !sata_set_spd_needed(link) &&
 					 !(action & ATA_EH_HARDRESET))))
 		ehc->i.action |= ATA_EH_SOFTRESET;
 	else
@@ -1865,7 +1870,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	rc = ata_do_reset(link, reset, classes, deadline);
 
 	if (reset == hardreset &&
-	    ata_eh_followup_srst_needed(rc, classify, classes)) {
+	    ata_eh_followup_srst_needed(link, rc, classify, classes)) {
 		/* okay, let's do follow-up softreset */
 		reset = softreset;
 
@@ -1880,8 +1885,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
 		rc = ata_do_reset(link, reset, classes, deadline);
 
-		if (rc == 0 && classify &&
-		    classes[0] == ATA_DEV_UNKNOWN) {
+		if (rc == 0 && classify && classes[0] == ATA_DEV_UNKNOWN &&
+		    !(link->flags & ATA_LFLAG_ASSUME_CLASS)) {
 			ata_link_printk(link, KERN_ERR,
 					"classification failed\n");
 			rc = -EINVAL;
@@ -1889,6 +1894,10 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		}
 	}
 
+	/* if we skipped follow-up srst, clear rc */
+	if (rc == -EAGAIN)
+		rc = 0;
+
 	if (rc && try < ARRAY_SIZE(ata_eh_reset_timeouts)) {
 		unsigned long now = jiffies;
 
@@ -1913,12 +1922,25 @@ int ata_eh_reset(struct ata_link *link, int classify,
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
index 349180a..57da3ba 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -163,6 +163,10 @@ enum {
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


