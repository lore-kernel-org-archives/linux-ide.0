From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: retry link resume if necessary
Date: Mon, 11 Jan 2010 11:14:44 +0900
Message-ID: <4B4A8994.8030600@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43643 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab0AKCPD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Jan 2010 21:15:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, fengxiangjun <fengxiangjun@neusoft.com>, Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: Greg KH <greg@kroah.com>

Interestingly, when SIDPR is used in ata_piix, writes to DET in
SControl sometimes get ignored leading to detection failure.  Update
sata_link_resume() such that it reads back SControl after clearing DET
and retry if it's not clear.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: fengxiangjun <fengxiangjun@neusoft.com>
Reported-by: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: stable@kernel.org
---
Greg, although this patch should be included in -stable release in
time, I think it should receive some more testing in devel branch for
at least a couple of -rc cycles as it changes very fundamental part of
hardreset protocol.  Is there a protocol for delayed inclusion into
-stable?  If not, I'll try to remember and ping you back after some
time but I'm almost sure that I'm gonna forget this.  :-)

Thanks.

 drivers/ata/libata-core.c |   38 +++++++++++++++++++++++++++++++-------
 include/linux/libata.h    |    3 +++
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 22ff51b..6728328 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3790,21 +3790,45 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		     unsigned long deadline)
 {
+	int tries = ATA_LINK_RESUME_TRIES;
 	u32 scontrol, serror;
 	int rc;
 
 	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
 		return rc;
 
-	scontrol = (scontrol & 0x0f0) | 0x300;
+	/*
+	 * Writes to SControl sometimes get ignored under certain
+	 * controllers (ata_piix SIDPR).  Make sure DET actually is
+	 * cleared.
+	 */
+	do {
+		scontrol = (scontrol & 0x0f0) | 0x300;
+		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
+			return rc;
+		/*
+		 * Some PHYs react badly if SStatus is pounded
+		 * immediately after resuming.  Delay 200ms before
+		 * debouncing.
+		 */
+		msleep(200);
 
-	if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
-		return rc;
+		/* is SControl restored correctly? */
+		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
+			return rc;
+	} while ((scontrol & 0xf0f) != 0x300 && --tries);
 
-	/* Some PHYs react badly if SStatus is pounded immediately
-	 * after resuming.  Delay 200ms before debouncing.
-	 */
-	msleep(200);
+	if ((scontrol & 0xf0f) != 0x300) {
+		ata_link_printk(link, KERN_ERR,
+				"failed to resume link (SControl %X)\n",
+				scontrol);
+		return 0;
+	}
+
+	if (tries < ATA_LINK_RESUME_TRIES)
+		ata_link_printk(link, KERN_WARNING,
+				"link resume succeeded after %d retries\n",
+				ATA_LINK_RESUME_TRIES - tries);
 
 	if ((rc = sata_link_debounce(link, params, deadline)))
 		return rc;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6a9c4dd..7311225 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -354,6 +354,9 @@ enum {
 	/* max tries if error condition is still set after ->error_handler */
 	ATA_EH_MAX_TRIES	= 5,
 
+	/* sometimes resuming a link requires several retries */
+	ATA_LINK_RESUME_TRIES	= 5,
+
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
 	ATA_EH_DEV_TRIES	= 3,
