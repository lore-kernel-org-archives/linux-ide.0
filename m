From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: hardreset on SERR_INTERNAL
Date: Wed, 14 Mar 2007 01:20:51 +0900
Message-ID: <20070313162051.GH32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:3379 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030763AbXCMQVB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 12:21:01 -0400
Received: by ug-out-1314.google.com with SMTP id 44so337021uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 09:20:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

There was a rare report where SB600 reported SERR_INTERNAL and SRST
couldn't get it out of the failure mode.  Hardreset on SERR_INTERNAL.
As the problem is intermittent, whether this fixes the problem or not
hasn't been verified yet, but hardresetting the channel on internal
error is a good idea anyway.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7349c3d..fc11bb3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1055,7 +1055,7 @@ static void ata_eh_analyze_serror(struct ata_port *ap)
 	}
 	if (serror & SERR_INTERNAL) {
 		err_mask |= AC_ERR_SYSTEM;
-		action |= ATA_EH_SOFTRESET;
+		action |= ATA_EH_HARDRESET;
 	}
 	if (serror & (SERR_PHYRDY_CHG | SERR_DEV_XCHG))
 		ata_ehi_hotplugged(&ehc->i);
