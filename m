From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/8] libata: rearrange ATA_DFLAG_*
Date: Fri,  2 Nov 2007 00:51:37 +0900
Message-ID: <11939323041557-git-send-email-htejun@gmail.com>
References: <11939323042554-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:20821 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754039AbXKAPvr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 11:51:47 -0400
In-Reply-To: <11939323042554-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Area for DFLAGs which are cleared on INIT is full.  Extend it by 8
bits.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 439d40f..e62cdf0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -139,10 +139,10 @@ enum {
 	ATA_DFLAG_NCQ_OFF	= (1 << 13), /* device limited to non-NCQ mode */
 	ATA_DFLAG_SPUNDOWN	= (1 << 14), /* XXX: for spindown_compat */
 	ATA_DFLAG_SLEEPING	= (1 << 15), /* device is sleeping */
-	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
+	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,
 
-	ATA_DFLAG_DETACH	= (1 << 16),
-	ATA_DFLAG_DETACHED	= (1 << 17),
+	ATA_DFLAG_DETACH	= (1 << 24),
+	ATA_DFLAG_DETACHED	= (1 << 25),
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
-- 
1.5.2.4

