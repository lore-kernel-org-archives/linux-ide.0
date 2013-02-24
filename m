From: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH] sata_fsl: Remove redundant NULL check before kfree
Date: Mon, 25 Feb 2013 04:44:07 +0530
Message-ID: <1361747647-29539-1-git-send-email-s.syam@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:57478 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3BXXOR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2013 18:14:17 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1176984dak.34
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2013 15:14:17 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: syamsidhardh@gmail.com, jgarzik@pobox.com

kfree on NULL pointer is a no-op.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 drivers/ata/sata_fsl.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 124b2c1..608f82f 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1511,8 +1511,7 @@ error_exit_with_cleanup:
 
 	if (hcr_base)
 		iounmap(hcr_base);
-	if (host_priv)
-		kfree(host_priv);
+	kfree(host_priv);
 
 	return retval;
 }
-- 
1.7.9.5

