From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix ehc->i.action setting in ata_eh_autopsy()
Date: Mon, 3 Jul 2006 02:54:58 +0900
Message-ID: <20060702175458.GA6027@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.204]:2208 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964786AbWGBRyW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Jul 2006 13:54:22 -0400
Received: by wx-out-0102.google.com with SMTP id t10so446932wxc
        for <linux-ide@vger.kernel.org>; Sun, 02 Jul 2006 10:54:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ata_eh_autopsy() used to directly assign determined action mask to
ehc->i.action thus overriding actions set by some of nested analyze
functions.  This patch makes ata_eh_autopsy() add action masks just as
it's done in other places.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---
Jeff, this doesn't cause too much trouble but it would be nice to have
this fixed in #linus too.  Thanks.

 drivers/scsi/libata-eh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

fda815b4e76189eda0fb6e9fab60fe191c9e019a
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index f2f29a8..4a670db 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1346,7 +1346,7 @@ static void ata_eh_autopsy(struct ata_po
 
 	/* record autopsy result */
 	ehc->i.dev = failed_dev;
-	ehc->i.action = action;
+	ehc->i.action |= action;
 
 	DPRINTK("EXIT\n");
 }
-- 
1.3.2

