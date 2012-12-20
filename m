From: Dirk Behme <dirk.behme@gmail.com>
Subject: [PATCH] libata-core: disable uninitialized var warning
Date: Thu, 20 Dec 2012 15:10:38 +0100
Message-ID: <1356012638-4942-1-git-send-email-dirk.behme@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:36944 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2LTOSl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Dec 2012 09:18:41 -0500
Received: by mail-bk0-f50.google.com with SMTP id jf3so1711085bkc.37
        for <linux-ide@vger.kernel.org>; Thu, 20 Dec 2012 06:18:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Dirk Behme <dirk.behme@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

Make GCC happy by disabling the warning

drivers/ata/libata-core.c: In function 'ata_hpa_resize':
drivers/ata/libata-core.c:1394:3: warning: 'native_sectors' may be used uninitialized in this function [-Wmaybe-uninitialized]

Looking on the code, 'native_sectors' is always initialized by calling
ata_read_native_max_address(dev, &native_sectors).

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
CC: Jeff Garzik <jgarzik@pobox.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9e8b99a..21623cf 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1324,7 +1324,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
 	bool unlock_hpa = ata_ignore_hpa || dev->flags & ATA_DFLAG_UNLOCK_HPA;
 	u64 sectors = ata_id_n_sectors(dev->id);
-	u64 native_sectors;
+	u64 native_sectors = 0 /* GCC */;
 	int rc;
 
 	/* do we need to do it? */
-- 
1.7.10.4

