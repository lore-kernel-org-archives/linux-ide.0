From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/27] libata: kill ata_chk_status() call from ata_dev_configure()
Date: Tue, 25 Mar 2008 22:16:43 +0900
Message-ID: <12064510264058-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:16439 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbYCYNRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:43 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2257948wra.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:43 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_configure() isn't tied to any controller interface except for
the probe debug message printing at the end of the function.  Kill the
message.

This is to help separating out SFF support from core layer.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5209d49..d253aeb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2369,9 +2369,6 @@ int ata_dev_configure(struct ata_device *dev)
 		}
 	}
 
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
-			__func__, ata_chk_status(ap));
 	return 0;
 
 err_out_nosup:
-- 
1.5.2.4

