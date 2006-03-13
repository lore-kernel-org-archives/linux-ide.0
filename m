From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: use ata_dev_disable() in ata_bus_probe()
Date: Mon, 13 Mar 2006 17:12:33 +0900
Message-ID: <11422375532991-git-send-email-htejun@gmail.com>
References: <11422373402858-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:244 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932120AbWCMIMj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 03:12:39 -0500
Received: by wproxy.gmail.com with SMTP id 69so1342041wri
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:12:38 -0800 (PST)
In-Reply-To: <11422373402858-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

We may or may not disable a device after ata_dev_configure() fails.
Kill 'not supported, ignoring' message in ata_dev_configure() and use
ata_dev_disable() in ata_bus_probe().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

54e2f80b5190b3f94779c06cbfe722b4bfe9204a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 92c7c53..b7595bf 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1373,8 +1373,6 @@ static int ata_dev_configure(struct ata_
 	return 0;
 
 err_out_nosup:
-	printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
-	       ap->id, dev->devno);
 	DPRINTK("EXIT, err\n");
 	return rc;
 }
@@ -1443,7 +1441,7 @@ static int ata_bus_probe(struct ata_port
 		}
 
 		if (ata_dev_configure(ap, dev, 1)) {
-			dev->class++;	/* disable device */
+			ata_dev_disable(ap, dev);
 			continue;
 		}
 
-- 
1.2.4


