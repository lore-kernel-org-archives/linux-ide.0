From: Simon Que <sque@chromium.org>
Subject: [PATCH] ata: libata-core: initialize native_sectors in ata_hpa_resize()
Date: Wed, 16 Jan 2013 16:09:11 -0800
Message-ID: <1358381351-27898-1-git-send-email-sque@chromium.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f201.google.com ([209.85.213.201]:62874 "EHLO
	mail-ye0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757567Ab3AQAch (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2013 19:32:37 -0500
Received: by mail-ye0-f201.google.com with SMTP id r11so244735yen.2
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2013 16:32:36 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: msb@chromium.org, Simon Que <sque@chromium.org>

Signed-off-by: Simon Que <sque@chromium.org>
---
 drivers/ata/libata-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d2b18ea..b185db1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1324,7 +1324,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
 	bool unlock_hpa = ata_ignore_hpa || dev->flags & ATA_DFLAG_UNLOCK_HPA;
 	u64 sectors = ata_id_n_sectors(dev->id);
-	u64 native_sectors;
+	u64 native_sectors = 0;
 	int rc;
 
 	/* do we need to do it? */
-- 
1.7.8.6

