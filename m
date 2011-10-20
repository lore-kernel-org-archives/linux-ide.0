From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] [libata]Issue SRST to Sil3726 PMP
Date: Wed, 19 Oct 2011 17:02:42 -0700
Message-ID: <1319068962-18983-2-git-send-email-gwendal@google.com>
References: <4E959E1F.20001@teksavvy.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:51237 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab1JTADH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2011 20:03:07 -0400
In-Reply-To: <4E959E1F.20001@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, kernel@teksavvy.com, mihrcke@gmail.com, derry@high-rely.com
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

Reenable sending SRST to devices connected behind a Sil3726 PMP.
This allow staggered spinups and handles drives that spins up slowly.

While the drives spin up, the PMP will not accept SRST.
Most controller reissues the reset until the drive is ready, while
some [Sil3124] returns an error.
In ata_eh_error, wait 10s before reset the ATA port and try again.

---
 drivers/ata/libata-eh.c  |   12 +++++++++++-
 drivers/ata/libata-pmp.c |    7 ++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c021186..927d750 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2882,7 +2882,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	    sata_scr_read(link, SCR_STATUS, &sstatus))
 		rc = -ERESTART;
 
-	if (rc == -ERESTART || try >= max_tries) {
+	if (try >= max_tries) {
 		/*
 		 * Thaw host port even if reset failed, so that the port
 		 * can be retried on the next phy event.  This risks
@@ -2908,6 +2908,16 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		ata_eh_acquire(ap);
 	}
 
+	/*
+	 * While disks spinup behind PMP, some controllers fail sending SRST.
+	 * They need to be reset - as well as the PMP - before retrying.
+	 */
+	if (rc == -ERESTART) {
+		if (ata_is_host_link(link))
+			ata_eh_thaw_port(ap);
+		goto out;
+	}
+
 	if (try == max_tries - 1) {
 		sata_down_spd_limit(link, 0);
 		if (slave)
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 3eb2b81..183643f 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -388,12 +388,9 @@ static void sata_pmp_quirks(struct ata_port *ap)
 			/* link reports offline after LPM */
 			link->flags |= ATA_LFLAG_NO_LPM;
 
-			/* Class code report is unreliable and SRST
-			 * times out under certain configurations.
-			 */
+			/* Class code report is unreliable. */
 			if (link->pmp < 5)
-				link->flags |= ATA_LFLAG_NO_SRST |
-					       ATA_LFLAG_ASSUME_ATA;
+				link->flags |= ATA_LFLAG_ASSUME_ATA;
 
 			/* port 5 is for SEMB device and it doesn't like SRST */
 			if (link->pmp == 5)
-- 
1.7.3.1

