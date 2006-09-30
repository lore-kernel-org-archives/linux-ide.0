From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] libata: cosmetic changes to constants
Date: Sat, 30 Sep 2006 19:44:39 +0900
Message-ID: <20060930104439.GP25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:12549 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750836AbWI3LYn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 07:24:43 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1196464wxc
        for <linux-ide@vger.kernel.org>; Sat, 30 Sep 2006 04:24:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: ric@emc.com, axboe@kernel.dk

Cosmetic changes to ATA_DFLAG_* constants for soon-to-follow NCQ-off
patch.
---
 include/linux/libata.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index df44b09..e54a5fd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -142,8 +142,8 @@ enum {
 	ATA_DFLAG_NCQ		= (1 << 3), /* device supports NCQ */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
-	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
-	ATA_DFLAG_SUSPENDED	= (1 << 9), /* device suspended */
+	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */
+	ATA_DFLAG_SUSPENDED	= (1 << 10), /* device suspended */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 16),
-- 
1.4.2.1


