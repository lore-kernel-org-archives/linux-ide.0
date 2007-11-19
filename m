From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pata_jmicron: fix disabled port handling in
	jmicron_pre_reset()
Date: Mon, 19 Nov 2007 18:06:11 +0900
Message-ID: <20071119090611.GE30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:49483 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbXKSJGS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 04:06:18 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1365322rvb
        for <linux-ide@vger.kernel.org>; Mon, 19 Nov 2007 01:06:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

There are two bugs in disabled port handling.

* test in PORT_PATA0 is reversed
* ->prereset should return -ENOENT for disabled ports not 0

The first bug makes the PATA channel considered disabled but the
second bug saves the day by returning 0.  The net result is that cable
is always left at ATA_CBL_UNKNOWN.  This results in false 80c
configuration and thus transfer errors.

This patch fixes both bugs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
applied to #tj-upstream-fixes.

 drivers/ata/pata_jmicron.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 225a722..5b8174d 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -80,11 +80,10 @@ static int jmicron_pre_reset(struct ata_link *link, unsigned long deadline)
 	 *	actually do our cable checking etc. Thankfully we don't need
 	 *	to do the plumbing for other cases.
 	 */
-	switch (port_map[port])
-	{
+	switch (port_map[port]) {
 	case PORT_PATA0:
-		if (control & (1 << 5))
-			return 0;
+		if ((control & (1 << 5)) == 0)
+			return -ENOENT;
 		if (control & (1 << 3))	/* 40/80 pin primary */
 			ap->cbl = ATA_CBL_PATA40;
 		else
@@ -93,7 +92,7 @@ static int jmicron_pre_reset(struct ata_link *link, unsigned long deadline)
 	case PORT_PATA1:
 		/* Bit 21 is set if the port is enabled */
 		if ((control5 & (1 << 21)) == 0)
-			return 0;
+			return -ENOENT;
 		if (control5 & (1 << 19))	/* 40/80 pin secondary */
 			ap->cbl = ATA_CBL_PATA40;
 		else
-- 
1.5.2.4

