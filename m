From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] libata: use ata_dev_disable() in ata_bus_probe()
Date: Fri, 24 Mar 2006 15:25:31 +0900
Message-ID: <11431815312562-git-send-email-htejun@gmail.com>
References: <11431815303216-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:28104 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423171AbWCXGZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 01:25:36 -0500
Received: by zproxy.gmail.com with SMTP id o37so734491nzf
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 22:25:35 -0800 (PST)
In-Reply-To: <11431815303216-git-send-email-htejun@gmail.com>
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

cc1c133b0ab1a846987c042f2893d3b35f2e6220
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d1530b9..b08e79f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1363,8 +1363,6 @@ static int ata_dev_configure(struct ata_
 	return 0;
 
 err_out_nosup:
-	printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
-	       ap->id, dev->devno);
 	DPRINTK("EXIT, err\n");
 	return rc;
 }
@@ -1431,7 +1429,7 @@ static int ata_bus_probe(struct ata_port
 		}
 
 		if (ata_dev_configure(ap, dev, 1)) {
-			dev->class++;	/* disable device */
+			ata_dev_disable(ap, dev);
 			continue;
 		}
 
-- 
1.2.4


