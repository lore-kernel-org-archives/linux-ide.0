From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-3.10-fixes] libata: skip SRST for all SIMG [34]7x
 port-multipliers
Date: Tue, 11 Jun 2013 00:11:36 -0700
Message-ID: <20130611071136.GD22530@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:38954 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab3FKHLj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jun 2013 03:11:39 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so8155526pbc.11
        for <linux-ide@vger.kernel.org>; Tue, 11 Jun 2013 00:11:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>

For some reason, a lot of port-multipliers have issues with softreset.
SIMG [34]7x series port-multipliers have been quite erratic in this
regard.  I recall that it was better with some firmware revisions and
the current list of quirks worked fine for a while.  I think it got
worse with later firmwares or maybe my test coverage wasn't good
enough.  Anyways, HPA is reporting that his 3726 setup suffers SRST
failures and then the PMP gets confused and fails to probe the last
port.

The hope was that we try to stick to the standard as much as possible
and soonish the PMPs and their firmwares will improve in quality, so
the quirk list was kept to minimum.  Well, it seems like that's never
gonna happen.

Let's set NO_SRST for all [34]7x PMPs so that whatever remaining
userbase of the device suffer the least.  Maybe we should do the same
for 57xx's but unfortunately I don't have any device left to test and
I'm not even sure 57xx's have ever been made widely available, so
let's leave those alone for now.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: "H. Peter Anvin" <hpa@zytor.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-pmp.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 61c59ee..1c41722 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -389,9 +389,13 @@ static void sata_pmp_quirks(struct ata_port *ap)
 			/* link reports offline after LPM */
 			link->flags |= ATA_LFLAG_NO_LPM;
 
-			/* Class code report is unreliable. */
+			/*
+			 * Class code report is unreliable and SRST times
+			 * out under certain configurations.
+			 */
 			if (link->pmp < 5)
-				link->flags |= ATA_LFLAG_ASSUME_ATA;
+				link->flags |= ATA_LFLAG_NO_SRST |
+					       ATA_LFLAG_ASSUME_ATA;
 
 			/* port 5 is for SEMB device and it doesn't like SRST */
 			if (link->pmp == 5)
@@ -399,20 +403,17 @@ static void sata_pmp_quirks(struct ata_port *ap)
 					       ATA_LFLAG_ASSUME_SEMB;
 		}
 	} else if (vendor == 0x1095 && devid == 0x4723) {
-		/* sil4723 quirks */
-		ata_for_each_link(link, ap, EDGE) {
-			/* link reports offline after LPM */
-			link->flags |= ATA_LFLAG_NO_LPM;
-
-			/* class code report is unreliable */
-			if (link->pmp < 2)
-				link->flags |= ATA_LFLAG_ASSUME_ATA;
-
-			/* the config device at port 2 locks up on SRST */
-			if (link->pmp == 2)
-				link->flags |= ATA_LFLAG_NO_SRST |
-					       ATA_LFLAG_ASSUME_ATA;
-		}
+		/*
+		 * sil4723 quirks
+		 *
+		 * Link reports offline after LPM.  Class code report is
+		 * unreliable.  SIMG PMPs never got SRST reliable and the
+		 * config device at port 2 locks up on SRST.
+		 */
+		ata_for_each_link(link, ap, EDGE)
+			link->flags |= ATA_LFLAG_NO_LPM |
+				       ATA_LFLAG_NO_SRST |
+				       ATA_LFLAG_ASSUME_ATA;
 	} else if (vendor == 0x1095 && devid == 0x4726) {
 		/* sil4726 quirks */
 		ata_for_each_link(link, ap, EDGE) {
