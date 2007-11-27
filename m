From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/8] libata: rearrange ATA_DFLAG_*
Date: Tue, 27 Nov 2007 19:28:52 +0900
Message-ID: <11961593391512-git-send-email-htejun@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:11782 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbXK0K3Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:29:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1179628wah
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:29:16 -0800 (PST)
In-Reply-To: <11961593392491-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, Tejun Heo <htejun@gmail.com>

Area for DFLAGs which are cleared on INIT is full.  Extend it by 8
bits.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index ef52a07..9cd06dd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -141,10 +141,10 @@ enum {
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

