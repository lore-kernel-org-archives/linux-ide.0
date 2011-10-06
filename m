From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] libata: Allow SOFT_RESET for Sil3726
Date: Wed,  5 Oct 2011 23:03:57 -0700
Message-ID: <1317881037-11831-1-git-send-email-gwendal@google.com>
References: <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:1902 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932714Ab1JFGEQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 02:04:16 -0400
In-Reply-To: <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mihrcke@gmail.com
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

Allow controllers to send SOFT_RESET to Sil3726 PMP.
This PMP does not accept frames until the drive connected to
its port spins up.
Some controller [Sil3132 family] can not wait for the drive to spinup
and fails the reset, leading to unnecessary speed downgrade.

Not allowing to send SOFT_RESET can lead some drive slow to spinup
to be ignored and produces weird error messages.

This fix allows the error handler to wait if the controller is unable
to send a SOFT_RESET.

Change-Id: I7eeea152facb4b76e5c69cfde5ef8188874fbaba

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-eh.c  |   11 ++++++++++-
 drivers/ata/libata-pmp.c |   10 ++++------
 include/linux/libata.h   |    1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 49af350..60223c3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2805,7 +2805,14 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	    sata_scr_read(link, SCR_STATUS, &sstatus))
 		rc = -ERESTART;
 
-	if (rc == -ERESTART || try >= max_tries)
+	if (try >= max_tries)
+		goto out;
+
+	/* Some PMP will not serve SRST until the disk is spunup,
+	 * if the controller can not wait for the PMP to acknowledge the frame,
+	 * wait here */
+	if (rc == -ERESTART &&
+	    !((lflags & ATA_LFLAG_WAIT_SRST) && (reset == softreset)))
 		goto out;
 
 	now = jiffies;
@@ -2820,6 +2827,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			delta = schedule_timeout_uninterruptible(delta);
 	}
 
+	if (rc == -ERESTART)
+		goto out;
 	if (try == max_tries - 1) {
 		sata_down_spd_limit(link, 0);
 		if (slave)
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index ad0e71d..5fbbe2f 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -365,13 +365,11 @@ static void sata_pmp_quirks(struct ata_port *ap)
 	if (vendor == 0x1095 && devid == 0x3726) {
 		/* sil3726 quirks */
 		ata_for_each_link(link, ap, EDGE) {
-			/* Class code report is unreliable and SRST
-			 * times out under certain configurations.
-			 */
+			/* Class code report is unreliable */
+			/* PMP does not forward SRST until the drive spins up */
 			if (link->pmp < 5)
-				link->flags |= ATA_LFLAG_NO_SRST |
-					       ATA_LFLAG_ASSUME_ATA;
-
+				link->flags |= ATA_LFLAG_ASSUME_ATA |
+					       ATA_LFLAG_WAIT_SRST;
 			/* port 5 is for SEMB device and it doesn't like SRST */
 			if (link->pmp == 5)
 				link->flags |= ATA_LFLAG_NO_SRST |
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 14b9f50..4577ed2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -173,6 +173,7 @@ enum {
 	ATA_LFLAG_DISABLED	= (1 << 6), /* link is disabled */
 	ATA_LFLAG_SW_ACTIVITY	= (1 << 7), /* keep activity stats */
 	ATA_LFLAG_PHYOFF        = (1 << 8), /* phy is powered off */
+	ATA_LFLAG_WAIT_SRST	= (1 << 9), /* add delay when SRST fails */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
-- 
1.7.3.1

