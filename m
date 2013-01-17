From: Simon Que <sque@chromium.org>
Subject: [PATCH v2] ata: libata-core: initialize native_sectors in ata_hpa_resize()
Date: Thu, 17 Jan 2013 10:30:19 -0800
Message-ID: <1358447419-4851-1-git-send-email-sque@chromium.org>
References: <50F7E92C.8070409 () mvista ! com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f202.google.com ([209.85.223.202]:47760 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab3AQShH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jan 2013 13:37:07 -0500
Received: by mail-ie0-f202.google.com with SMTP id s9so749041iec.5
        for <linux-ide@vger.kernel.org>; Thu, 17 Jan 2013 10:37:06 -0800 (PST)
In-Reply-To: <50F7E92C.8070409 () mvista ! com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@mvista.com, linux-ide@vger.kernel.org
Cc: msb@chromium.org, Simon Que <sque@chromium.org>

Eliminates a compiler warning about uninitialized variable.

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

