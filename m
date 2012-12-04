From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ARM: ep93xx: convert ata_<foo>_printk() to ata_<foo>_<level>()
Date: Mon, 3 Dec 2012 23:30:55 -0500
Message-ID: <CAPgLHd9HNvAwOON4M6=0X8RZ8ghPKnsDP50k1eZH5GsFHRRJ+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:41038 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab2LDEa4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 23:30:56 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so503786qaq.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 20:30:55 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, prylowski@metasoft.pl
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Using ata_<foo>_<level>() instead of ata_<foo>_printk().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/pata_ep93xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index e056406..3982cef 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -822,8 +822,7 @@ static int ep93xx_pata_softreset(struct ata_link *al, unsigned int *classes,
 	rc = ep93xx_pata_bus_softreset(ap, devmask, deadline);
 	/* if link is ocuppied, -ENODEV too is an error */
 	if (rc && (rc != -ENODEV || sata_scr_valid(al))) {
-		ata_link_printk(al, KERN_ERR, "SRST failed (errno=%d)\n",
-				rc);
+		ata_link_err(al, "SRST failed (errno=%d)\n", rc);
 		return rc;
 	}
 
@@ -857,8 +856,7 @@ static void ep93xx_pata_drain_fifo(struct ata_queued_cmd *qc)
 
 	/* Can become DEBUG later */
 	if (count)
-		ata_port_printk(ap, KERN_DEBUG,
-				"drained %d bytes to clear DRQ.\n", count);
+		ata_port_dbg(ap, "drained %d bytes to clear DRQ.\n", count);
 
 }
 


