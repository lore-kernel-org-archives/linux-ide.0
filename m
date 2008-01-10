From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata-pmp: 4726 hates SRST
Date: Thu, 10 Jan 2008 13:38:46 +0900
Message-ID: <4785A156.30302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:12826 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbYAJEiw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 23:38:52 -0500
Received: by rv-out-0910.google.com with SMTP id k20so446636rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 20:38:51 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

4726 hates SRST even on non-config ports.  Don't use it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-pmp.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index c0c4dbc..caef2bb 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -495,14 +495,12 @@ static void sata_pmp_quirks(struct ata_port *ap)
 			/* SError.N need a kick in the ass to get working */
 			link->flags |= ATA_LFLAG_HRST_TO_RESUME;
 
-			/* class code report is unreliable */
-			if (link->pmp < 5)
-				link->flags |= ATA_LFLAG_ASSUME_ATA;
-
-			/* The config device, which can be either at
-			 * port 0 or 5, locks up on SRST.
+			/* Class code report is unreliable and SRST
+			 * times out under certain configurations.
+			 * Config device can be at port 0 or 5 and
+			 * locks up on SRST.
 			 */
-			if (link->pmp == 0 || link->pmp == 5)
+			if (link->pmp <= 5)
 				link->flags |= ATA_LFLAG_NO_SRST |
 					       ATA_LFLAG_ASSUME_ATA;
 
