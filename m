From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ide: fix drive side 80c cable check
Date: Mon, 5 Feb 2007 16:47:13 +0900
Message-ID: <20070205074713.GF1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:34200 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbXBEHrS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 02:47:18 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1537522nze
        for <linux-ide@vger.kernel.org>; Sun, 04 Feb 2007 23:47:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stable@kernel.org

The 80c wire bit is bit 13, not 14.  This increases the chance of
incorrect wire detection especially because host side cable detection
is often unreliable and we sometimes soley depend on drive side cable
detection.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Please consider for -stable.

 drivers/ide/ide-iops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ide/ide-iops.c
===================================================================
--- work.orig/drivers/ide/ide-iops.c
+++ work/drivers/ide/ide-iops.c
@@ -604,7 +604,7 @@ u8 eighty_ninty_three (ide_drive_t *driv
 	if (!(drive->id->hw_config & 0x6000))
 		return 0;
 #ifndef CONFIG_IDEDMA_IVB
-	if(!(drive->id->hw_config & 0x4000))
+	if (!(drive->id->hw_config & 0x2000))
 		return 0;
 #endif /* CONFIG_IDEDMA_IVB */
 	return 1;
